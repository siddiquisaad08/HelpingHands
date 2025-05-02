

const needyRegistrationFileUploadMiddleware = (req, res, next) => {
    console.log("here");
    console.log(req.files);
    res.status(500).json({ error: 'Insufficient data, cannot register donor' })
}

module.exports = { needyRegistrationFileUploadMiddleware };