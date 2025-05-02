const router = require("express").Router()
var db = require('../config/dbConnection')
const multer = require('multer');
const { addItem, allItemsOfDonor, getItemDetails, getItemRequestList, selectNeedyForDelivery, getItemDeliveryStatus, confirmDelivery, getLatestRequests } = require("../controllers/donorController");
const uuid = require('uuid').v4;


const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/items');
    },
    filename: function (req, file, cb) {
        const { originalname } = file
        const filename = `${uuid()}-${originalname}`
        req.customProperty = filename
        cb(null, filename);
    }
});

const upload = multer({ storage });

router.post('/addItem', upload.single('itemPicture'), addItem)
router.post('/getLatestRequests', getLatestRequests)

router.post('/items', allItemsOfDonor)

router.get('/item/:item_id', getItemDetails)

router.post('/item/requestList', getItemRequestList)
router.post('/item/deliveryStatus', getItemDeliveryStatus)
router.post('/item/acceptRequest', selectNeedyForDelivery)
router.post('/item/confirmDelivery', confirmDelivery)





module.exports = router