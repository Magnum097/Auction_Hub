<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
<button style="font-size:14pt; background-color:#90D5EC; margin-top:1em; margin-bottom:1em;" onclick="window.location.href='ListOfItems.jsp';">Return to see Auction Items</button>
<br>
   
    <% 
    ApplicationDB database = new ApplicationDB();	
   	Connection connection = database.getConnection();
   	
   	Statement statement = connection.createStatement();
   	
   	String enduserID = (session.getAttribute("enduserID")).toString();
   	String name = "";
   	ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
    if(username.next())name = username.getString("name");
   	
    int itemID = Integer.parseInt(request.getParameter("similarItems"));
    out.println("Hello! " + name + ", All the items similar to the item with item ID " + itemID + " are:");
    
    //getting the information about isSneakers, isBoots, isSandals for the item
    ResultSet infoOfItem = statement.executeQuery("select s.name, s.isSneakers, s.isBoots, s.isSandals from shoes s where s.shoeID = '" + itemID + "'");
    //ResultSet infoOfItem = stmt.executeQuery("select s.name from auction a, shoes s where a.itemID='" + itemID + "' AND a.itemID=s.shoeID");
    
    String itemName = "";
    boolean isSneakers = false;
    boolean isBoots = false;
    boolean isSandals = false;
    
    if(infoOfItem.next()){
    	itemName = infoOfItem.getString("name");
    	isSneakers = infoOfItem.getBoolean("isSneakers");
    	isBoots = infoOfItem.getBoolean("isBoots");
    	isSandals = infoOfItem.getBoolean("isSandals");
    }
	    
	  
	 //IF THE PRESENT ITEM IS A Sneaker, GET ALL Sneakers FROM THE PREVIOUS MONTH
	 if(isSneakers){
		Statement stmt1 = connection.createStatement();
	    ResultSet prevMonthAuctions = stmt1.executeQuery("select * from shoes s, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=s.shoeID and s.isSneakers = true");
	    
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
	        <th>End Time</th>
	    </tr>
	</thead>
	<tbody>
	<% 
	while(prevMonthAuctions.next()){
		//print all items except the current item
		if(!itemName.equals(prevMonthAuctions.getString("name"))){
			out.print("<tr>");
			out.print("<td>");
			out.print(prevMonthAuctions.getInt("auctionId"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("color"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("size"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("material"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("companyOrBrand"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("initialPrice"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getTimestamp("closingDate"));
			out.print("</td>");
			out.print("<td>");
		}}
	}//IF THE PRESENT ITEM IS A Boot, GET ALL Boots FROM THE PREVIOUS MONTH
	 else if(isBoots){
		 Statement statement2 = connection.createStatement();
		 ResultSet prevMonthAuctions = statement2.executeQuery("select * from shoes s, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=s.shoeID and s.isBoots = true");
		    
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
		        <th>End Time</th>
		    </tr>
		</thead>
		<tbody>
		<% 
		while(prevMonthAuctions.next()){
			if(!itemName.equals(prevMonthAuctions.getString("name"))){
				out.print("<tr>");
				out.print("<td>");
				out.print(prevMonthAuctions.getInt("auctionId"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("name"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("color"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getDouble("size"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("material"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("companyOrBrand"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getDouble("initialPrice"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getTimestamp("closingDate"));
				out.print("</td>");
				out.print("<td>");
			}}
		 
	 }
	 else if(isSandals){
		 //IF THE PRESENT ITEM IS A Sandals, GET ALL Sandals FROM THE PREVIOUS MONTH
		 Statement statement3 = connection.createStatement();
		 ResultSet prevMonthAuctions = statement3.executeQuery("select * from shoes s, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=s.shoeID and s.isSandals = true");
		    
		    //Displaying Auction Info
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
		        <th>End Time</th>
		    </tr>
		</thead>
		<tbody>
		<% 
		while(prevMonthAuctions.next()){
			if(!itemName.equals(prevMonthAuctions.getString("name"))){
				out.print("<tr>");
				out.print("<td>");
				out.print(prevMonthAuctions.getInt("auctionId"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("name"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("color"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getDouble("size"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("material"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getString("companyOrBrand"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getDouble("initialPrice"));
				out.print("</td>");
				out.print("<td>");
				out.print(prevMonthAuctions.getTimestamp("closingDate"));
				out.print("</td>");
				out.print("<td>");
			}}
		 
		 
	 }
	 
	 connection.close();
	   %>
</body>
</html>