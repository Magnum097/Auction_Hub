<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete auction</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<%@ page import ="java.sql.*" %>
	<%
	
		ApplicationDB database = new ApplicationDB();
		Connection connection = database.getConnection();
		Statement statement = connection.createStatement();
	
		int auctID = Integer.parseInt(request.getParameter("auctionID"));
		//out.print("AuctID: "+auctID);
		String enduserID = request.getParameter("enduserID");
	
		boolean conditions = false;
	
		//check if qID and enduserID exist
		ResultSet result1;
		result1 = statement.executeQuery("select * from auction");
		while(result1.next()){
		String sellerID = result1.getString("sellerID");
		int auctionID = result1.getInt("auctionID");
		if(sellerID.equals(enduserID) && auctID == auctionID){
			conditions = true;
			break;
			}
		}
	
	
		if(conditions == false){
			out.print("Not a valid seller or no such auction exists!!");
			%>
			<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
			<%
		}else{
			String deleteAllAlerts = "DELETE from hasanalert where auctionID = '" + auctID + "'";
			statement.executeUpdate(deleteAllAlerts);
			
			//delete all bids on this auction
			String DeleteAllBids = "DELETE from bid where auctionID = '" + auctID + "'";
			statement.executeUpdate(DeleteAllBids);
			
			String DeleteAuction = "DELETE from auction where auctionID= '" + auctID + "'" ;
			statement.executeUpdate(DeleteAuction);
			
			out.print("This is a valid request!");
			
				%>
				<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
				<%
		}
		
		connection.close();%>

</body>
</html>