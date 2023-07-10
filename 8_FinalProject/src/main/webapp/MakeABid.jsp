<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Making a bid</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<button style="font-size:14pt; background-color:#90D5EC; margin-bottom:1em;" onclick="window.location.href='ShowAuctions.jsp';">Return to see the Auctions</button>

<% 

    ApplicationDB database = new ApplicationDB();	
   	Connection connection = database.getConnection();
   	
   	Statement statement = connection.createStatement();
   	
   	String enduserID = (session.getAttribute("enduserID")).toString();
   	String name = "";
   	ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
    if(username.next())name = username.getString("name");
   	
    int auctionID = Integer.parseInt(request.getParameter("auctionId"));
  
	ResultSet resultSet = statement.executeQuery("select sellerID, standardBiddingIncrement, initialPrice from auction a where a.auctionID = '" + auctionID + "'");
	resultSet.next();
	
	
	
		
   	if(enduserID.equals(resultSet.getString("sellerID"))){
		out.println("<br>You are the Seller. <br>Sellers cannot make a bid in the Auction");
	}
   	else{
   		out.println("<br>Make sure your standard bidding increment is equal or greater than: " + resultSet.getDouble("standardBiddingIncrement"));
   		out.println("<br>Initial Price of the auction item: " + resultSet.getDouble("initialPrice"));
      		
   		
   		ResultSet inTheBiddingTable = statement.executeQuery("select * from bid where buyerID='" + enduserID + "' and auctionID = '" + auctionID + "'");   		
   		
   		if(inTheBiddingTable.next()){
   			out.println("<br> your previous Bid Amount on	 the item: " + inTheBiddingTable.getFloat("currentBidAmount"));
   		}
  
   		
   		if(inTheBiddingTable.next()){
   		     boolean isAutoBid = inTheBiddingTable.getBoolean("isAutoBid");
   		     if(isAutoBid)out.println("<br>YOU ARE AN AUTOBIDDER, YOU CANNOT BID AGAIN!");
   		     else{
	
	session.setAttribute("auctionID", auctionID);
	
	
	
	%>
	
	<br>
		<form method="post" action="InsertBid.jsp">
		<table align=center style="text-align:left; margin-top:1em;">
		
			<tr>
			<td>Enter the Bidding Amount: </td><td><input type="number" step = "any" name="currentBidAmount" placeholder = "0.0" required></td>
			</tr>
			<tr>
			<td> Type of Bid:
			<select name = "type">
				<option>Manual</option>
				<option>Automatic</option>
			</select>
			</td>
			</tr>
			  <tr>
			  <td>Enter the Bidding Increment (For Automatic Bids ONLY): </td><td><input type="number" step = "any" name="bidIncrement" placeholder = "0.0" ></td>
			  </tr>
			  <tr>
			  <td>Enter the Upper Limit (For Automatic Bid ONLY): </td><td><input type="number" step = "any" name="upperLimit" placeholder = "0.0" ></td>
			  </tr>
		  </table>
	   	  <input type="submit" value="Add Bid!" style="font-size:16pt;">
	   
		</form>
	<br>
	
    <%}}else{
    	session.setAttribute("auctionID", auctionID);
    	
    %>
	
	<br>
		<form method="post" action="InsertBid.jsp">
		<table align=center style="text-align:left; margin-top:1em;">
		
				<tr>
				<td>Enter the Bidding Amount: </td><td><input type="number" step = "any" name="currentBidAmount" placeholder = "0.0" required></td>
				</tr>
				<tr>
				<td> Type of Bid:
				<select name = "type">
					<option>Manual</option>
					<option>Automatic</option>
				</select>
				</td>
				</tr>
				<tr>
				<td>Enter the Bidding Increment (For Automatic Bid ONLY): </td><td><input type="number" step = "any" name="bidIncrement" placeholder = "0.0" ></td>
				</tr>
				<tr>
				<td>Enter the Upper Limit (For Automatic Bid ONLY): </td><td><input type="number" step = "any" name="upperLimit" placeholder = "0.0" ></td>
				</tr>
		  </table>
	   	  <input type="submit" value="Add Bid!" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	   
		</form>
	<br>
	
    <%
    	
    	}
    }%>



</body>
</html>