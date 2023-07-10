<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logged in Successfully</title>
</head>
<body style = "background:#FAEBEFFF; font-size:15.5pt; font-family:optima; color:#00203FFF;">
	<div>
		<h1 style="font-family:Andale Mono;" align = center>
			User Dashboard
		</h1>
	</div>
<%
    if ((session.getAttribute("enduserID") == null)) {
%>
	<p style="font-size:16pt; position:relative; top:2px;" >
	<br>You are not logged in<br/>
	<a href="Login.jsp">Please Login</a>
	</p>
<%} else {

   	ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	Statement statement1 = connection.createStatement();
	String enduserID = (session.getAttribute("enduserID")).toString();
	String name = "";
	ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
	if(username.next())name = username.getString("name");
	
	ResultSet getAllParticipatedAuctions;
	
	getAllParticipatedAuctions = statement1.executeQuery("select b.buyerID, b.isAutoBid, b.bidIncrement, b.upperLimit, b.auctionID, b.currentBidAmount, a.HighestBid, a.highestBidderID from bid b, auction a where b.auctionID = a.auctionID and b.buyerID = '" + enduserID + "' and a.closingDate > now() and a.openingDate < now()");
	
	while(getAllParticipatedAuctions.next()){
		boolean isAutoBid = getAllParticipatedAuctions.getBoolean("isAutoBid");
		int auctionID = getAllParticipatedAuctions.getInt("auctionID");
		double currentBid = getAllParticipatedAuctions.getDouble("currentBidAmount");
		double highestBid = getAllParticipatedAuctions.getDouble("HighestBid"); 
		String highestBidID = getAllParticipatedAuctions.getString("highestBidderID");
				
		if(isAutoBid){
			
			//if the person autobidded on this auction
			//then check if the current bid is less than the highest bid
			double increment = getAllParticipatedAuctions.getDouble("bidIncrement");
			double upperLimit = getAllParticipatedAuctions.getDouble("upperLimit");
			//out.println(currentBid);
			//out.println(highestBid);
			if(currentBid <= highestBid && !(enduserID.equals(highestBidID))){
				
				//increment until your highestBid
				if(currentBid <= upperLimit){
				while((currentBid <= highestBid) && currentBid <= upperLimit){ 
					currentBid = currentBid + increment;
			}}
				
				//update the current bid
				String query = "update bid set currentBidAmount = " + currentBid + " where auctionID = '" + auctionID + "' and buyerID = '" + enduserID + "'";
					statement.executeUpdate(query);
					
                if(currentBid >= highestBid){
				
					String query1 = "update auction set HighestBid = " + currentBid + " where auctionID = '" + auctionID + "'";
					statement.executeUpdate(query1);
					String query2 = "update auction set highestBidderID = '" + enduserID + "' where auctionID = '" + auctionID + "'";
					statement.executeUpdate(query2);
				    //ALERT EXECUTION
				    ResultSet usersInAuction = statement.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
				    

				    //other than the present user
				    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autoidder please ignore this message.</b>";
				    while(usersInAuction.next()){
				    	 String thisUserID = usersInAuction.getString("buyerID");
				    	 int itemID = usersInAuction.getInt("itemID");
				    	if(!thisUserID.equals(enduserID)){
				    	//you need to insert an alert for each of the user except for the current user
				    	String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
				    	PreparedStatement psAlert = connection.prepareStatement(insertAlert);
				    	psAlert.setString(1, thisUserID);
						psAlert.setInt(2, auctionID);
						psAlert.setInt(3, itemID);
						psAlert.setString(4, alert);
					
						psAlert.executeUpdate();
				    	}
				    
				}
				    //ADDING CODE TO ALERT ALL THE AUTOBIDDERS IN CASE THE HIGHEST BID NOW IS GREATER THAN THEIR UPPER LIMIT
			    	 String alertAutoBidder = "For auction: " + auctionID + ", someone has placed a bid higher than your upper limit</b>";
			    	 //get all autobidders for this auction
			    	 Statement statement6 = connection.createStatement();
			    	 ResultSet allAutoBiddersInAuction = statement6.executeQuery("select * from bid b, auction a where a.auctionID = b.auctionID and a.auctionID = '" + auctionID + "' and b.type = 'Automatic'");
			    	 //for all autobidders check if the highest bid now is greater than the upperlimit
			    	 while(allAutoBiddersInAuction.next()){
			    		 String thisUserID = allAutoBiddersInAuction.getString("buyerID");
				    	 int itemID = allAutoBiddersInAuction.getInt("itemID");
				    	 if(!thisUserID.equals(enduserID)){
			    		 if(allAutoBiddersInAuction.getDouble("upperLimit") < allAutoBiddersInAuction.getDouble("HighestBid")){
			    			 //if it is less send an alert
			    			 String insertAlertAutoBid = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
										+ "VALUES (?, ?, ?, ?)";
						    	PreparedStatement psAlertAutoBid = connection.prepareStatement(insertAlertAutoBid);
						    	psAlertAutoBid.setString(1, thisUserID);
								psAlertAutoBid.setInt(2, auctionID);
								psAlertAutoBid.setInt(3, itemID);
								psAlertAutoBid.setString(4, alertAutoBidder);
							
								psAlertAutoBid.executeUpdate();
			    		 }}}
			    	 }
			}
		}
		
	}
	
	
%>

	<p  align=center style="font-family:Andale Mono; font-size:18pt; position:relative; top:2px;" >Welcome to BuyMe <i><%=name%>! </i> 
	
	<div class="frontend">
	
		<h2 style = "font-size:16pt;">Do you want to Sell an Item? </h2>
		<ul style = "list-style-position: inside;">
					<li><a href="CreateAnAuction.jsp">Create Auction</a></li>
					<li><a href="ShowAuctions.jsp">See all Auctions</a></li>
		</ul>
		

		<h2 style = "font-size:16pt;">Do you want to Make a Bid on an Item? </h2>
		<ul style = "list-style-position: inside;">
					<li><a href="ShowAuctions.jsp">Make a Bid</a></li>
		</ul>
		
		
		<h2 style = "font-size:16pt;">Do you want to browse history of bids? </h2>
		<ul style = "list-style-position: inside;">
					<li><a href="BidHistory.jsp">View History of Bids</a></li>
		</ul>
		
		
		<h2 style = "font-size:16pt;">Do you want to See Your Alerts? </h2>
		<ul style = "list-style-position: inside;">
					<li><a href="DisplayAlerts.jsp">See Alerts</a></li>
		</ul>
		
		<h2 style = "font-size:16pt;">Do you want to Sort And Search Items? </h2>
		<ul style = "list-style-position: inside;">
					<li><a href="SortItems.jsp">View Items based on a specific category</a></li>
		</ul>
		
		<h2 style = "font-size:16pt;">Do you want to view all sellers and buyers? </h2>
		<ul style = "list-style-position: inside;">
				<li><a href="ShowAllSellersAndBuyers.jsp">View all sellers and buyers</a></li>
		</ul>
		
		
		<h2 style = "font-size:16pt;"> Need some other help? </h2>
		<ul style = "list-style-position: inside;">
			<li><a href="AskQuestion.jsp">Speak with a Customer Representative</a></li>
		</ul>
		
		<h2 style = "font-size:16pt;"> Do you want to browse Questions and Answers? </h2>
		<ul style = "list-style-position: inside;">
			<li><a href="BrowseQandA.jsp">View All Questions and Answers</a></li>
			<li><a href="SearchBrowseQandA.jsp">Search for Questions</a></li>
		</ul>
		
		
		<h2 style = "font-size:16pt;">Do you want to see Item Related Information? </h2>
		<ul style = "list-style-position: inside;">
				<li><a href="ListOfItems.jsp">See List Of Items to Find Similar Items and Add To Wishlist</a></li>
		</ul>
		
	</div>
	
<%
connection.close();}
%>
<p><a href="Logout.jsp" >Logout</a></p>

</body>
</html>