<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
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
grid-template-columns: 7fr 1fr 1fr 1fr;
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
min-height: 416px;
}

body .content h1{
color: #5A5A5A;
margin: 0;
background-color: #EAEAEA;
border: 1px solid #707070;
padding: 15px 0;
}

body .content .box{
margin-top: 20px;
background-color: #959595;
border: 1px solid #707070;
padding: 15px 50px ;
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
table {
  border-collapse: collapse;
  width: 100%;
  border: 1px solid black;
  background-color: #FFFFFF;
}

th{
    font-weight: 400;
    font-size: 25px;
    padding: 10px;
    text-align: left;
    border: 0px solid black;
}
 td {
    text-align: left;
  padding: 10px;
  border: 0.5px solid black;
}
.table{
    margin-top: 10px;
}
</style>
</head>
<body>
<div class='header'>
<h1><a href='./PatientHome.jsp'><img src="./logo.png"></img> Secure Pharmacist</a></h1>
<div>
<a href='./Ordering.jsp'>Ordering</a>
</div>
<div>
<a href='./Tracking.jsp'>Tracking</a>
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
<%
String patientID = (String) session.getAttribute("patient_id");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("mysql://4U3mAakPtHpYiwK.root:dA02k2uNHQXPa5sq@gateway01.eu-central-1.prod.aws.tidbcloud.com:4000/healthcare","4U3mAakPtHpYiwK.root","dA02k2uNHQXPa5sq");
Statement s = con.createStatement();
ResultSet tracking = s.executeQuery("SELECT purchase.purchase_date, purchase.drug_id, purchase.quantity, drug.name FROM purchase INNER JOIN drug ON drug.id = purchase.drug_id WHERE purchase.patient_id = '"+patientID+"'");
%>
<div class='content'>
    <h1>Tracking Placed Orders</h1>
    <div class="box">
        <table class="table">
            <tr>
              <th>Medicine ID</th>
              <th>Medicine Name</th>
              <th>Quantity</th>
              <th>Date of Purchase</th>
            </tr>
          <%
          while(tracking.next()){
          %>
            <tr>
              <td><%=tracking.getString(2) %></td>
              <td><%=tracking.getString(4) %></td>
              <td><%=tracking.getString(3) %></td>
              <td><%=tracking.getString(1) %></td>
            </tr>
            <%
          }
            %>
          </table>
    </div>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>