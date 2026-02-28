const mysql=require("mysql");

const db=mysql.createConnection({
host:"localhost",
user:"root",
password:"2004",
database:"student_portal"
});

db.connect(err=>{
if(err) console.log(err);
else console.log("MySQL Connected");
});

module.exports=db;
