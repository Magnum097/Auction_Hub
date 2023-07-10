<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Status of bidding</title>
</head>
<body align=center style="font-size:16pt; background-color:#FAEBEFFF;">


	<%
	ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();
		
	Statement stmt = connection.createStatement();
	
	String enduserID = (session.getAttribute("enduserID")).toString();
	String name = "";
	ResultSet username = stmt.executeQuery("select * from user where userID='" + enduserID + "'");
	if(username.next())name = username.getString("name");
		
	int itemID = Integer.parseInt(request.getParameter("statusOfBidding"));
	
	//available auctions
	ResultSet availableAuctions = stmt.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.closingDate > now() and a.openingDate < now()");
	
	//closed auctions
	Statement statement1 = connection.createStatement();
	ResultSet closedAuctions = statement1.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.closingDate < now()");
			
	//future auctions
	Statement statement2 = connection.createStatement();
	ResultSet futureAuctions = statement2.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.openingDate > now()");
			
	if(availableAuctions.next()){
		out.println("This auction item is NOW Available!");
		%><br>
		<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ShowAuctions.jsp';">Go To The Auctions</button>
		<br>
		<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ListOfItems.jsp';">Return To View Items</button>
		<% 
	}
	else if(closedAuctions.next()){
		out.println("This auction Item is NO LONGER Available!");
		%>
		<br>
		<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ListOfItems.jsp';">Return To View Items</button>
		<% 
		
	}
	else if(futureAuctions.next()){
		out.println("This auction item will be Available for bid in the FUTURE!");
		%>
		<br>
		<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ShowAuctions.jsp';">Go To The Auctions</button>
		<br>
		<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ListOfItems.jsp';">Return To View Items</button>
		<% 
		
	}
	
	
	%>

</body>
</html>