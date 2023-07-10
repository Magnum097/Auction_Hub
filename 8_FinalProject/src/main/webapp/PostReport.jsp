<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">


<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='GenerateSalesReport.jsp';">Go Back</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();
		Statement stmt = connection.createStatement();
		String type = request.getParameter("type");
		
		
		boolean totalEarnings = request.getParameter("totalEarnings") != null;
		boolean earningsPerItem = request.getParameter("earningsPerItem") !=null;
		boolean earningsPerItemType = request.getParameter("earningsPerItemType") !=null;
		boolean earningsPerEndUser = request.getParameter("earningsPerEndUser") !=null;
		boolean bestSellingItems = request.getParameter("bestSellingItems") !=null;
		boolean bestBuyers = request.getParameter("bestBuyers") !=null;
		
		if(totalEarnings==true){
			
			ResultSet finalEarnings;
			finalEarnings = stmt.executeQuery("select SUM(HighestBid) from auction where CURRENT_TIMESTAMP>closingDate"); 
			finalEarnings.next();
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
			<h1>Total Earnings</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Total Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
			<%
				out.print("<tr>");
				out.print("<td>");
				out.print(finalEarnings.getFloat(1));
				out.print("</td>");
			%>

			</tbody>
			</table>
			<% 
		}
		
		if(earningsPerItem==true){
			ResultSet earningsperItem;
			earningsperItem = stmt.executeQuery("select a.itemID, a.HighestBid, s.name from auction a, shoes s where CURRENT_TIMESTAMP>closingDate AND a.auctionID=s.shoeID");
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
			<h1>Total Earnings Per Item</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Amount</th>
			    </tr>
			</thead>
			<tbody>
			
			<% 
			while(earningsperItem.next()){
				out.print("<tr>");
				out.print("<td>");
				out.print(earningsperItem.getInt("itemID"));
				out.print("</td>");
				out.print("<td>");
				out.print(earningsperItem.getString("s.name"));
				out.print("</td>");
				out.print("<td>");
				out.print(earningsperItem.getFloat("HighestBid"));
				out.print("</td>");
			
			}
			
		}
		
		if(earningsPerItemType==true){
			ResultSet resultSet2;
			ResultSet resultSet3;
			ResultSet resultSet4;
			resultSet2 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, shoes s where a.itemID=s.shoeID AND s.isSneakers=true");
			resultSet2.next();
			float sneakers = resultSet2.getFloat(1);
			resultSet3 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, shoes s where a.itemID=s.shoeID AND s.isBoots=true");
			resultSet3.next();
			float boots = resultSet3.getFloat(1);
			resultSet4 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, shoes s where a.itemID=s.shoeID AND s.isSandals=true");
			resultSet4.next();
			float sandals = resultSet4.getFloat(1);
		
		%>
		</tbody>
			</table>
			<style>
				table, th, td {
				  border: 1px solid black;
				  border-collapse: collapse;
				}
				th{
					background: #F0E1B9FF;
				}
			</style>
			
			<h1>Total Earnings Per Type of Item</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item Type</th>
			        <th>Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
			<%
				out.print("<tr>");
				out.print("<td>");
				out.print("Sneakers");
				out.print("</td>");
				out.print("<td>");
				out.print(sneakers);
				out.print("<tr>");
				out.print("<td>");
				out.print("Boots");
				out.print("</td>");
				out.print("<td>");
				out.print(boots);
				out.print("<tr>");
				out.print("<td>");
				out.print("Sandals");
				out.print("</td>");
				out.print("<td>");
				out.print(sandals);
				out.print("</td>");
		
			%>

			</tbody>
			</table>
		
		<%
		}
		
		if(earningsPerEndUser==true){
			ResultSet earningsperUser;
			earningsperUser = stmt.executeQuery("select u.enduserID, SUM(a.HighestBid) from auction a, enduser u where a.sellerID=u.enduserID GROUP BY(u.enduserID)");
		%>
		</tbody>
			</table>
			<style>
				table, th, td {
				  border: 1px solid black;
				  border-collapse: collapse;
				}
				th{
					background: #F0E1B9FF;
				}
			</style>
			
			<h1>Total Earnings Per End-User</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>EndUser ID</th>
			        <th>Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
		<%
		while(earningsperUser.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(earningsperUser.getString("enduserID"));
		out.print("</td>");
		out.print("<td>");
		out.print(earningsperUser.getFloat("SUM(a.HighestBid)"));
		out.print("</td>");
		}
		}
		
		
		if(bestSellingItems==true){
			ResultSet rs6;
			rs6 = stmt.executeQuery("select a.itemID, s.name, a.HighestBid from auction a, shoes s where a.itemID = s.shoeID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
		%>
		</tbody>
			</table>
			<style>
				table, th, td {
				  border: 1px solid black;
				  border-collapse: collapse;
				}
				th{
					background: #F0E1B9FF;
				}
			</style>
			
			<h1>Best-Selling Items</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Final selling price of item</th>
			        
			    </tr>
			</thead>
			<tbody>
		<% 
		while(rs6.next()){
			out.print("<tr>");
			out.print("<td>");
			out.print(rs6.getInt("a.itemID"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs6.getString("s.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs6.getFloat("a.HighestBid"));
		}
		}
		%>
		</tbody>
		</table>
		<%
		if(bestBuyers==true){
			ResultSet bestbuyer;
			bestbuyer = stmt.executeQuery("select a.itemID, s.name, a.highestBidderID, a.HighestBid, u.name nameOfUser from auction a, shoes s, user u where u.userID = a.highestBidderId and a.itemID = s.shoeID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
		
		%>
		</tbody>
			</table>
			<style>
				table, th, td {
				  border: 1px solid black;
				  border-collapse: collapse;
				}
				th{
					background: #F0E1B9FF;
				}
			</style>
			
			<h1>Best Buyers</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Name of Buyer</th>
			        <th>Member ID of Buyer</th>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Final selling price of item</th>
			    </tr>
			</thead>
			<tbody>
			<%
			while(bestbuyer.next()){
				out.print("<tr>");
				out.print("<td>");
				out.print(bestbuyer.getString("nameOfUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(bestbuyer.getString("a.highestBidderID"));
				out.print("</td>");
				out.print("<td>");
				out.print(bestbuyer.getInt("a.itemID"));
				out.print("</td>");
				out.print("<td>");
				out.print(bestbuyer.getString("s.name"));
				out.print("</td>");
				out.print("<td>");
				out.print(bestbuyer.getFloat("a.HighestBid"));
			}
		}
			%>
		</tbody>
		</table>
			<% 
			database.closeConnection(connection);
			%>
			
			<%} catch (Exception e) {
			out.print(e);
		}%>


</body>
</html>