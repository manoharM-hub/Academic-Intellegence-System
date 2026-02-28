/* ================= ROLE SELECT ================= */

let role = "student";

function selectRole(r){

role = r;

const note = document.getElementById("note");
const buttons = document.querySelectorAll(".roleButtons button");
const passField = document.getElementById("password");

/* reset button styles */
buttons.forEach(btn => {
  btn.style.background = "";
  btn.classList.remove("active");
});

/* highlight selected */
const idx = r==="student" ? 0 : r==="mentor" ? 1 : 2;
if(buttons[idx]) buttons[idx].classList.add("active");

if(r === "student"){
  note.innerText = "🎓 Welcome to Student Portal — Use your VTU ID and Password";
  passField.style.display = "block";
}

if(r === "mentor"){
  note.innerText = "👨‍🏫 Welcome to Mentor Portal — Use your TTS and password";
  passField.style.display = "block";
}

if(r === "parent"){
  note.innerText = "👪 Welcome to Parent Portal — Login using Student ID only";
  passField.style.display = "none";
}

document.getElementById("msg").innerText = "";
}



/* ================= LOGIN ================= */

function login(){

const id = document.getElementById("id").value.trim();
const password = document.getElementById("password").value.trim();

if(!id){
document.getElementById("msg").innerText = `Enter ${role} ID`;
return;
}

fetch(`http://localhost:3000/login/${role}`,{
method: "POST",
headers:{ "Content-Type":"application/json" },
body: JSON.stringify({ id, password })
})
.then(res=>res.json())
.then(data=>{

if(data.success){

/* ---------- STUDENT ---------- */
if(role === "student"){
localStorage.setItem("studentId", id);
window.location = "dashboard.html";
}

/* ---------- MENTOR ---------- */
else if(role === "mentor"){
localStorage.setItem("mentorId", data.user.id);
localStorage.setItem("mentorName", data.user.name);
localStorage.setItem("mentorDesignation", data.user.designation);
localStorage.setItem("mentorDepartment", data.user.department);
window.location = "mentor-dashboard.html";
}

/* ---------- PARENT ---------- */
else if(role === "parent"){
localStorage.setItem("parentId", id);
window.location = "parent-dashboard.html";
}

}
else{
document.getElementById("msg").innerText = "Invalid Login";
}

})
.catch(()=>{
document.getElementById("msg").innerText = "Server not running";
});

}



/* ================= PAGE LOAD ================= */

window.onload = function(){

const path = window.location.pathname;

/* =========================================================
   STUDENT DASHBOARD
========================================================= */

if(path.includes("dashboard.html") && !path.includes("mentor")){

const id = localStorage.getItem("studentId");
if(!id) return;

fetch("http://localhost:3000/student/"+id)
.then(res=>res.json())
.then(data=>{

if(!data) return;

const welcome = document.getElementById("welcome");
const info = document.getElementById("info");

if(welcome)
welcome.innerHTML = `Hi <b>${data.name}</b> (${data.id})`;

if(info)
info.innerHTML = `
Roll : ${data.roll}<br>
Branch : ${data.branch}<br>
Degree : ${data.degree}
`;

});

}



/* =========================================================
   MENTOR DASHBOARD
========================================================= */

if(path.includes("mentor-dashboard.html")){

const id = localStorage.getItem("mentorId");

if(!id){
alert("Login again");
window.location = "login.html";
return;
}

const name = localStorage.getItem("mentorName");
const designation = localStorage.getItem("mentorDesignation");
const department = localStorage.getItem("mentorDepartment");

const nameBox = document.getElementById("mentorName");
const roleBox = document.getElementById("mentorRole");

if(nameBox) nameBox.innerText = `Welcome, ${name}`;
if(roleBox) roleBox.innerText = `${designation} — ${department} Department`;

fetch("http://localhost:3000/mentor/"+id+"/students")
.then(res=>res.json())
.then(list=>{

let html = "";

if(list.length === 0){
html = "<p>No students assigned</p>";
}
else{
list.forEach(s=>{
html += `
<div class="studentBox" onclick="openStudent('${s.id}')">
${s.id} — ${s.name}
</div>`;
});
}

const container = document.getElementById("studentList");
if(container) container.innerHTML = html;

})
.catch(()=>{
const container = document.getElementById("studentList");
if(container) container.innerHTML = "Server error";
});

}

};



/* ================= OPEN STUDENT ================= */

function openStudent(id){
localStorage.setItem("viewStudent", id);
window.location = "mentor-student.html";
}



/* ================= LOGOUT ================= */

function logout(){
localStorage.clear();
window.location = "login.html";
}