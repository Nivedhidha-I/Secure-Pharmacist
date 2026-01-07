<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Enumeration"%>
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
display: grid;
grid-template-columns: 1fr 1fr;
margin: 15px;
}

body .content h1{
color: #5A5A5A;
margin: 0;
background-color: #EAEAEA;
border: 1px solid #707070;
padding: 15px 0;
}

body .content h2{
text-align: center;
font-size: 30px;
color: #5A5A5A;
margin: 15px;
background-color: #ffffff;
padding: 15px
}

body .content .box{
margin-top: 20px;
background-color: #959595;
border: 1px solid #707070;
padding: 10px 50px 70px;
}

body .content>div{
width: 80%;
margin: auto;
}

body .content>div h1{
text-align: center;
}

input[type=submit]{
margin-top: 30px;
text-decoration: none;
border: 1px solid #FFFFFF;
background-color: #FFFFFF15;
padding: 8px 20px;
color: #FFFFFF;
cursor: pointer;
}

input[type=submit]:hover{
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
  margin-top: 10px;
}

th{
    font-weight: 400;
    font-size: 20px;
    padding: 10px;
    text-align: left;
    border: 0px solid black;
}
 td {
    text-align: left;
  padding: 10px;
  border: 0.5px solid black;
}

.cart form {
background-color: grey;
margin-top: 10px;
}

.cart form input[type=number]{
border-radius:50%;
border:none;
height:50px;
width:50px;
text-align:center;
font-size:25px;
margin: 15px;
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
else{
%>
</div>
<%
String patientID = (String) session.getAttribute("patient_id");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("mysql://4U3mAakPtHpYiwK.root:dA02k2uNHQXPa5sq@gateway01.eu-central-1.prod.aws.tidbcloud.com:4000/healthcare","4U3mAakPtHpYiwK.root","dA02k2uNHQXPa5sq");
Statement st = con.createStatement();
String sql = "SELECT `patient_condition`.`doctor_id`, `patient_condition`.`date`, `drug`.`name`, `condition`.`name`, `patient_condition`.`recommended`, `patient_condition`.`bought`, `patient_condition`.`drug_id` FROM `drug` INNER JOIN `patient_condition` ON `patient_condition`.`drug_id` = `drug`.`id` INNER JOIN `condition` ON `condition`.id = `patient_condition`.`condition_id` WHERE `patient_condition`.`patient_id` = '"+patientID+"'";
ResultSet prescription = st.executeQuery(sql);
%>
<div class='content'>
<div class='medicines'>
<h1>PRESCRIBED MEDICINES</h1>
<div class="box">
    <table>
        <tr>
          <th>Doctor ID</th>
          <th>Date</th>
          <th>Drug Name</th>
          <th>Condition Name</th>
          <th>Quantity Referred</th>
          <th>Quantity Left</th>
        </tr>
        <%
        while(prescription.next()){
        %>
          <tr>
          	<td><%=prescription.getString(1) %></td>
            <td><%=prescription.getString(2) %></td>
            <td><%=prescription.getString(3) %></td>
            <td><%=prescription.getString(4) %></td>
            <td><%=prescription.getString(5) %></td>
            <td><%=Integer.parseInt(prescription.getString(5)) - Integer.parseInt(prescription.getString(6)) %></td>
          </tr>
      <%
        }
      %>
      </table>
</div>
</div>
<div class='cart'>
<%
sql = "SELECT `drug`.`name`, `patient_condition`.`recommended`, `patient_condition`.`bought`, `patient_condition`.`drug_id` FROM `drug` INNER JOIN `patient_condition` ON `patient_condition`.`drug_id` = `drug`.`id` WHERE `patient_condition`.`patient_id` = '"+patientID+"'";;
ResultSet cart = st.executeQuery(sql);
%>
<h1>CART</h1>
    <form action="order" method="post">
    <%
    while(cart.next()){
    %>
      <div class="drug">
      	<label><%=cart.getString(1) %></label>
        <input type="number" name=<%=cart.getString(4) %> min="0" max=<%=Integer.parseInt(cart.getString(2)) - Integer.parseInt(cart.getString(3)) %> value="0" >
      </div>
      <%
    }
      %>
      <div>
        <input type="submit" name="submit" value="PURCHASE" />
      </div>
    </form>
    <%
    /* String sql2 = "INSERT INTO `purchase`(`patientID`, `drugID`, `quantity`, `hash`) VALUES (?, ?, ?, ?)";
    String sql3 = "UPDATE `patientcondition` SET `bought`=(`bought`+?) WHERE `patientID`=? AND `drugID`=?";
    if(request.getParameter("submit") != null){
    	Enumeration in = request.getParameterNames();
        while(in.hasMoreElements()) {
          String paramName = in.nextElement().toString();
          if(!paramName.contains("submit") && !(request.getParameter(paramName).contains("0"))){
        	 PreparedStatement pst1 = con.prepareStatement(sql2);
        	 pst1.setString(1, patientID);
        	 pst1.setString(2, paramName);
        	 pst1.setString(3, request.getParameter(paramName));
        	 pst1.executeUpdate();
        	 PreparedStatement pst2 = con.prepareStatement(sql3);
        	 pst2.setInt(1, (Integer.parseInt(request.getParameter(paramName))));
        	 pst2.setString(2, patientID);
        	 pst2.setString(3, paramName);
        	 pst2.executeUpdate();
          }
        }
        response.sendRedirect("./Ordering.jsp");
    } */
    
}
    %>
</div>
</div>
<div class='footer'>
<p>&#169; Copyrights Sri Ramachandra Engineering and Technology, SRIHER</p>
<p>By: Nivedhidha I</p>
</div>
</body>
</html>