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
min-height: 576px;
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
height: 35px;
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
<%
try{
	String docid = (String)session.getAttribute("doctor_id");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("mysql://4U3mAakPtHpYiwK.root:dA02k2uNHQXPa5sq@gateway01.eu-central-1.prod.aws.tidbcloud.com:4000/healthcare","4U3mAakPtHpYiwK.root","dA02k2uNHQXPa5sq");
%>
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
<div class="content">
<h1>Prescription Maker</h1>
<div>
<form action='#' method='post'>
<div>
<label>Patient ID: </label>
<select name="pid" >
<option value="">Select the Patient</option>
<%
Statement st = con.createStatement();
String sql = "SELECT id, name FROM patient";
ResultSet patients = st.executeQuery(sql);
while(patients.next()){
%>
<option value=<%=patients.getString(1) %>><%=patients.getString(1) %>. <%=patients.getString(2) %></option>
<%
}
%>
</select>
</div>
<div>
<label>Condition: </label>
<select name="condition" id="condition">
<option value="">Select the Condition</option>
<%
sql = "SELECT * from `condition`";
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
<label>Drug Name: </label>
<select name="drug" id="drug">
<option value="">Select the Drug</option>
<%
sql = "SELECT * from drug";
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
<label>Quantity: </label>
<input type="number" name="quantity" placeholder="Enter Quantity" />
</div>
<div>
<input type="submit" name="submit" value="Submit" />
</div>
</form>
</div>
<%
	if(request.getParameter("submit")!=null && request.getParameter("condition")!="" && request.getParameter("drug")!="" && request.getParameter("quantity")!=null){
		String sql2 = "INSERT INTO `patient_condition`(`patient_id`, `doctor_id`, `drug_id`, `condition_id`, `recommended`, `bought`) VALUES (?,?,?,?,?,0)";
		PreparedStatement pst = con.prepareStatement(sql2);
		pst.setString(1, request.getParameter("pid"));
		pst.setString(2, docid);
		pst.setString(3, request.getParameter("drug"));
		pst.setString(4, request.getParameter("condition"));
		pst.setString(5, request.getParameter("quantity"));
		pst.executeUpdate();
	}
}catch(Exception e){
}
%>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>