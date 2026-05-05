const mysql = require("mysql");

const db = mysql.createConnection({
  host: process.env.DB_HOST || process.env.MYSQLHOST || "localhost",
  user: process.env.DB_USER || process.env.MYSQLUSER || "root",
  password: process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || "2004",
  database: process.env.DB_NAME || process.env.MYSQLDATABASE || "student_portal",
  port: process.env.DB_PORT || process.env.MYSQLPORT || 3306
});

db.connect(err => {
  if (err) console.log("DB Error:", err);
  else console.log("MySQL Connected");
});

module.exports = db;