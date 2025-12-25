<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/x-icon" href="./favicon.ico">
<meta charset="ISO-8859-1">
<title>Secure Pharmacist</title>
<style>
body{
margin: 0;
}

body .header{
display: grid;
grid-template-columns: 7fr 0.75fr 0.75fr 1fr 1.3fr 0.75fr ;
background-color: #707070;
color: #F5F5F5;
padding: 20px 40px;
}

body .header h1{
margin: 0;
font-size: 2.5rem;
}

body .header h1 a{
border: 0;
background-color: transparent;
color: #F5F5F5;
text-decoration: none;
}

body .header h1 a img{
width: 50px;
}

body .header div{
position: relative;
}

body .header div a{
text-decoration: none;
border: 1px solid #707070;
background-color: #FFFFFF;
padding: 7px 20px;
color: #898989;
position: absolute;
left: 50%;
top: 50%;
transform: translate(-50%, -50%);
}

body .header div a:hover{
background-color: #FFFFFFE0;
}

body .header div form{
display: inline;
}

body .header div form button{
text-decoration: none;
border: 1px solid #FFFFFF;
background-color: #FFFFFF15;
padding: 8px 20px;
color: #FFFFFF;
position: absolute;
left: 50%;
top: 50%;
transform: translate(-50%, -50%);
cursor: pointer;
}

body .header div form button:hover{
background-color: #FFFFFF55;
}

body .content{
padding: 71px 0;
}

body .content h1{
margin: 0;
text-align: center;
font-family: 'Monoton', cursive;
font-size: 4.5rem;
font-weight: 100;
}

body .content h2{
text-align: center;
font-family: 'Sacramento', cursive;
font-size: 2.5rem;
font-weight: 100;
margin: 0;
}

body .content h2 span{
font-size: 4.5rem;
padding: 10px;
font-family: 'Aladin', cursive;
}

body .content p{
text-align: center;
width: 30%;
margin: 45px auto 0;
font-size: 1.5rem;
font-family: 'League Spartan', sans-serif;
padding: 50px 60px;
background-color: #EAEAEA;
}

body .footer{
display: grid;
grid-template-columns: 2fr 1fr;
text-align: center;
background-color: #707070;
color: #F5F5F5;
}
</style>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Aladin&family=League+Spartan:wght@200&family=Monoton&family=Sacramento&display=swap" rel="stylesheet">
</head>
<body>
<div class='header'>
<h1><a href='./DoctorHome.jsp'><img src="./logo.png"></img> Secure Pharmacist</a></h1>
<div>
<a href='./Prescription.jsp'>Create</a>
</div>
<div>
<a href='./View.jsp'>View</a>
</div>
<div>
<a href='./Feedback.jsp'>Feedback</a>
</div>
<div>
<a href='./Recommendation.html'>Recommendation</a>
</div>
<div>
<form action="#" method="post">
<button type="submit" name="logout">Logout</button>
</form>
</div>
<%
if(request.getParameter("logout")!=null){
	session.invalidate();
	response.sendRedirect("Login.jsp");
}
%>
</div>
<div class='content'>
<h1>Secure Pharmacist</h1>
<h2><span>&#8216;</span>An Authentic Drug Recommendation System<span>&#8217;</span></h2>
<p>Here doctors can write prescriptions for patients using our Drug Recommendation System and view respective prescriptions of each of their patients given by them.</p>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>