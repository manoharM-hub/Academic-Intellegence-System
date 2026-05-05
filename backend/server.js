const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const db = require("./db");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use("/uploads", express.static("uploads"));

/* ================= MULTER SETUP ================= */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "./uploads";
    if(!fs.existsSync(dir)) fs.mkdirSync(dir);
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const studentId = req.body.studentId || "unknown";
    const ext = path.extname(file.originalname).toLowerCase();
    cb(null, studentId + ext);
  }
});

const upload = multer({
  storage,
  limits: { fileSize: 5 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    const allowed = ['.pdf', '.doc', '.docx'];
    const ext = path.extname(file.originalname).toLowerCase();
    if(allowed.includes(ext)) cb(null, true);
    else cb(new Error("Invalid file type. Only PDF, DOC, DOCX allowed."));
  }
});

/* ================= STUDENT LOGIN ================= */
app.post("/login/student",(req,res)=>{
const {id,password}=req.body;
db.query("SELECT * FROM students WHERE id=? AND password=?",[id,password],(err,result)=>{
if(err) return res.send(err);
if(result.length>0) res.send({success:true,user:result[0]});
else res.send({success:false});
});
});

/* ================= MENTOR LOGIN ================= */
app.post("/login/mentor",(req,res)=>{
const {id,password}=req.body;
db.query("SELECT id,name,designation,department FROM mentors WHERE id=? AND password=?",[id,password],(err,result)=>{
if(err) return res.send(err);
if(result.length>0) res.send({success:true,user:result[0]});
else res.send({success:false});
});
});

/* ================= PARENT LOGIN ================= */
app.post("/login/parent",(req,res)=>{
const {id}=req.body;
db.query("SELECT * FROM students WHERE id=?",[id],(err,result)=>{
if(err) return res.send(err);
if(result.length>0) res.send({success:true,user:result[0]});
else res.send({success:false});
});
});

/* ================= GET STUDENT DETAILS ================= */
app.get("/student/:id",(req,res)=>{
db.query("SELECT * FROM students WHERE id=?",[req.params.id],(err,result)=>{
if(err) return res.send(err);
res.send(result[0]);
});
});

