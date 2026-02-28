const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const db = require("./db");

const app = express();

app.use(cors());
app.use(bodyParser.json());

/* ================= STUDENT LOGIN ================= */
app.post("/login/student",(req,res)=>{
const {id,password}=req.body;

db.query(
"SELECT * FROM students WHERE id=? AND password=?",
[id,password],
(err,result)=>{
if(err) return res.send(err);

if(result.length>0)
res.send({success:true,user:result[0]});
else
res.send({success:false});
});
});


/* ================= MENTOR LOGIN ================= */
app.post("/login/mentor",(req,res)=>{
const {id,password}=req.body;

db.query(
"SELECT id,name,designation,department FROM mentors WHERE id=? AND password=?",
[id,password],
(err,result)=>{
if(err) return res.send(err);

if(result.length>0)
res.send({success:true,user:result[0]});
else
res.send({success:false});
});
});


/* ================= PARENT LOGIN (ID ONLY) ================= */
app.post("/login/parent",(req,res)=>{
const {id}=req.body;

db.query(
"SELECT * FROM students WHERE id=?",
[id],
(err,result)=>{
if(err) return res.send(err);

if(result.length>0)
res.send({success:true,user:result[0]});
else
res.send({success:false});
});
});




/* ================= GET STUDENT DETAILS ================= */
app.get("/student/:id",(req,res)=>{
db.query(
"SELECT * FROM students WHERE id=?",
[req.params.id],
(err,result)=>{
if(err) return res.send(err);
res.send(result[0]);
});
});


/* ================= SEMESTER RESULTS ================= */
app.get("/results/:id/:sem",(req,res)=>{
const {id,sem}=req.params;

db.query(
"SELECT * FROM student_results WHERE id=? AND semester=?",
[id,sem],
(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});


/* ================= ALL SEM RESULTS (CALCULATED %) ================= */
app.get("/results/:id/all",(req,res)=>{

db.query(
"SELECT semester, grade FROM student_results WHERE id=? ORDER BY semester",
[req.params.id],
(err,rows)=>{
if(err) return res.send(err);

let semMap={};

rows.forEach(r=>{
if(!semMap[r.semester]) semMap[r.semester]=[];

let point=0;

switch(r.grade){
case "S": point=10; break;
case "A": point=9; break;
case "B": point=8; break;
case "C": point=7; break;
case "D": point=6; break;
default: point=0;
}

semMap[r.semester].push(point);
});

let result=[];

for(let sem in semMap){

let arr=semMap[sem];
let avg=arr.reduce((a,b)=>a+b,0)/arr.length;
let percent=Math.round((avg/10)*100);

result.push({
semester:sem,
percentage:percent
});
}

res.send(result);
});
});


/* ================= ATTENDANCE ================= */
app.get("/attendance/:id/:sem",(req,res)=>{
const {id,sem}=req.params;

db.query(
"SELECT subject,attendance FROM student_attendance WHERE id=? AND semester=?",
[id,sem],
(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});


/* ================= MENTOR STUDENTS ================= */
app.get("/mentor/:id/students",(req,res)=>{
db.query(
`SELECT students.id,students.name
FROM mentor_students
JOIN students ON students.id = mentor_students.student_id
WHERE mentor_students.mentor_id = ?`,
[req.params.id],
(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});


/* ================= TOPPER STUDENT ================= */
app.get("/topper",(req,res)=>{

db.query(`
SELECT s.id, s.name,
AVG(
CASE r.grade
WHEN 'S' THEN 10
WHEN 'A' THEN 9
WHEN 'B' THEN 8
WHEN 'C' THEN 7
WHEN 'D' THEN 6
ELSE 0
END
) as avgScore
FROM students s
JOIN student_results r ON s.id = r.id
GROUP BY s.id
ORDER BY avgScore DESC
LIMIT 1
`,
(err,result)=>{
if(err) return res.send(err);
res.send(result[0]);
});

});


/* ================= SEND MESSAGE ================= */
app.post("/send-message",(req,res)=>{
const {student_id,mentor_id,parent_id,subject,message,sender_role}=req.body;

db.query(
`INSERT INTO parent_messages
(student_id,mentor_id,parent_id,subject,message,sender_role)
VALUES(?,?,?,?,?,?)`,
[student_id,mentor_id,parent_id,subject,message,sender_role],
(err)=>{
if(err) return res.send(err);
res.send({success:true});
});
});


/* ================= GET PARENT MESSAGES ================= */
app.get("/parent-messages/:studentId",(req,res)=>{
db.query(
"SELECT * FROM parent_messages WHERE student_id=? ORDER BY created_at DESC",
[req.params.studentId],
(err,result)=>{
if(err) return res.send(err);
res.send(result);
});
});


/* ================= SERVER ================= */
app.listen(3000,()=>{
console.log("Server running on http://localhost:3000");
});
