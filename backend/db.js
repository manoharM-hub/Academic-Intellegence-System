const mysql = require("mysql");

const db = mysql.createConnection({
  host: process.env.MYSQLHOST || "localhost",
  user: process.env.MYSQLUSER || "root",
  password: process.env.MYSQLPASSWORD || "2004",
  database: process.env.MYSQLDATABASE || "student_portal",
  port: process.env.MYSQLPORT || 3306
});

db.connect(err => {
  if (err) console.log(err);
  else console.log("MySQL Connected");
});

module.exports = db;