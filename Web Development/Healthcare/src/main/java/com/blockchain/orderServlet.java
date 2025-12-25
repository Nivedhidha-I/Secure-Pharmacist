package com.blockchain;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.regex.*;


public class orderServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter out = response.getWriter();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcare","root","");
			HttpSession session = request.getSession();  
			String patientID = (String) session.getAttribute("patient_id");
			Enumeration in = request.getParameterNames();
			while(in.hasMoreElements()) {
		        String paramName = in.nextElement().toString();
		        if(!paramName.contains("submit") && !(Pattern.matches("^0$", request.getParameter(paramName)))){
		        	String drugID = paramName;
		        	String quantity = request.getParameter(paramName);
		        	Transaction transaction = new Transaction(Long.parseLong(patientID), Long.parseLong(drugID) ,Long.parseLong(quantity));
		        	String sql = "SELECT * FROM `purchase` WHERE `id` = (SELECT MAX(`id`) FROM `purchase`)";
		        	Statement st = con.createStatement();
					ResultSet last_block = st.executeQuery(sql);
					Block block = null;
					Block previousBlock = null;
					if (!last_block.isBeforeFirst()) {
						block = new Block(0, transaction);
					}
					else {
						while(last_block.next()) {
							Transaction previousTransaction = new Transaction(Long.parseLong(last_block.getString("patient_id")), Long.parseLong(last_block.getString("drug_id")), last_block.getString("purchase_date"), Long.parseLong(last_block.getString("quantity")));
							previousBlock = new Block(Integer.parseInt(last_block.getString("previous_hash")), previousTransaction);
							block = new Block(previousBlock.hashCode(), transaction);
						}
					}
					
					sql = "INSERT INTO `purchase`(`patient_id`, `drug_id`, `quantity`, `previous_hash`) VALUES (?, ?, ?, ?)";
					PreparedStatement pst = con.prepareStatement(sql);
		        	pst.setLong(1, block.getTransactions().getPatientid());
		        	pst.setLong(2, block.getTransactions().getDrugid());
		        	pst.setLong(3, block.getTransactions().getQuantity());
		        	pst.setLong(4, block.getPreviousHash());
		        	pst.executeUpdate();
		        	
		        	sql = "UPDATE `patient_condition` SET `bought`=(`bought`+?) WHERE `patient_id`=? AND `drug_id`=?";
		        	pst = con.prepareStatement(sql);
		        	pst.setLong(1, (block.getTransactions().getQuantity()));
		        	pst.setString(2, patientID);
		        	pst.setLong(3, block.getTransactions().getDrugid());
		        	pst.executeUpdate();
				}
			}
		} catch(Exception e) {
			out.print(e);
		}
		response.sendRedirect("Ordering.jsp");
	}
}