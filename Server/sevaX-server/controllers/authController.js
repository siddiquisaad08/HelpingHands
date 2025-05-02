const db = require("../config/dbConnection")
const bcrypt = require("bcrypt")
const JWT = require("jsonwebtoken");

const saltRounds = 10;


const getAccessToken = (name, email, role_id) => {
    return JWT.sign(
        { name, email, role_id },
        "AccessTokenSecret", //has to create new and strong key and save as env variable
        { expiresIn: '20s' }
    )
}

const generateRefreshToken = (name, email, role_id) => {
    return JWT.sign(
        { name, email, role_id },
        "RefreshTokenSecret",  //has to create new and strong key and save as env variable
        { expiresIn: '2m' }
    )
}


// Authenticate User for Login
exports.login = async (req, res) => {
    const { email, password } = req.body

    console.log(email, ' - ', password);

    if (email && password) {
        let query = `select * from users where email=?`

        db.query(query, email, async (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Internal server error' })
            }

            console.log(result)

            if (result.length === 0) {
                res.status(400).json({ error: 'Invalid email or password' })
            } else {

                //compare the check if password matches
                let passwordMatched = await bcrypt.compare(password, result[0].password);

                if (!passwordMatched) {
                    res.status(400).json({ error: 'Invalid email or password' })
                } else {

                    //generate access token
                    const accessToken = getAccessToken(result[0].name, result[0].email, result[0].role_id)

                    //generate and save refresh token
                    const refreshToken = generateRefreshToken(result[0].name, result[0].email, result[0].role_id)


                    //save refresh token in database
                    db.query(
                        `insert into refresh_token (refresh_token) values ('${refreshToken}')`,
                        (err, inserted) => {
                            if (err) {
                                console.log(err);
                                res.status(500).json({ error: 'Internal server error' })
                            } else {
                                console.log({ accessToken, refreshToken, name: result[0].name, email: result[0].email, role_id: result[0].role_id });
                                res.status(200).json({ accessToken, refreshToken, user_id: result[0].user_id, name: result[0].name, email: result[0].email, role_id: result[0].role_id, isActive: result[0].isActive, profilePictureSrc: result[0].profilePictureSrc, phone: result[0].phone, address: result[0].address })
                            }
                        }
                    )


                }
            }


        })

    } else {
        res.status(400).json({ error: 'Please add both email and password' })
    }
};

exports.donorRegistration = async (req, res) => {
    const { name, phone, email, address, password } = req.body

    if (name !== '' || phone !== '' || email !== '' || address !== '' || password !== '') {     //means all the value are present
        //check if email is laready taken
        let emailCheckQuery = 'select user_id from users where email=?'
        db.query(emailCheckQuery, email, async (err, ids) => {
            if (err) {
                console.log(err);
                res.status(500).send('Could not register you at the moment, please try again later')
            }

            if (ids.length > 0) {
                res.status(400).json({ error: 'Email is already, use another email' })
            }
            else {

                //make password hash
                const salt = await bcrypt.genSalt(saltRounds);
                const hashedPassword = await bcrypt.hash(password, salt);

                //save user's data in database
                let insertUserQuery = `insert into users (name, password, email, phone, address, role_id, isActive) values ('${name}', '${hashedPassword}', '${email}', '${phone}', '${address}', '2', '1')`
                db.query(insertUserQuery, (err, result) => {
                    if (err) {
                        res.status(500).send('Could not register you at the moment, please try again later')
                        console.log(err);
                    }
                    console.log('result for user insert - ', result);
                    if (result.affectedRows > 0) {
                        res.status(200).send(true)
                    }
                })
            }
        })


    } else {
        res.status(500).json({ error: 'Insufficient data, cannot register donor' })
    }

}

exports.emailCheck = async (req, res) => {
    const { email } = req.body
    if (email) {
        let emailCheckQuery = 'select user_id from users where email=?'
        db.query(emailCheckQuery, email, (err, ids) => {
            if (err) {
                console.log(err);
                res.status(500).send('Could not register you at the moment, please try again later')
            }
            if (ids.length === 0) {
                res.status(200).send(true)
            } else {
                res.status(400).json({ error: 'User with same email already exist, please use other email' })
            }
        })
    }
}

exports.needyRegistration = async (req, res) => {
    const { name, phone, email, address, password, noOfFamilyMembers, totalEarningMembers, isHeadOfFamily, yearlyIncome, sourceOfIncome, rationCardType, noteForAdmin } = req.body
    console.log(req.files);
    const aadharCardFileSrc = `${req.files.aadharCardFile[0].destination}/${req.files.aadharCardFile[0].filename}`
    const rationCardFileSrc = `${req.files.rationCardFile[0].destination}/${req.files.rationCardFile[0].filename}`
    console.log(aadharCardFileSrc);
    console.log(rationCardFileSrc);
    if (name && phone && email && address && password && noOfFamilyMembers && totalEarningMembers && isHeadOfFamily && yearlyIncome && sourceOfIncome && rationCardFileSrc && aadharCardFileSrc) {    //means all the value are present
        //check if email is laready taken
        let emailCheckQuery = 'select user_id from users where email=?'
        db.query(emailCheckQuery, email, async (err, ids) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Could not register you at the moment, please try again later' })
            }

            if (ids.length > 0) {
                res.status(400).json({ error: 'Email is taken by other user, refresh and try with another email' })
            }
            else {

                //make password hash
                const salt = await bcrypt.genSalt(saltRounds);
                const hashedPassword = await bcrypt.hash(password, salt);

                db.beginTransaction(err => {
                    if (err) {
                        console.log(err);
                        res.status(500).json({ error: 'Could not register you at the moment, please try again later' })
                    }
                    let insertUserQuery = `insert into users (name, password, email, phone, address, role_id, isActive) values ('${name}', '${hashedPassword}', '${email}', '${phone}', '${address}', '1', '1')`
                    db.query(insertUserQuery, (error, result) => {
                        if (error) {
                            return db.rollback(() => {
                                console.log(error);
                                res.status(500).json({ error: 'Could not register you at the moment, please try again later' })
                            })
                        }
                        let insertNeedyQuery = `insert into needy (user_id, isHeadOfFamily, sourceOfIncome, noOfFamilyMembers, yearlyIncome, rationCardSrc, rationCardType, aadharCardSrc, isVerified, totalEarningMembersInFamily, noteForAdmin) VALUES ('${result.insertId}', '${isHeadOfFamily ? 1 : 0}', '${sourceOfIncome}', '${noOfFamilyMembers}', '${yearlyIncome}', '${rationCardFileSrc}', '${rationCardType}', '${aadharCardFileSrc}', '0', '${totalEarningMembers}', '${noteForAdmin}')`
                        db.query(insertNeedyQuery, (errors, results) => {
                            if (errors) {
                                return db.rollback(() => {
                                    console.log(errors);
                                    res.status(500).json({ error: 'Could not register you at the moment, please try again later' })
                                })
                            }
                            db.commit(error => {
                                if (error) {
                                    return db.rollback(() => {
                                        console.log(error);
                                        res.status(500).json({ error: 'Could not register you at the moment, please try again later' })
                                    })
                                }
                                console.log('Needy Added');
                                res.status(200).send(true)
                            })
                        })
                    })
                })
            }
        })


    } else {
        res.status(500).json({ error: 'Insufficient data, cannot register donor' })
    }

}


exports.getNeedyVerificationStatus = async (req, res) => {
    const { user_id } = req.body
    let query =
        `select isVerified from needy where user_id=${user_id}`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not log you in at the moment, please try again later" })
        }
        res.status(200).send(results)
    })
}