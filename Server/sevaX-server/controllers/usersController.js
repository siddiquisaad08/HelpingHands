const db = require("../config/dbConnection")
const fs = require("fs")
const bcrypt = require("bcrypt")
const saltRounds = 10;


exports.getMyDetails = async (req, res) => {
    const { user_id } = req.body
    if (user_id) {
        let query = 'select name, email, phone from users where user_id=?'
        db.query(query, user_id, (err, results) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Could not fetch profile details at the moment, please try again later' })
            }
            console.log('Profile details - ', results[0]);
            res.status(200).send(results[0])
        })
    } else {
        res.status(500).json({ error: 'Could not fetch profile details at the moment, please try again later' })
    }
}

exports.changeProfilePicture = async (req, res) => {
    const { user_id } = req.body

    if (user_id) {
        let selectSrcQuery = `select profilePictureSrc from users where user_id='${user_id}'`
        db.query(selectSrcQuery, (error, result) => {
            if (error) {
                console.log(error);
                res.status(500).json({ error: 'Could not update profile picture, please try again later' })
            }
            if (result[0].profilePictureSrc !== null || result[0].profilePictureSrc === '') {
                //delete current image
                console.log('Already have a profile picture so deleting that from server');
                fs.unlink(`${result[0].profilePictureSrc}`, error => {
                    if (error) {
                        console.log(error);
                        res.status(500).json({ error: 'Could not update profile picture, please try again later' })
                    }
                    else {
                        console.log('Uploading new profile picture src to db');
                        //upadate src in db
                        const fileSrc = `${req.file.destination}/${req.file.filename}`
                        let query = `update users set profilePictureSrc='${fileSrc}' where user_id='${user_id}'`
                        db.query(query, (err, results) => {
                            if (err) {
                                console.log(err);
                                res.status(500).json({ error: 'Could not update profile picture, please try again later' })
                            }
                            res.status(200).json({ profilePictureSrc: fileSrc })
                        })
                    }
                })
            }
            else {

                //upadate src in db
                console.log('Uploading new profile picture src to db');
                const fileSrc = `${req.file.destination}/${req.file.filename}`
                let query = `update users set profilePictureSrc='${fileSrc}' where user_id='${user_id}'`
                db.query(query, (err, results) => {
                    if (err) {
                        console.log(err);
                        res.status(500).json({ error: 'Could not update profile picture, please try again later' })
                    }
                    res.status(200).json({ profilePictureSrc: fileSrc })
                })
            }
        })




    } else {
        res.status(500).json({ error: 'Could not update profile picture, please try again later' })
    }
}

exports.updateProfile = async (req, res) => {
    const { oldValue, newValue, editingField, user_id } = req.body

    if (user_id && (editingField === 'name' || editingField === 'email' || editingField === 'phone' || editingField === 'address' || editingField === 'password')) {
        console.log(oldValue, ' - ', newValue, ' - ', editingField, ' - ', user_id);

        if (editingField === 'password') { //check if current password matches if it does then update the password
            const getPasswordQuery = `select password from users where user_id='${user_id}'`
            db.query(getPasswordQuery, async (err, result) => {
                if (err) {
                    console.log(err);
                    res.status(500).json({ error: 'Could not update profile, please try again later' })
                }
                else {
                    //compare the check if password matches
                    let passwordMatched = await bcrypt.compare(oldValue, result[0].password);

                    if (!passwordMatched) {
                        res.status(400).json({ fieldName: editingField, error: 'Current password in incorrect' })
                    } else {
                        //make password hash
                        const salt = await bcrypt.genSalt(saltRounds);
                        const hashedPassword = await bcrypt.hash(newValue, salt);

                        let updateQuery = `update users set password='${hashedPassword}' where user_id='${user_id}'`
                        db.query(updateQuery, (error, result) => {
                            if (error) {
                                console.log(error);
                                res.status(500).json({ error: 'Could not update profile, please try again later' })
                            }

                            res.status(200).send(true)
                        })
                    }
                }
            })
        }
        else if (editingField === 'email') {    //check if email is taken by some other user if not then update the email
            const checkEmailQuery = `select user_id from users where email='${newValue}'`
            db.query(checkEmailQuery, (err, ids) => {
                if (err) {
                    console.log(err);
                    res.status(500).json({ error: 'Could not update profile, please try again later' })
                }
                if (ids.length > 0) {
                    res.status(400).json({ fieldName: editingField, error: 'User with this email already exist, try other email' })
                } else {
                    let updateQuery = `update users set ${editingField}='${newValue}' where user_id='${user_id}'`
                    db.query(updateQuery, (error, result) => {
                        if (error) {
                            console.log(error);
                            res.status(500).json({ error: 'Could not update profile, please try again later' })
                        }

                        res.status(200).json({ updatedFieldName: editingField, newValue })
                    })
                }
            })
        }
        else {
            let updateQuery = `update users set ${editingField}='${newValue}' where user_id='${user_id}'`
            db.query(updateQuery, (error, result) => {
                if (error) {
                    console.log(error);
                    res.status(500).json({ error: 'Could not update profile, please try again later' })
                }

                res.status(200).json({ updatedFieldName: editingField, newValue })
            })
        }

    } else {
        res.status(500).json({ error: 'Unauthorized Access' })
    }
}
