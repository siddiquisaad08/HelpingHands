const db = require("../config/dbConnection")

exports.getLatestRequests = async (req, res) => {
    const { limit, user_id } = req.body

    let query = `select item.item_id, item.name as item_name, item.description as item_description, item.pictureSrc as item_pictureSrc, users.name as needy_name, users.profilePictureSrc as needy_profilePictureSrc from item_requests
    left join users on users.user_id=item_requests.user_id
    left join item on item.item_id=item_requests.item_id
    where item_requests.item_id in (select item_id from item where user_id='${user_id}') and item_requests.request_status=0
    ${limit ? `limit ${limit}` : ''}`
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'Cannot fetch requests at the moment, please try again later' })
        }
        console.log("latest requests - ",result);
        res.status(200).send(result)
    })

}

exports.addItem = async (req, res) => {
    const { name, description, user_id } = req.body
    const fileSrc = `${req.file.destination}/${req.file.filename}`

    console.log(name, ' - ', description, ' - ', fileSrc);
    if (name !== '' || description !== '' || fileSrc !== '' || user_id !== '') {     //means all the value are present
        let insertItemQuery = `insert into item (name, description, pictureSrc, isActive, user_id) values ('${name}', '${description}', '${fileSrc}', '1', '${user_id}' )`
        db.query(insertItemQuery, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot add item at the moment, please try again later' })
            }

            res.status(200).send(true)
        })
    } else {
        res.status(500).json({ error: 'Insufficient data, cannot add item' })
    }

}

exports.allItemsOfDonor = async (req, res) => {
    const { user_id } = req.body

    console.log(user_id)

    if (user_id) {     //means all the value are present
        let query = `select delivery_details.delivery_id, delivery_details.needy_id, users.profilePictureSrc, users.name as needy_name, delivery_details.delivery_status, delivery_details.updated_at as delivered_on, (select count(item_requests.id) from item_requests where item_requests.item_id=item.item_id) as request_count, item.* from item
        left join delivery_details on delivery_details.item_id=item.item_id
        left join users on users.user_id=delivery_details.needy_id
        where item.user_id=? order by item.item_id desc`
        db.query(query, user_id, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot add item at the moment, please try again later' })
            }
            console.log(result);
            res.status(200).send(result)
        })
    } else {
        res.status(500).json({ error: 'Insufficient data, cannot add item' })
    }

}

exports.getItemDetails = async (req, res) => {
    const { item_id } = req.params

    console.log(item_id)

    if (item_id) {     //means all the value are present
        let query = `select * from item 
        where item_id=? order by item_id desc`
        db.query(query, item_id, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot get item at the moment, please try again later' })
            }

            res.status(200).send(result)
        })
    } else {
        res.status(500).json({ error: 'Cannot get item at the moment, please try again later' })
    }

}

exports.getItemRequestList = async (req, res) => {
    const { item_id } = req.body

    console.log(item_id)

    if (item_id) {     //means all the value are present
        let query = `select item_requests.*, users.name, users.profilePictureSrc, needy.aadharCardSrc, needy.sourceOfIncome, needy.noOfFamilyMembers, needy.yearlyIncome, needy.rationCardSrc, needy.isHeadOfFamily from item_requests 
        left join users on users.user_id=item_requests.user_id
        left join needy on needy.user_id=item_requests.user_id
        where item_requests.item_id=?`
        db.query(query, item_id, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot get item request list at the moment, please try again later' })
            }

            res.status(200).send(result)
        })
    } else {
        res.status(500).json({ error: 'Cannot get item request list at the moment, please try again later' })
    }
}

