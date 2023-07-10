<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>This Seller's Auctions</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">


<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em;" onclick="window.location.href='ShowAllSellersAndBuyers.jsp';">Return to view All Sellers and Buyers</button>
   
    <% 
    ApplicationDB database = new ApplicationDB();	
   	Connection connection = database.getConnection();
   	
   	Statement statement = connection.createStatement();

	
	String sellerID = request.getParameter("sellerID");
	ResultSet getAllAuctions;
	getAllAuctions = statement.executeQuery("select distinct s.name, auctionID from shoes s, auction a where s.shoeID = a.itemID and sellerID ='" + sellerID + "'");
	
	%>

	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	th{
		background: #F0E1B9FF;
	}
	</style>
	
	<h1>All Auctions</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>Auction ID</th>
	        <th>Name </th>
	    </tr>
	</thead>
	<tbody>
	<%
	while(getAllAuctions.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(getAllAuctions.getInt("auctionID"));
		out.print("</td>");
		out.print("<td>");
		out.print(getAllAuctions.getString("name"));
		out.print("</td>");
		out.print("</tr>");
	}	

	%>



</body>
</html>