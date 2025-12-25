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
padding: 80px;
text-align: center;
width: 60%;
margin: auto;
min-height: 415px;
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

body .content form div input[type=number],
body .content form div select{
background-color: #F5F5F5;
border: 0;
height: 50px;
margin-bottom: 20px;
padding-left: 40px;
outline: none;
border: 1px solid #707070;
}

body .content form div input[type=number]{
width: 35%;
}

body .content form div select{
width: 40%;
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
try{
if(request.getParameter("logout")!=null){
	session.invalidate();
	response.sendRedirect("Login.jsp");
}else{
%>
</div>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcare","root","");
Statement st = con.createStatement();
%>
<div class='content'>
<h1>Feedback On Medicines (Recommendation Purpose)</h1>
<form method="post" action="#">
<div>
<label>Drug Name: </label>
<select name="drug">
<option value="">Select a Drug</option>
<%
String sql = "SELECT * FROM drug";
ResultSet drugs = st.executeQuery(sql);
while(drugs.next()){
	%>
	<option value=<%=drugs.getString(1) %>><%=drugs.getString(2) %></option>
	<%
}
%>
</select>
</div>
<div>
<label>Condition Name: </label>
<select name="condition">
<option value="">Select a Condition</option>
<%
sql = "SELECT * FROM `condition`";
ResultSet conditions = st.executeQuery(sql);
while(conditions.next()){
	%>
	<option value=<%=conditions.getString(1) %>><%=conditions.getString(2) %></option>
	<%
}
%>
</select>
</div>
<div>
<label>Rating (1-10)</label>
<input name="rating" type="range" min="1" max="10" />
</div>
<div>
<input type='submit' name="submit" value='S U B M I T' />
</div>
</form>
<%
if(request.getParameter("submit") != null && request.getParameter("drug") != "" && request.getParameter("rating") != "" && request.getParameter("condition") != ""){
String drugID = request.getParameter("drug");
String conditionID = request.getParameter("condition");
String rating = request.getParameter("rating");
sql = "INSERT INTO `feedback`(`drug_id`, `condition_id`, `rating`) VALUES (?,?,?)";
PreparedStatement pst = con.prepareStatement(sql);
pst.setString(1, drugID);
pst.setString(2, conditionID);
pst.setString(3, rating);
pst.executeUpdate();
response.sendRedirect("./DoctorHome.jsp");
}
else if(request.getParameter("submit") != null && (request.getParameter("drug") == "" || request.getParameter("rating") == "")){
	%>
	<script>
		alert("Some option not selected properly!");
	</script>
	<%
}
}
}catch(Exception e){}
%>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>