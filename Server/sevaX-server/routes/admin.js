const router = require("express").Router()
var db = require('../config/dbConnection')
const { getDonorStats, getNeedyStats, getAllNeedyRequests, acceptNeedyRequest, rejectNeedyRequest, getAllDonors, getAllNeedy, disableUser, activateUser } = require("../controllers/adminController")

router.get('/needyRequests', getAllNeedyRequests)

router.get('/donorStats', getDonorStats)

router.get('/needyStats', getNeedyStats)

router.post('/acceptNeedyRequest', acceptNeedyRequest)

router.post('/rejectNeedyRequest', rejectNeedyRequest)

router.get('/allDonors', getAllDonors)

router.get('/allNeedy', getAllNeedy)

router.post('/disableUser', disableUser)

router.post('/activateUser', activateUser)




module.exports = router