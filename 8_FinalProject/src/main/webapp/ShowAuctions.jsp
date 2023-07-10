<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
 
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>List of All Auctions</title>
</head>

<body style = "background:#FAEBEFFF; font-size:15pt; font-family:optima;">
<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>
	<%@ page import ="java.sql.*" %>
	
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	
	ResultSet availableAuctions;
	availableAuctions = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID and a.closingDate > now() and a.openingDate < now()"); %>
	
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	  
	}
	
	th{
		background: #F0E1B9FF;
	}
	
	</style>
	
	<h1 style="font-size:27pt">Available Auctions</h1>
	<table style="width:100%">
		<thead>
		    <tr>
		        <th>auction ID</th>
		        <th>Name</th>
		        <th>Color</th>
		        <th>Size</th>
		        <th>Material</th>
		        <th>Company/Brand</th>
		        <th>Initial Price</th>
		        <th>Open Time</th>
		        <th>End Time</th>
		    </tr>
		</thead>
		
	<tbody>
	<%
	
	/* String materialType = request.getParameter("materialType");
	out.print(materialType);
	String purposeType = request.getParameter("purposeType"); */

	
	while(availableAuctions.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(availableAuctions.getInt("auctionId"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getString("color"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getDouble("size"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getString("material"));
		//out.print(materialType);
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getString("companyOrBrand"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getDouble("initialPrice"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getTimestamp("openingDate"));
		out.print("</td>");
		out.print("<td>");
		out.print(availableAuctions.getTimestamp("closingDate"));
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='MakeABid.jsp' method='post'><button style=background-color:#90D5EC name='auctionId' type='submit' value='"
				+ availableAuctions.getInt("auctionId") + "'> Make A Bid</button></form>");
		out.print("</td>");
	}
	%>
	
	</tbody>
	</table>
	
	<%
	Statement statement1 = connection.createStatement();
	ResultSet closedAuctions;
	closedAuctions = statement1.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID and a.closingDate < now()"); %>
	<style>
		table, th, td {
		  border: 1px solid black;
		  border-collapse: collapse;
		}
		
		th{
			background: #F0E1B9FF;
		}
	</style>
	
	<h1 style="font-size:27pt">Closed Auctions</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>auction ID</th>
	        <th>Name</th>
	        <th>Color</th>
	        <th>Size</th>
	        <th>Material</th>
	        <th>Company/Brand</th>
	        <th>Initial Price</th>
	        <th>Winner ID</th>
	        <th>Amount Item Has Been Sold For</th>
	        <th>Open Time</th>
	        <th>End Time</th>
	    </tr>
	</thead>
	<tbody>
	<%

	while(closedAuctions.next()){
		//getting the highestBid and the hiddenMinimumPrice
		double highestBid = closedAuctions.getDouble("HighestBid");
		double hiddenMinimumPrice = closedAuctions.getDouble("hiddenMinimumPrice");
		String highestBidderID = closedAuctions.getString("highestBidderID");
		out.print("<tr>");
		out.print("<td>");
		out.print(closedAuctions.getInt("auctionId"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getString("color"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getDouble("size"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getString("material"));
		//out.print(materialType);
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getString("companyOrBrand"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getDouble("initialPrice"));
		out.print("</td>");
		if(highestBid >= hiddenMinimumPrice){
			out.print("<td>");
			out.print(highestBidderID);
			out.print("</td>");
			out.print("<td>");
			out.print(highestBid);
			out.print("</td>");
		}
		else{
			out.print("<td>");
			out.print("NO WINNER");
			out.print("</td>");
			out.print("<td>");
			out.print("NO AMOUNT");
			out.print("</td>");
		}
		out.print("<td>");
		out.print(closedAuctions.getTimestamp("openingDate"));
		out.print("</td>");
		out.print("<td>");
		out.print(closedAuctions.getTimestamp("closingDate"));
		out.print("</td>");
	
	}
	%>
	</tbody>
	</table>
	<%
	ResultSet futureAuctions;
	Statement stmt2 = connection.createStatement();
	futureAuctions = stmt2.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID and a.openingDate > now()"); %>
	<style>
		table, th, td {
		  border: 1px solid black;
		  border-collapse: collapse;
		}
		th{
			background: #F0E1B9FF;
		}
	</style>
	
	<h1 style="font-size:27pt">Future Auctions</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>auction ID</th>
	        <th>Name</th>
	        <th>Color</th>
	        <th>Size</th>
	        <th>Material</th>
	        <th>Company/Brand</th>
	        <th>Initial Price</th>
	        <th>Open Time</th>
	        <th>End Time</th>
	    </tr>
	</thead>
	<tbody>
	<%
	
	while(futureAuctions.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(futureAuctions.getInt("auctionId"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getString("color"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getDouble("size"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getString("material"));
		//out.print(materialType);
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getString("companyOrBrand"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getDouble("initialPrice"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getTimestamp("openingDate"));
		out.print("</td>");
		out.print("<td>");
		out.print(futureAuctions.getTimestamp("closingDate"));
		out.print("</td>");
	
	}
	
	connection.close();
	%>

	</tbody>
</table>

</body>
</html>