exports.getItemDeliveryStatus = async (req, res) => {
    const { item_id } = req.body
    if (item_id) {
        let fetchQuery = `select delivery_details.*, item.name as item_name, users.name, users.phone, users.email, users.profilePictureSrc, needy.sourceOfIncome, needy.noOfFamilyMembers, needy.yearlyIncome, needy.rationCardSrc, needy.isHeadOfFamily from delivery_details
        left join needy on needy.user_id=delivery_details.needy_id
        left join users on users.user_id=needy.user_id
        left join item on item.item_id=delivery_details.item_id
        where delivery_details.item_id=?`
        db.query(fetchQuery, item_id, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot accept request at the moment, please try again later' })
                return
            }
            res.send(result)
        })
    } else {
        res.status(500).json({ error: 'Cannot fetch delivery status, please try again later' })
    }
}


exports.selectNeedyForDelivery = async (req, res) => {
    const { needy_id, donor_id, item_id, delivery_address } = req.body

    console.log(needy_id, donor_id, item_id, delivery_address);

    if (needy_id !== '' && donor_id !== '' && item_id !== '' && delivery_address !== '') {
        //====> update request status for all the request on this item to rejected except for the user who is selected
        let addRejectedStatusQuery = "update item_requests set ??=? where ??=? and ??!=?"
        db.query(addRejectedStatusQuery,
            [
                "request_status",
                -1,
                "item_id",
                item_id,
                "user_id",
                needy_id
            ],
            (err, rejectedStatusResult) => {
                if (err) {
                    console.log(err);
                    return res.status(500).json({ error: 'Cannot accept request at the moment, please try again later' })
                }

                //====> update the request status to accepted for the selected needy
                let addAcceptedStatusQuery = "update item_requests set ??=? where ??=? and ??=?"
                db.query(addAcceptedStatusQuery,
                    [
                        "request_status",
                        1,
                        "item_id",
                        item_id,
                        "user_id",
                        needy_id
                    ],
                    (err, acceptedStatusResult) => {
                        if (err) {
                            console.log(err);
                            return res.status(500).json({ error: 'Cannot accept request at the moment, please try again later' })
                        }

                        //====> add delivery status in for this selected item
                        let deliveryCode = Math.floor(Math.random() * 900000) + 100000
                        let insertQuery = `insert into delivery_details (item_id, donor_id, needy_id, delivery_address, delivery_status, delivery_code) values ( ?, ?, ?, ?, ?, ? )`
                        db.query(
                            insertQuery,
                            [
                                item_id,
                                donor_id,
                                needy_id,
                                delivery_address,
                                0,
                                deliveryCode,
                            ],
                            (err, result) => {
                                if (err) {
                                    console.log(err);
                                    return res.status(500).json({ error: 'Cannot accept request at the moment, please try again later' })
                                }
                                res.send(true)
                            }
                        )
                    }
                )
            }
        )

    } else {
        res.status(500).json({ error: 'Cannot accept request at the moment, please try again later' })
    }
}

exports.confirmDelivery = async (req, res) => {
    const { delivery_id, delivery_code, user_id } = req.body
    console.log(delivery_id, " - ", delivery_code, " - ", user_id);
    if (delivery_id && delivery_code && user_id) {
        //check delivery code
        let checkCodeQuery = `select delivery_code from delivery_details where ??=? and ??=?`
        db.query(checkCodeQuery, ["delivery_id", delivery_id, "donor_id", user_id], (err, deliveryDetails) => {
            if (err) {
                console.log(err);
                return res.status(500).json({ error: 'Cannot confirm delivery at the moment, please try again later' })
            }
            console.log("delivery code - ", deliveryDetails[0].delivery_code);
            if (deliveryDetails[0].delivery_code !== parseInt(delivery_code)) {
                return res.status(400).json({ error: "Invalid delivery code" })
            }
            else {

                //update delivery details
                let confirmQuery = "update delivery_details set ??=? where ??=?"
                db.query(confirmQuery, ["delivery_status", 1, "delivery_id", delivery_id], (err, result) => {
                    if (err) {
                        console.log(err);
                        return res.status(500).json({ error: 'Cannot confirm delivery at the moment, please try again later' })
                    }

                    return res.send(true)
                })
            }
        })
    } else {
        res.status(500).json({ error: 'Cannot confirm delivery at the moment, please try again later' })
    }
}