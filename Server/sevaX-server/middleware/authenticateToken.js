const jwt = require('jsonwebtoken');

const authToken = async (req, res, next) => {
    //strip the token from the req header

    if (req.headers['authorization']) { //check if authorization parameter is available in req header
        const authHeader = req.headers["authorization"]; //eg authHeader: "Bearer asdclasdfcasdjfecmsadceclsd1323l3ml42lmedm"
        const token = authHeader && authHeader.split(" ")[1];

        // //if token was found then authenticate it
        try {
            const user = await jwt.verify(token, "AccessTokenSecret");
            req.user = user.email;
            next();
        } catch {
            res.status(403).json({ error: "Invalid or Expired Token" });
        }

    } else {
        res.status(401).json({ error: "You are not authorized, token not found" })
    }
}

module.exports = authToken;