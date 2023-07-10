<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit User Info</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
<button onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>
	
			<%@ page import ="java.sql.*" %>
	<%
	
		
		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();	
		Statement statement = connection.createStatement();
		
		String userID = request.getParameter("userID");
		
		String deleteUserAccount = request.getParameter("delete");
		
		
		//check if userID exists in the user table
		boolean userIDexists = false;
		ResultSet resultSet = statement.executeQuery("select * from user");
		while(resultSet.next()){
			String ID = resultSet.getString("userID");
			if(ID.equals(userID)){
				userIDexists = true;
			}
		}
		
		if(userIDexists == true){
			int count = 0;
			if(! deleteUserAccount.equals("delete")){
				
				String name = request.getParameter("name");
				String password = request.getParameter("password");
				String phonenumber = request.getParameter("phonenumber");
				String email = request.getParameter("email");
				String address = request.getParameter("address");
				
				
				if (name.length() != 0){
					count++;
				}
				if(password.length() != 0){
					count++;
				}
				if(phonenumber.length() != 0){
					count++;
				}
				if(email.length() != 0){
					count++;
				}
				if(address.length() != 0){
					count++;
				}
				
				
				
				if(count > 1){
					out.println("You cannot edit more than one category! Try again!");
					%>
					<button onclick="window.location.href='AccountInformation.jsp';">Go Back</button>
					<%
					
					
				}else if(count == 1 && name.length() != 0){
						PreparedStatement statement2 = connection.prepareStatement("UPDATE user set name=? where userID = " + userID+"");
						statement2.setString(1, name);
						statement2.executeUpdate();
						out.print("The account has been updated!");
						
				}else if(count == 1 && password.length() !=0){
						PreparedStatement statement3 = connection.prepareStatement("UPDATE user set password=? where userID = " + userID+ "");
						statement3.setString(1, password);
						statement3.executeUpdate();	
						out.print("The account has been updated!");
						
				}else if(count == 1 && phonenumber.length() != 0){
						PreparedStatement statement4 = connection.prepareStatement("UPDATE user set phoneNumber=? where userID = " + userID+ "");
						statement4.setString(1, phonenumber);
						statement4.executeUpdate();
						out.print("The account has been updated!");
				}else if(count == 1 && email.length()!= 0){
						PreparedStatement statement5 = connection.prepareStatement("UPDATE user set email=? where userID = " + userID+ "");
						statement5.setString(1, email);
						statement5.executeUpdate();
						out.print("The account has been updated!");
						
				}else if(count == 1 && address.length()!=0){
						PreparedStatement statement6 = connection.prepareStatement("UPDATE user set address=? where userID = " + userID+ "");
						statement6.setString(1, address);
						statement6.executeUpdate();
						out.print("The account has been updated!");
				}
				
				%>
				<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
				<%
					
			
				
				
			}else if(deleteUserAccount.equals("delete")){
				//delete from everywhere 
				Statement statement4 = connection.createStatement();
				ResultSet getAuctionID = statement4.executeQuery("select * from auction where sellerID = '" + userID + "'");
				while(getAuctionID.next()){
				
					int auctionID = getAuctionID.getInt("auctionID");
					out.println(auctionID);
					
				    ////delete the user from the auction table 
					
					String deleteAllAlerts = "DELETE from hasanalert where auctionID = '" + auctionID + "'";
					statement.executeUpdate(deleteAllAlerts);
					
					
					//delete all bids on this auction
					String DeleteAllBids = "DELETE from bid where auctionID = '" + auctionID + "'";
					statement.executeUpdate(DeleteAllBids);
					
				
				//delete auction as well
				String deleteAuction = "DELETE from auction where auctionID = '" + auctionID + "'";
				statement.executeUpdate(deleteAuction);
				
				
				}
				String deleteAllAlerts = "DELETE from hasanalert where enduserID = '" + userID + "'";
				statement.executeUpdate(deleteAllAlerts);
				
				String deleteAllQuestions = "DELETE from question where enduserID = '" + userID + "'";
				statement.executeUpdate(deleteAllQuestions);
				
				String deleteAllWishesFor = "DELETE from wishesFor where enduserID = '" + userID + "'";
				statement.executeUpdate(deleteAllWishesFor);
				
				
				
				Statement statement5 = connection.createStatement();
				String DeleteAllBids = "DELETE from bid where buyerID = '" + userID + "'";
				statement.executeUpdate(DeleteAllBids);
				
				
				String firstQuery = "DELETE from enduser where enduserID = '" + userID + "'" ;
				statement.executeUpdate(firstQuery);
				
				
				String secondQuery = "DELETE from user where userID = '" + userID + "'" ;
				statement.executeUpdate(secondQuery);	
				
				out.print("The account has been deleted!");
				%>
				<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
				<%
				
			}
			
		}else{
			out.print("userID does not exist! Try again!");
			%>
			<button onclick="window.location.href='AccountInformation.jsp';">Go Back</button>
			<%
			
		}
		
	
		
	
		connection.close();
	
		
	
	%>

</body>
</html>