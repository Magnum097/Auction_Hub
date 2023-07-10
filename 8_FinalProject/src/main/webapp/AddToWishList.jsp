<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding to WishList</title>
</head>

<body style="font-size:15pt; background-color:#FAEBEFFF;">

<br>
   
    <%
    try{
    ApplicationDB database = new ApplicationDB();	
   	Connection connection = database.getConnection();
   	Statement statement = connection.createStatement();
   	
   	//getting enduserID which is the session attribute
   	String enduserID = (session.getAttribute("enduserID")).toString();
   	String name = "";
   	ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
    if(username.next())name = username.getString("name");
   	

    int auctionID = Integer.parseInt(request.getParameter("wishItem"));
    //get the sellerID for this auction
    ResultSet getSeller = statement.executeQuery("select sellerID from auction where auctionID='" + auctionID + "' and sellerID = '" + enduserID + "'");
    if(getSeller.next()){
    	throw new IllegalArgumentException("YOU ARE THE SELLER OF THIS AUCTION, YOU CANNOT ADD ITEM TO WISHLIST");
    }
    
    //------------------------------------------------------------------------------------------------------------
    //check if the item is in present auctions
    //if it is send an alert saying it is already available
    ResultSet resultSet;
    resultSet = statement.executeQuery("select a.itemID, s.name from shoes s, auction a where s.shoeID = a.itemID and a.auctionID = '" + auctionID + "' and a.closingDate > now() and a.openingDate < now()");
    int itemID = 0;
    String itemName = "";
    if(resultSet.next()){
    	itemID = resultSet.getInt("itemID");
    	itemName = resultSet.getString("name");
    String alert = "The item with itemID: " + itemID + " and item name: " + itemName + " is now available!";
    String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	PreparedStatement psAlert = connection.prepareStatement(insertAlert);
	psAlert.setString(1, enduserID);
	psAlert.setInt(2, auctionID);
	psAlert.setInt(3, itemID);
	psAlert.setString(4, alert);

	
	psAlert.executeUpdate();
    }
	
    //------------------------------------------------------------------------------------------------------------
    //check if the item is in past auctions
    //if it is send an alert saying it is no longer available
    ResultSet resultSet1;
    resultSet1 = statement.executeQuery("select * from shoes s, auction a where s.shoeID = a.itemID and a.auctionID = '" + auctionID + "' and a.closingDate < now()");
    int firstItemID = 0;
    String firstItemName = "";
    if(resultSet1.next()){
    	firstItemID = resultSet1.getInt("itemID");
    	firstItemName = resultSet1.getString("name");
    String firstAlert = "The item with itemID: " + firstItemID + " and item name: " + firstItemName + " is no longer available!";
    String insertAlert1 = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	PreparedStatement psAlert1 = connection.prepareStatement(insertAlert1);
	psAlert1.setString(1, enduserID);
	psAlert1.setInt(2, auctionID);
	psAlert1.setInt(3, firstItemID);
	psAlert1.setString(4, firstAlert);

	
	psAlert1.executeUpdate();
    }
	
    //------------------------------------------------------------------------------------------------------------
	//check if the item is in future auctions
	//If it is in the future auctions, then add it to the wishlist
	ResultSet resultSet2;
	resultSet2 = statement.executeQuery("select  a.itemID, s.name from shoes s, auction a where s.shoeID = a.itemID and a.auctionID = '" + auctionID + "' and a.openingDate > now()");
    int secondItemID = 0;
    String secondItemName = "";
    if(resultSet2.next()){
    	secondItemID = resultSet2.getInt("itemID");
    	secondItemName = resultSet2.getString("name");
        //check if the item is in the person's wishlist
    	Statement statement1 = connection.createStatement();
    	ResultSet inWishesFor = statement1.executeQuery("select * from wishesFor where enduserID = '" + enduserID + "' and shoeID = '" + secondItemID + "'");
    	
    	if(inWishesFor.next()){
    		out.println("Enters Here!");
    		String alert2 = "The item with itemID: " 
                    + secondItemID + " and item name: " + secondItemName + " is in your wishlist ALREADY!";
  
              String insertAlert2 = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	           PreparedStatement psAlert2 = connection.prepareStatement(insertAlert2);
	           psAlert2.setString(1, enduserID);
	           psAlert2.setInt(2, auctionID);
	           psAlert2.setInt(3, secondItemID);
	           psAlert2.setString(4, alert2);

	           
	          psAlert2.executeUpdate();
    	}
    	else{
             String insertWishListItem = "INSERT INTO wishesFor(enduserID, shoeID)"
    			+ "VALUES (?, ?)";
             PreparedStatement psWishItem = connection.prepareStatement(insertWishListItem);
 	         psWishItem.setString(1, enduserID);
 	         psWishItem.setInt(2, secondItemID);
 	         psWishItem.executeUpdate();
 	 
             String alert2 = "The item with itemID: " 
                      + secondItemID + " and item name: " + secondItemName + " has been added to your wishlist, you will notified to your Alerts Inbox when its available!";
    
             String insertAlert2 = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
			                          + "VALUES (?, ?, ?, ?)";
	         PreparedStatement psAlert2 = connection.prepareStatement(insertAlert2);
	         psAlert2.setString(1, enduserID);
	         psAlert2.setInt(2, auctionID);
	         psAlert2.setInt(3, secondItemID);
	         psAlert2.setString(4, alert2);

	        
	          psAlert2.executeUpdate();
           }
    }
    //------------------------------------------------------------------------------------------------------------
  		connection.close();
  		out.print("Check Your Alerts Inbox To See Status Of Item!");
  		%><button onclick="window.location.href='DisplayAlerts.jsp';">See your Alerts</button><%
    } catch(IllegalArgumentException iae) {
		  out.println(iae.getMessage());
		  out.println("<br>");
		  %><button onclick="window.location.href='ListOfItems.jsp';">Try To Add A Different Item To The WishList!</button><%
	}
    catch (Exception ex) {
		   out.print(ex);
	       out.println("<br>");
		  out.print("insert failed");
		    out.println("<br>");
		%><button onclick="window.location.href='ListOfItems.jsp';">Try Again To Add An Item!</button><%
   }%>
</body>
</html>