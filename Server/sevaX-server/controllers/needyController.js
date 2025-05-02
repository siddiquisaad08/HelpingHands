const db = require("../config/dbConnection")


exports.getAllItemsOnDonation = async (req, res) => {
    const { limit, user_id } = req.body

    let query = `select item.*, users.profilePictureSrc, users.name as donor_name from item
    left join users on users.user_id=item.user_id
    where item.item_id NOT IN (select item_id from item_requests where user_id='${user_id}')
    order by item.creationTimestamp desc
    ${limit ? `limit ${limit}` : ''}
    `
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'Cannot not fetch items at the moment, please try again later' })
        }
        res.status(200).send(result)
    })

}

exports.getRequestStatusForItem = async (req, res) => {
    const { user_id, item_id } = req.body
    console.log(user_id, ' - ', item_id);

    if (user_id) {     //means all the value are present
        let query = `select item_requests.*, delivery_details.delivery_code, delivery_details.updated_at as delivered_at, delivery_details.delivery_status from item_requests 
        left join delivery_details on delivery_details.item_id=item_requests.item_id
        where item_requests.user_id=? and item_requests.item_id=?`
        db.query(query, [user_id, item_id], (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot fetch item status at the moment, please try again later' })
            }
            console.log(result);
            res.status(200).send(result)
        })
    } else {
        res.status(500).json({ error: 'Cannot fetch item status at the moment, please try again later' })
    }
}

exports.requestForItem = async (req, res) => {
    const { user_id, item_id, request_message } = req.body

    console.log('requesting for item - ', user_id)

    if (user_id) {     //means all the value are present
        let query = `insert into item_requests (item_id, user_id, request_message) values (?, ?, ?)`
        db.query(query, [item_id, user_id, request_message], (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).json({ error: 'Cannot add item at the moment, please try again later' })
            }
            else {
                res.send(true)
            }
        })
    } else {
        res.status(500).json({ error: 'Insufficient data, cannot add item' })
    }

}

exports.getAllRequestedItems = async (req, res) => {
    const { limit, user_id } = req.body

    let query = `select item.*, users.profilePictureSrc, users.name as donor_name, item_requests.request_status, item_requests.request_timestamp from item
    left join users on users.user_id=item.user_id
    left join item_requests on item_requests.item_id=item.item_id
    where item.item_id IN (select item_id from item_requests where user_id='${user_id}' and request_status!=1) and item_requests.user_id='${user_id}'
    ${limit ? `limit ${limit}` : ''}`
    console.log(query);
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'Cannot not fetch items at the moment, please try again later' })
        }
        res.status(200).send(result)
    })

}

exports.getAllAcceptedItems = async (req, res) => {
    const { limit, user_id } = req.body

    let query = `select item.*,delivery_details.delivery_code, delivery_details.updated_at as delivered_at, users.profilePictureSrc, users.name as donor_name, item_requests.request_status, delivery_details.delivery_status, item_requests.request_timestamp from item
    left join users on users.user_id=item.user_id
    left join item_requests on item_requests.item_id=item.item_id
    left join delivery_details on delivery_details.item_id=item.item_id
    where item.item_id IN (select item_id from item_requests where user_id='${user_id}' and request_status=1) and item_requests.user_id='${user_id}'
    ${limit ? `limit ${limit}` : ''}`
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'Cannot not fetch items at the moment, please try again later' })
        }
        res.status(200).send(result)
    })

}