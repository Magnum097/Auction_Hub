<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<button style="font-size:14pt; background-color:#90D5EC; margin-bottom:1em;" onclick="window.location.href='SortItems.jsp';">Go Back</button>

<%@ page import ="java.sql.*" %>
	
	<%
	try {

		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();
		Statement statement = connection.createStatement();
		String type = request.getParameter("sortType");
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
			<th>Name</th>
				<!-- View All value allows us user to view all items and we can see the status of bidding for each item -->
				<%if (type.equals("View All")){%>
				
					<th> Item ID </th>				
					<th> Auction ID </th>				
					<th> Type </th>		 <!-- type of shoe -->		
					<th> Company </th>		  <!-- company of shoe -->			
					<th> Color </th>			
					<th> Material </th>				
					<th> Listed Price</th>	
					<th> Highest Bidder ID</th>			
					<th> Highest Bidding Amount</th>				
					<th> Opening Date </th>
					<th> Closing Date </th>
					
					<%ResultSet resultSet1 = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID ");%>
					
					
				</tr>
					
					<%while(resultSet1.next()){%>
						<tr>
							<td><%=resultSet1.getString("s.name")%></td>
							<td><%=resultSet1.getInt("s.shoeID")%></td>
							<td><%=resultSet1.getInt("a.auctionID")%></td>
							<td>
							<%	boolean sneakers = resultSet1.getBoolean("s.isSneakers");
								boolean boots = resultSet1.getBoolean("s.isBoots");
								boolean sandals = resultSet1.getBoolean("s.isSandals");
								if(sneakers == true){
									out.print("Sneakers");
								}else if (boots == true){
									out.print("Boots");
								}else {
									out.print("Sandals");
								}
							%>
							</td>
							<td><%=resultSet1.getString("s.companyOrBrand")%></td>
							<td><%=resultSet1.getString("s.color")%></td>
							<td><%=resultSet1.getString("s.material")%></td>
							<td><%=resultSet1.getString("a.initialPrice")%></td>
							<td><%=resultSet1.getInt("a.highestBidderID")%></td>
							<td><%=resultSet1.getDouble("a.HighestBid")%></td>
							<td><%=resultSet1.getTimestamp("a.openingDate")%></td>
							<td><%=resultSet1.getTimestamp("a.closingDate")%></td>
							
						</tr>
					<%}%>
				
				<!-- if type is selected, shows only the type of each item -->		
				<%}else if(type.equals("Type")){ %>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Type</th>
					</tr>
					
					<%ResultSet sortType = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by s.isSneakers, s.isBoots, s.isSandals");%>
					
					<%while(sortType.next()){%>
						<tr>
							<td><%=sortType.getString("s.name")%></td>
							<td><%=sortType.getInt("s.shoeID")%></td>
							<td><%=sortType.getInt("a.auctionID")%></td>
							
							<td>
							<%	boolean sneakers = sortType.getBoolean("s.isSneakers");
								boolean boots = sortType.getBoolean("s.isBoots");
								boolean sandals = sortType.getBoolean("s.isSandals");
								
	
								
								if(sneakers == true){
									out.print("Sneakers");
								}else if (boots == true){
									out.print("Boots");
								}else if(sandals == true){
									out.print("Sandals");
								}
							%>
							</td>
						</tr>
							
					<%}%>
					
					<!-- if company is selected, shows only the company(Sorted in ascending order) of each item -->	
				<%}else if(type.equals("Company")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Company</th>
					</tr>
					
					<%ResultSet sortCompany = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by s.companyOrBrand asc");%>
					
					<%while(sortCompany.next()){%>
						<tr>
							<td><%=sortCompany.getString("s.name")%></td>
							<td><%=sortCompany.getInt("s.shoeID")%></td>
							<td><%=sortCompany.getInt("a.auctionID")%></td>
							<td><%=sortCompany.getString("s.companyOrBrand")%></td>
						
						</tr>
					<%}%>
					
					<!-- if color is selected, sorts by color of items -->	
				<%}else if(type.equals("Color")){%>
				
					<th>Item ID </th>
					<th>Auction ID </th>
					<th>Color</th>
					
					</tr>
					
					<%ResultSet sortColor = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by s.color asc");%>
					
					<%while(sortColor.next()){%>
						<tr>
							<td><%=sortColor.getString("s.name")%></td>
							<td><%=sortColor.getInt("s.shoeID")%></td>
							<td><%=sortColor.getInt("a.auctionID")%></td>
							<td><%=sortColor.getString("s.color")%></td>
						
						</tr>
					<%}%>
					
					
				<!-- if material is selected, shows only the quality (sorted in ascending order) of each item -->
				<%}else if(type.equals("Material")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Material</th>
					
					</tr>
					
					<%ResultSet sortMaterial = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by s.material asc");%>
					
					<%while(sortMaterial.next()){%>
						<tr>
							<td><%=sortMaterial.getString("s.name")%></td>
							<td><%=sortMaterial.getInt("s.shoeID")%></td>
							<td><%=sortMaterial.getInt("a.auctionID")%></td>
							<td><%=sortMaterial.getString("s.material")%></td>
						
						</tr>
					<%}%>
					
				<!-- if listed price is selected, shows only the listedprice (sorted in descending order) of each item -->	
				<%}else if(type.equals("Listed Price")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Listed Price</th>
					</tr>
					
					<%ResultSet sortListedPrice = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by a.initialPrice desc");%>
					
					<%while(sortListedPrice.next()){%>
						<tr>
							<td><%=sortListedPrice.getString("s.name")%></td>
							<td><%=sortListedPrice.getInt("s.shoeID")%></td>
							<td><%=sortListedPrice.getInt("a.auctionID")%></td>
							<td><%=sortListedPrice.getString("a.initialPrice")%></td>
						
						</tr>
					<%}%>
					
					
				<!-- if bidding price is selected, shows only the bidding (sorted in descending order) of each item -->
				<%}else if(type.equals("Bidding Price")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Bidding Price</th>
					</tr>
					
					<%ResultSet sortBiddingPrice = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID order by a.HighestBid desc ");%>
					
					<%while(sortBiddingPrice.next()){%>
						<tr>
							<td><%=sortBiddingPrice.getString("s.name")%></td>
							<td><%=sortBiddingPrice.getInt("s.shoeID")%></td>
							<td><%=sortBiddingPrice.getInt("a.auctionID")%></td>
							<td><%=sortBiddingPrice.getString("a.HighestBid")%></td>
						
						</tr>
					<%}%>					
				
				
				<%}%>
					
				
				
		
			<% 
			database.closeConnection(connection);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>