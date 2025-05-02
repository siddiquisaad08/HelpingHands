const express = require('express')
const cors = require("cors")
const path = require('path');
require('dotenv').config()

const app = express()

app.use(express.json())
app.use(cors())
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

//routes
app.use("/auth", require("./routes/auth"));
app.use("/admin", require("./routes/admin"));
app.use("/users", require("./routes/users"));
app.use("/donor", require("./routes/donor"));
app.use("/needy", require("./routes/needy"));

app.get('/', (req, res) => {
    return res.status(200).json({ message: 'seva_x server is live' })
})

app.listen(5000, () => {
    console.log('Server started at port 5000')
})