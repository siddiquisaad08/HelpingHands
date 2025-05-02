const mysql = require('mysql')

const db = mysql.createConnection({
    user: process.env.DB_USER,
    host: process.env.DB_SERVER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

db.connect(err=>{
    if(err){console.log(err)}
    else{console.log('Connected to MySQL Database')}
})

module.exports = db