const db = require("../config/dbConnection")



// Authenticate User for Login
exports.getAllNeedyRequests = async (req, res) => {
    let query =
        `select users.*, needy.* from users
    left join needy on needy.user_id=users.user_id
    where users.role_id=1 and needy.isVerified=0`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data for 'needy' at the moment" })
        }
        res.status(200).send(results)
    })
}

exports.getNoOfDonors = async (req, res) => {
    let query =
        `select count(user_id) as noOfDonors from users where users.role_id='2'`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data at the moment" })
        }
        res.status(200).send(results)
    })
}

exports.getDonorStats = async (req, res) => {
    let query =
        `select count(totalDonors.user_id) as totalDonors, count(donorsRegisteredToday.user_id) as noOfDonorsRegisteredToday from users
        left join (select users.* from users where users.role_id='2') as totalDonors on totalDonors.user_id=users.user_id
        left join (select users.* from users where users.role_id='2' and date(users.registrationTimeStamp)=current_date()) as donorsRegisteredToday on donorsRegisteredToday.user_id=users.user_id`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data at the moment" })
        }
        res.status(200).send(results)
    })
}


exports.getNeedyStats = async (req, res) => {
    let query =
        `select count(totalNeedy.user_id) as totalNeedy, count(needyRegisteredToday.user_id) as noOfNeedyRegisteredToday from users
        left join (select users.* from users where users.role_id=1) as totalNeedy on totalNeedy.user_id=users.user_id
        left join (select users.* from users where users.role_id=1 and date(users.registrationTimeStamp)=current_date()) as needyRegisteredToday on needyRegisteredToday.user_id=users.user_id`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data at the moment" })
        }
        res.status(200).send(results)
    })
}


exports.acceptNeedyRequest = async (req, res) => {
    const { needy_id } = req.body

    let query =
        `update needy set isVerified='1' where needy_id='${needy_id}'`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not update data at the moment" })
        }
        res.status(200).send(true)
    })
}


exports.rejectNeedyRequest = async (req, res) => {
    const { needy_id } = req.body
    let query =
        `update needy set isVerified='2' where needy_id='${needy_id}'`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not update data at the moment" })
        }
        res.status(200).send(true)
    })
}

exports.getAllNeedy = async (req, res) => {
    let query =
        `select users.*, needy.* from users
    left join needy on needy.user_id=users.user_id
    where users.role_id=1 and needy.isVerified!=0`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data for 'needy' at the moment" })
        }
        res.status(200).send(results)
    })
}

exports.getAllDonors = async (req, res) => {
    let query =
        `select users.* from users
    where users.role_id=2`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not fetch data for 'donor' at the moment" })
        }
        res.status(200).send(results)
    })
}


exports.disableUser = async (req, res) => {
    const {user_id} = req.body 
    let query =
        `update users set isActive='0' where user_id='${user_id}'`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not change status at the moment" })
        }
        res.status(200).send(results)
    })
}
exports.activateUser = async (req, res) => {
    const {user_id} = req.body 
    let query =
        `update users set isActive='1' where user_id='${user_id}'`

    db.query(query, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: "could not change status at the moment" })
        }
        res.status(200).send(results)
    })
}

