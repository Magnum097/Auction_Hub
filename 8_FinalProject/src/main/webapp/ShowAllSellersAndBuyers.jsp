<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show All Sellers and Buyers</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button> 
	<%@ page import ="java.sql.*" %>
	
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	
	ResultSet resultSetSellers;
	resultSetSellers = statement.executeQuery("select distinct a.sellerID, u.name from auction a, user u where u.userID = a.sellerID"); %>
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	
	th{
		background: #F0E1B9FF;
	}
	</style>
	
	<h1>All Sellers</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>Seller ID</th>
	        <th>Name</th>
	    </tr>
	</thead>
	<tbody>
	<%
	
	while(resultSetSellers.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(resultSetSellers.getString("sellerID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSetSellers.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='ShowAuctionsForEverySeller.jsp' method='post'><button style=background-color:#90D5EC name='sellerID' type='submit' value='"
				+ resultSetSellers.getString("sellerID") + "'> Show This Seller's Auctions</button></form>");
		out.print("</td>");
	}
	%>
	
	</tbody>
	</table>
	<%
	ResultSet resultSetBuyers;
	resultSetBuyers = statement.executeQuery("select distinct b.buyerID, u.name from bid b, user u where u.userID = b.buyerID"); %>
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	</style>
	<h1>All Buyers</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>Buyer ID</th>
	        <th>Name</th>
	    </tr>
	</thead>
	<tbody>
	<%
	
	while(resultSetBuyers.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(resultSetBuyers.getString("buyerID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSetBuyers.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='ShowAuctionsForEveryBuyer.jsp' method='post'><button style=background-color:#90D5EC name='buyerID' type='submit' value='"
				+ resultSetBuyers.getString("buyerID") + "'> Show This Buyer's Auctions</button></form>");
		out.print("</td>");
	}
	connection.close();
	%>

</body>
</html>