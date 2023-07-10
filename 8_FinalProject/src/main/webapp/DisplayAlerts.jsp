<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Auctions</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>
	<%@ page import ="java.sql.*" %>
	
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement1 = connection.createStatement();
	Statement statement2 = connection.createStatement();
	String enduserID = (session.getAttribute("enduserID")).toString();
	
	//-----------------------------------------------------------------------------------------------------------
	//Check the wishlist of the person
	ResultSet UserWishList = statement2.executeQuery("select * from wishesFor where enduserID = '" + enduserID + "'");
	
	while(UserWishList.next()){
		
		int itemID = UserWishList.getInt("shoeID");
		
		ResultSet availableAuctions;
		availableAuctions = statement1.executeQuery("select * from auction a where a.itemID = '" + itemID + "' and a.closingDate > now() and a.openingDate < now()");
		if(availableAuctions.next()){
		int auctionID = availableAuctions.getInt("auctionID");
		//check if the person is already a bidder in this auction
		Statement statement5 = connection.createStatement();
		ResultSet checkBidder = statement5.executeQuery("select * from bid where buyerID = '" + enduserID + "' and auctionID = '" + auctionID + "'");
		if(!checkBidder.next()){
	    String alert = "The item which you have added to your wishlist itemID: " + itemID + " is now available, see auctions page!";
	    String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
				+ "VALUES (?, ?, ?, ?)";
		PreparedStatement psAlert = connection.prepareStatement(insertAlert);
		psAlert.setString(1, enduserID);
		psAlert.setInt(2, auctionID);
		psAlert.setInt(3, itemID);
		psAlert.setString(4, alert);
	
		psAlert.executeUpdate();
		}}
	}
	
	//-----------------------------------------------------------------------------------------------------------
	//CHECK IF THE PERSON IS A WINNER IN ANY AUCTION
	//get all the auctions he participated -> only closed auctions
	Statement statement3 = connection.createStatement();
	ResultSet getAllClosedAuctions = statement3.executeQuery("select * from bid b, auction a where b.auctionID = a.auctionID and b.buyerID = '" + enduserID + "' and a.closingDate < now()");
	while(getAllClosedAuctions.next()){
		//FOR EACH AUCTION, CHECK IF THIS PERSON IS THE HIGHEST BIDDER
		//IF HE IS THE HIGHEST BIDDER, CHECK IF THE WINNER FOR THE AUCTION HAS ALREADY BEEN SET ONCE
		//IF IT IS SET, NO NEED TO SEND ANY ALERTS
		//IF IT IS NOT SET THEN CHECK IF THE HIGHEST BID > RESERVE
	  //IF IT IS THEN SEND AN ALERT
		//out.println("Entered here");
		//get the highestBidderID
		String highestBidderID = getAllClosedAuctions.getString("highestBidderID");
		int auctionID = getAllClosedAuctions.getInt("auctionID");
		int itemID = getAllClosedAuctions.getInt("itemID");
		double highestBid = getAllClosedAuctions.getDouble("HighestBid");
		double reservePrice = getAllClosedAuctions.getDouble("hiddenMinimumPrice");
		boolean isWinner = getAllClosedAuctions.getBoolean("isWinner");
		if(enduserID.equals(highestBidderID)){
			if(!isWinner){
	            if(highestBid >= reservePrice){
	          	//update isWinner
					  String isWinnerQuery = "update auction set isWinner = " + true + " where auctionID = '" + auctionID + "'";
					  statement1.executeUpdate(isWinnerQuery);
					//send an alert
					 String alert = "Congratulations! You have emerged as the winner in the auction '" + auctionID + "'";
					    String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
						PreparedStatement psAlert = connection.prepareStatement(insertAlert);
						psAlert.setString(1, enduserID);
						psAlert.setInt(2, auctionID);
						psAlert.setInt(3, itemID);
						psAlert.setString(4, alert);
	
						psAlert.executeUpdate();
				} 
				
			}
		}
	}
	//-----------------------------------------------------------------------------------------------------------
	ResultSet resultSet = statement1.executeQuery("select * from hasanalert h where enduserID = '" + enduserID + "'"); %>
	<style>
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	th{
		background: #F0E1B9FF;
	}
	</style>
	
	<h1>Your Alerts</h1>
	<table style="width:100%">
	<thead>
	  <tr>
	      <th>alert ID</th>
	      <th>Alert Message</th>
	  </tr>
	</thead>
	<tbody>
	<%
	
	while(resultSet.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(resultSet.getInt("alertID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getString("alertMessage"));
		out.print("</td>");
	}
	
	
	connection.close();
	%>
	
	</tbody>
	</table>


</body>
</html>