/* ================= SEMESTER RESULTS ================= */
app.get("/results/:id/:sem",(req,res)=>{
const {id,sem}=req.params;
db.query("SELECT * FROM student_results WHERE id=? AND semester=?",[id,sem],(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});

/* ================= UNIT RESULTS ================= */
app.get("/unit-marks/:id/:sem",(req,res)=>{
const {id,sem}=req.params;
db.query("SELECT * FROM student_unit_marks WHERE id=? AND semester=?",[id,sem],(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});

/* ================= ALL SEM RESULTS ================= */
app.get("/results/:id/all",(req,res)=>{
db.query("SELECT semester, grade FROM student_results WHERE id=? ORDER BY semester",[req.params.id],(err,rows)=>{
if(err) return res.send(err);
let semMap={};
rows.forEach(r=>{
if(!semMap[r.semester]) semMap[r.semester]=[];
let point=0;
switch(r.grade){
case "S": point=10; break; case "A": point=9; break;
case "B": point=8; break; case "C": point=7; break;
case "D": point=6; break; default: point=0;
}
semMap[r.semester].push(point);
});
let result=[];
for(let sem in semMap){
let arr=semMap[sem];
let avg=arr.reduce((a,b)=>a+b,0)/arr.length;
let percent=Math.round((avg/10)*100);
result.push({semester:sem,percentage:percent});
}
res.send(result);
});
});

/* ================= ATTENDANCE ================= */
app.get("/attendance/:id/:sem",(req,res)=>{
const {id,sem}=req.params;
const sql=`SELECT course_code,course_name,total_hours,present_hours,absent_hours FROM student_attendance WHERE id=? AND semester=?`;
db.query(sql,[id,sem],(err,result)=>{
if(err){console.log(err);return res.json([]);}
res.json(result);
});
});

/* ================= MENTOR STUDENTS ================= */
app.get("/mentor/:id/students",(req,res)=>{
db.query(`SELECT students.id,students.name FROM mentor_students JOIN students ON students.id=mentor_students.student_id WHERE mentor_students.mentor_id=?`,[req.params.id],(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});

/* ================= TOPPER STUDENT ================= */
app.get("/topper",(req,res)=>{
db.query(`SELECT s.id,s.name,AVG(CASE r.grade WHEN 'S' THEN 10 WHEN 'A' THEN 9 WHEN 'B' THEN 8 WHEN 'C' THEN 7 WHEN 'D' THEN 6 ELSE 0 END) as avgScore FROM students s JOIN student_results r ON s.id=r.id GROUP BY s.id ORDER BY avgScore DESC LIMIT 1`,(err,result)=>{
if(err) return res.send(err);
res.send(result[0]);
});
});

/* ================= SEND MESSAGE ================= */
app.post("/send-message",(req,res)=>{
const {student_id,mentor_id,parent_id,subject,message,sender_role}=req.body;
db.query(`INSERT INTO parent_messages(student_id,mentor_id,parent_id,subject,message,sender_role) VALUES(?,?,?,?,?,?)`,[student_id,mentor_id,parent_id,subject,message,sender_role],(err)=>{
if(err) return res.send(err);
res.send({success:true});
});
});

/* ================= GET PARENT MESSAGES ================= */
app.get("/parent-messages/:studentId",(req,res)=>{
db.query("SELECT * FROM parent_messages WHERE student_id=? ORDER BY created_at DESC",[req.params.studentId],(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});

/* ================= UPLOAD RESUME ================= */
app.post("/upload-resume",upload.single("resume"),(req,res)=>{
if(!req.file) return res.json({success:false,message:"No file uploaded"});
const studentId=req.body.studentId;
const filename=req.file.filename;
db.query("UPDATE students SET resume_file=? WHERE id=?",[filename,studentId],(err)=>{
if(err){console.log(err);return res.json({success:false});}
res.json({success:true,filename});
});
});

/* ================= GET STUDENT RESUME ================= */
app.get("/resume/:studentId",(req,res)=>{
db.query("SELECT resume_file FROM students WHERE id=?",[req.params.studentId],(err,result)=>{
if(err||!result.length) return res.json({resume:null});
res.json({resume:result[0].resume_file});
});
});

/* ================= GET MENTOR STUDENTS WITH RESUMES ================= */
app.get("/mentor/:id/resumes",(req,res)=>{
db.query(`SELECT students.id,students.name,students.resume_file FROM mentor_students JOIN students ON students.id=mentor_students.student_id WHERE mentor_students.mentor_id=?`,[req.params.id],(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});

/* ================= ADD EVENT ================= */
app.post("/add-event",(req,res)=>{
const {mentor_id,title,description,event_date,event_time,venue}=req.body;
db.query(
`INSERT INTO events(mentor_id,title,description,event_date,event_time,venue) VALUES(?,?,?,?,?,?)`,
[mentor_id,title,description,event_date,event_time,venue],
(err)=>{
if(err){console.log(err);return res.json({success:false});}
res.json({success:true});
});
});

/* ================= GET ALL EVENTS ================= */
app.get("/events",(req,res)=>{
db.query(
"SELECT * FROM events ORDER BY created_at DESC",
(err,result)=>{
if(err){console.log(err);return res.json([]);}
res.json(result);
});
});

/* ================= GET EVENTS BY MENTOR ================= */
app.get("/events/:mentorId",(req,res)=>{
db.query(
"SELECT * FROM events WHERE mentor_id=? ORDER BY created_at DESC",
[req.params.mentorId],
(err,result)=>{
if(err){console.log(err);return res.json([]);}
res.json(result);
});
});

/* ================= DELETE EVENT ================= */
app.delete("/event/:id",(req,res)=>{
db.query(
"DELETE FROM events WHERE id=?",
[req.params.id],
(err)=>{
if(err){console.log(err);return res.json({success:false});}
res.json({success:true});
});
});

/* ================= SERVER ================= */
app.listen(3000,()=>{
console.log("Server running on http://localhost:3000");
});