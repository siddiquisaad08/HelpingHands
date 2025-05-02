const router = require("express").Router()
const path = require("path");
var db = require('../config/dbConnection')
const authController = require('../controllers/authController')
const multer = require('multer');
const uuid = require('uuid').v4;


// const storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//         cb(null, 'uploads/aadharCards');
//     },
//     filename: function (req, file, cb) {
//         const { originalname } = file
//         const filename = `${uuid()}-${originalname}`
//         req.customProperty = filename
//         cb(null, filename);
//     }
// });

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (file.fieldname === 'aadharCardFile') {
            cb(null, 'uploads/aadharCards');
        } else if (file.fieldname === 'rationCardFile') {
            cb(null, 'uploads/rationCards');
        }
    },
    filename: function (req, file, cb) {
        const { originalname } = file
        const extension = path.extname(originalname)
        let filename = `${uuid()}-rationCard${extension}`
        if (file.fieldname === 'aadharCardFile') {
            filename = `${uuid()}-1aadharCard${extension}`
        } else if (file.fieldname === 'rationCardFile') {
            filename = `${uuid()}-1rationCard${extension}`
        }
        req.customProperty = filename
        cb(null, filename);
    }
});

const upload = multer({ storage });

router.post('/login', authController.login)

router.post('/register/emailCheck', authController.emailCheck)

router.post('/register/donor', authController.donorRegistration)

router.post('/register/needy', upload.fields([
    { name: "aadharCardFile" },
    { name: "rationCardFile" }
]), authController.needyRegistration)

router.post('/needy/verificationStatus', authController.getNeedyVerificationStatus)


module.exports = router