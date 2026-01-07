<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/x-icon" href="./favicon.ico">
<meta charset="ISO-8859-1">
<title>Secure Pharmacist</title>
<link
	rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous"
/>
<style>
body{
margin: 0;
}

body .header{
display: grid;
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

body .content{
padding: 96px;
text-align: center;
width: 60%;
margin: auto;
}

body .content h1{
color: #5A5A5A;
margin: 0;
background-color: #EAEAEA;
border: 1px solid #707070;
padding: 15px 0;
}

body .content form{
margin-top: 20px;
background-color: #959595;
border: 1px solid #707070;
padding: 50px;
}

body .content form div{
position: relative;
} 

body .content form div .icon{
position: absolute;
top: 18px;
left: 34%;
color: #D1D1D1;
}

body .content form div input[type=number],
body .content form div input[type=password]{
background-color: #F5F5F5;
border: 0;
width: 30%;
height: 50px;
margin-bottom: 20px;
padding-left: 40px;
outline: none;
border: 1px solid #707070;
}

body .content form div input[type=number]::-webkit-inner-spin-button, 
body .content form div input[type=number]::-webkit-outer-spin-button { 
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    margin: 0; 
}

body .content form div input[type=submit]{
margin-top: 10px;
text-decoration: none;
border: 1px solid #FFFFFF;
background-color: #FFFFFF15;
padding: 8px 20px;
color: #FFFFFF;
cursor: pointer;
}

body .content form div input[type=submit]:hover{
background-color: #FFFFFF55;
}

body .footer{
display: grid;
grid-template-columns: 2fr 1fr;
text-align: center;
background-color: #707070;
color: #F5F5F5;
}
</style>
</head>
<body>
<div class='header'>
<h1><a href='./PatientHome.jsp'><img src="./logo.png"></img> Secure Pharmacist</a></h1>
</div>
<div class='content'>
<h1>Login</h1>
<form method="post" action="#">
<div>
<i class="fas fa-user icon"></i>
<input type='number' placeholder='Enter UserID' name='user' />
</div>
<div>
<i class="fas fa-lock icon"></i>
<input type='password' placeholder='Enter Password' name='pass' />
</div>
<div>
<input type='submit' value='L O G I N' />
</div>
</form>
<%
try{
	String userid = request.getParameter("user");
	String password = request.getParameter("pass");
	if(userid!="" && password !=""){
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("mysql://4U3mAakPtHpYiwK.root:dA02k2uNHQXPa5sq@gateway01.eu-central-1.prod.aws.tidbcloud.com:4000/healthcare","4U3mAakPtHpYiwK.root","dA02k2uNHQXPa5sq");
		Statement s1 = con.createStatement();
		ResultSet rs1 = s1.executeQuery("SELECT * FROM user");
		while(rs1.next()){
			String id = rs1.getString("id");
			String pass = rs1.getString("password");
			if(id.contains(userid) && pass.contains(password)){
				String type = rs1.getString("user_type_id");
				session.setAttribute("user_id",id);
				session.setAttribute("user_type",type);
				Statement s2 = con.createStatement();
				if(type.contains("2")){
					ResultSet rs2 = s2.executeQuery("SELECT id FROM patient WHERE user_id = '"+id+"'");
					while(rs2.next()){
						session.setAttribute("patient_id",rs2.getString("id"));
					}
					response.sendRedirect("./PatientHome.jsp");
				}
				else if(type.contains("3")){
					ResultSet rs2 = s2.executeQuery("SELECT * FROM doctor WHERE user_id = '"+id+"'");
					while(rs2.next()){
						session.setAttribute("doctor_id",rs2.getString("id"));
					}
					response.sendRedirect("./DoctorHome.jsp");
				}
			}
		}
	}
} catch(Exception e){}
%>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>