<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<%@ page import ="java.sql.*" %>
	
	<%
	try {

		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();
		Statement statement = connection.createStatement();
		
		String buyerID = (session.getAttribute("enduserID")).toString();
		int auctionID = (Integer)(request.getSession().getAttribute("auctionID"));
		
		double currentBidAmount = Double.parseDouble(request.getParameter("currentBidAmount"));
		//check auction type
		String auctionType = request.getParameter("type");
		
		ResultSet resultSet;
		//selects the max current bid amount from bid table
		resultSet = statement.executeQuery("select max(b.currentBidAmount) as max from bid b where b.auctionID = '" + auctionID + "'");
		resultSet.next();
		double highestBid = resultSet.getDouble("max");
		//checks if the current bidder's amount is less than highest bid
		if(currentBidAmount < highestBid){
				boolean isAutoBid = false;
				//checks auction type
				if (auctionType.equals("Automatic")){
					isAutoBid = true;
					
					
					double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
					double upperLimit = Double.parseDouble(request.getParameter("upperLimit"));
					
					double highestBidAmount = 0;
					int selectedAuctionID = 0;
					
					ResultSet resultSet1;
					resultSet1 = statement.executeQuery("SELECT * FROM auction"); 
					while(resultSet1.next()){
						
						highestBidAmount = resultSet1.getDouble("HighestBid");
						selectedAuctionID = resultSet1.getInt("auctionID");
						double getStandard = resultSet1.getDouble("standardBiddingIncrement");
				
						//checks the desired auctionID of bidder equals the selected row auctionID 
						if (auctionID == selectedAuctionID){
							if(bidIncrement < getStandard){
								throw new IllegalArgumentException("Your bidding increment is less than the standard biding increment!");
							}
							//makes sure currentBidAmount doesnt exceed highestBid and that bidder has not reached their specificed upperLimit
							if(currentBidAmount <= upperLimit){
							while((currentBidAmount <= highestBid)&& currentBidAmount <= upperLimit){ 
									
									currentBidAmount = currentBidAmount + bidIncrement;	
							}}
						}
					}
					
					if(currentBidAmount >= upperLimit){
						//current bid > upperlimit so send alert to user
						ResultSet getItemID = statement.executeQuery("select a.itemID from auction a where a.auctionID = '" + auctionID + "'");
						int itemNum = 0;
						if(getItemID.next())itemNum = getItemID.getInt("itemID");
						String alert = "The current bid amount for auctionID: " + auctionID + " has crossed the upperLimit, please reset the upper limit for this auction";
						String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoshoeID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
				    	PreparedStatement psAlert = connection.prepareStatement(insertAlert);
				    	psAlert.setString(1, buyerID);
						psAlert.setInt(2, auctionID);
						psAlert.setInt(3, itemNum);
						psAlert.setString(4, alert);
					
						psAlert.executeUpdate();
						
					}
					//if after incrementing, the bidder reached the highest bid amount and < upper limit, then update the tables
					if(currentBidAmount >= highestBid){ 
						String firstQuery = "update auction set HighestBid = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
						statement.executeUpdate(firstQuery);
						String secondQuery = "update auction set highestBidderID = '" + buyerID + "' where auctionID = '" + auctionID + "'";
						statement.executeUpdate(secondQuery);
					    //send alert to other users since current bid > max bid, ask them to bid higher amount
					    //if user is automatic bidder, ask them to ignore alert
						ResultSet usersInAuction = statement.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
					   
					    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autobidder please ignore this message.</b>";
					    while(usersInAuction.next()){
					    	 String selectUserID = usersInAuction.getString("buyerID");
					    	 int itemID = usersInAuction.getInt("itemID");
					    	if(!selectUserID.equals(buyerID)){
					    	//you need to insert an alert for each of the user except for the current user
					    	String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
									+ "VALUES (?, ?, ?, ?)";
					    	PreparedStatement psAlert = connection.prepareStatement(insertAlert);
					    	psAlert.setString(1, selectUserID);
							psAlert.setInt(2, auctionID);
							psAlert.setInt(3, itemID);
							psAlert.setString(4, alert);
						
							
							psAlert.executeUpdate();
					    	}
					    }
					    //alert all autobidders in case highest bid > their upper limit 
				    	 String alertAutoBidder = "For auction: " + auctionID + ", someone has placed a bid higher than your upper limit</b>";
				    	
				    	 Statement statement6 = connection.createStatement();
				    	 ResultSet allAutoBiddersInAuction = statement6.executeQuery("select * from bid b, auction a where a.auctionID = b.auctionID and a.auctionID = '" + auctionID + "' and b.type = 'Automatic'");
				    	 
				    	 //check if the highest bid now is greater than the upperlimit
				    	 while(allAutoBiddersInAuction.next()){
				    		 String selectUserID = allAutoBiddersInAuction.getString("buyerID");
					    	 int itemID = allAutoBiddersInAuction.getInt("itemID");
					    	 if(!selectUserID.equals(buyerID)){
				    		 if(allAutoBiddersInAuction.getDouble("upperLimit") < allAutoBiddersInAuction.getDouble("HighestBid")){
				    			 String insertAlertAutoBid = "INSERT INTO hasanalert(userID, auctionID, shoshoeID, alertMessage)"
											+ "VALUES (?, ?, ?, ?)";
							    	PreparedStatement psAlertAutoBid = connection.prepareStatement(insertAlertAutoBid);
							    	psAlertAutoBid.setString(1, selectUserID);
									psAlertAutoBid.setInt(2, auctionID);
									psAlertAutoBid.setInt(3, itemID);
									psAlertAutoBid.setString(4, alertAutoBidder);
								
									psAlertAutoBid.executeUpdate();
				    		 }} 
				    	 }
					}
					

					
					String insertIntoBid = "INSERT INTO bid(buyerId, auctionID, currentBidAmount, type,  placedDate, isAutoBid, bidIncrement, upperLimit)"
							+ "VALUES (?, ?, ?, ?, now(), ?, ?, ?)";
					
					PreparedStatement ps = connection.prepareStatement(insertIntoBid);

					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, auctionType);
					ps.setBoolean(5, isAutoBid);
					ps.setDouble(6, bidIncrement);
					ps.setDouble(7, upperLimit);
				
					
					ps.executeUpdate();
					
					
					
				}else{ //the bidders current amount< highestBid and chose manual bidding 
					
					ResultSet resultSet2;
					resultSet2 = statement.executeQuery("SELECT * FROM auction"); 
					double highestBidAmount = 0;
					int selectedAuctionID = 0;
					while(resultSet2.next()){
						//store the highestBidAmount and auctionID for each row from auction table
						highestBidAmount = resultSet2.getDouble("HighestBid"); 
						selectedAuctionID = resultSet2.getInt("auctionID");
						//checks if selected auctionID on makeABid page = the selected auctionID from our query
						if (auctionID == selectedAuctionID){
							if(currentBidAmount < highestBid){
								//Alert(); //Need to fix
							}	
						}
					}
					Statement statement4 = connection.createStatement();
				    ResultSet rsSome = statement4.executeQuery("select * from bid where auctionID = '" + auctionID + "' and buyerID = '" + buyerID +"'" );
				    //if there is existing bid already
				    if(rsSome.next()){
				    String querySome = "update bid set currentBidAmount = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
				    statement.executeUpdate(querySome);}
				    else{
					String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount,type, placedDate, isAutoBid)" //bid increment and upperlimit are not included - these values will be set to NULL (MANUAL BID)
							+ "VALUES (?, ?, ?, ?, now(), ?)";
					
					PreparedStatement ps = connection.prepareStatement(insert);

					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, auctionType);
					ps.setBoolean(5, isAutoBid);
					
					
					
					ps.executeUpdate();}
				}
			    
		}else{ //if the current bidding amount > max bid amount from the past users, then update the tables
			boolean isAutoBid = false;
			if (auctionType.equals("Automatic")){
				isAutoBid = true;
				//if the user chose automatic bidding, then they will specify bidIncrement and upperLimit
				 double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
				 double upperLimit = Double.parseDouble(request.getParameter("upperLimit"));
				 //get standard bidding increment for specific auction 
				 ResultSet standard = statement.executeQuery("select standardBiddingIncrement from auction where auctionID = '" + auctionID + "'");
				 if(standard.next()){
					 double getStandard = standard.getDouble("standardBiddingIncrement");
					 if(bidIncrement < getStandard){
							throw new IllegalArgumentException("Your bidding increment is less than the standard biding increment");
					}
				 }
			
					
				String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount, type,  placedDate, isAutoBid, bidIncrement, upperLimit)"
						+ "VALUES (?, ?, ?, ?, now(), ?, ?, ?)";
			
				PreparedStatement ps = connection.prepareStatement(insert);

				ps.setString(1, buyerID);
				ps.setInt(2, auctionID);
				ps.setDouble(3, currentBidAmount);
				ps.setString(4, auctionType);
				ps.setBoolean(5, isAutoBid);
				ps.setDouble(6, bidIncrement);
				ps.setDouble(7, upperLimit);
				
				
				ps.executeUpdate();
				
			
			}else{ //the bidders currentAmount > max bid amount for manual bidding
				Statement statement4 = connection.createStatement();
			    ResultSet rsSome = statement4.executeQuery("select * from bid where auctionID = '" + auctionID + "' and buyerID = '" + buyerID +"'" );
			    //if manual bid already exists, update it
			    if(rsSome.next()){
			    String querySome = "update bid set currentBidAmount = " + currentBidAmount + " where auctionID = '" + auctionID + "' and buyerID = '" + buyerID + "'";
			    statement.executeUpdate(querySome);}
			    else{
				String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount,type, placedDate, isAutoBid)" //bid increment and upperlimit are not included - these values will be set to NULL (MANUAL BID)
						+ "VALUES (?, ?, ?, ?, now(), ?)";
				
				PreparedStatement ps = connection.prepareStatement(insert);

				ps.setString(1, buyerID);
				ps.setInt(2, auctionID);
				ps.setDouble(3, currentBidAmount);
				ps.setString(4, auctionType);
				ps.setBoolean(5, isAutoBid);
				
				
				ps.executeUpdate();}
				
			}
			String firstQuery = "update auction set HighestBid = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
			statement.executeUpdate(firstQuery);
			String secondQuery = "update auction set highestBidderID = '" + buyerID + "' where auctionID = '" + auctionID + "'";
			statement.executeUpdate(secondQuery);	
		    
		    //send alert stating highest bid has been reached
		    ResultSet usersInAuction = statement.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
		    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autobidder please ignore this message.</b>";
		    while(usersInAuction.next()){
		    	String selectUserID = usersInAuction.getString("buyerID");
		    	int itemID = usersInAuction.getInt("itemID");
		    	if(!selectUserID.equals(buyerID)){
		  
		    	String insertAlert = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
						+ "VALUES (?, ?, ?, ?)";
		    	PreparedStatement psAlert = connection.prepareStatement(insertAlert);
		    	psAlert.setString(1, selectUserID);
				psAlert.setInt(2, auctionID);
				psAlert.setInt(3, itemID);
				psAlert.setString(4, alert);
			
				
				psAlert.executeUpdate();
		    	}
		    	
		    }
		  //alert all autobidders for highest bid > their upper limit 
	    	 String alertAutoBidder = "For auction: " + auctionID + ", someone has placed a bid higher than your upper limit</b>";
	    	 
	    	 Statement statement6 = connection.createStatement();
	    	 ResultSet allAutoBiddersInAuction = statement6.executeQuery("select * from bid b, auction a where a.auctionID = b.auctionID and a.auctionID = '" + auctionID + "' and b.type = 'Automatic'");
	    	 //check if highest bid is greater than upperlimit
	    	 while(allAutoBiddersInAuction.next()){
	    		 String selectUserID = allAutoBiddersInAuction.getString("buyerID");
		    	 int itemID = allAutoBiddersInAuction.getInt("itemID");
		    	 if(!selectUserID.equals(buyerID)){
	    		 if(allAutoBiddersInAuction.getDouble("upperLimit") < allAutoBiddersInAuction.getDouble("HighestBid")){
	    			 //if less then send an alert
	    			 String insertAlertAutoBid = "INSERT INTO hasanalert(enduserID, auctionID, shoeID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
				    	PreparedStatement psAlertAutoBid = connection.prepareStatement(insertAlertAutoBid);
				    	psAlertAutoBid.setString(1, selectUserID);
						psAlertAutoBid.setInt(2, auctionID);
						psAlertAutoBid.setInt(3, itemID);
						psAlertAutoBid.setString(4, alertAutoBidder);
					
						
						psAlertAutoBid.executeUpdate();
	    		 }}
	    	 }
	
		
		

		}
		
		connection.close();
		out.print("<br> Your bid has been successfully made <br>");
		%><button style="font-size:14pt; background-color:#90D5EC; margin-top:1em;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button><%
				
		} catch(IllegalArgumentException iae) {
			  out.println(iae.getMessage());
			  out.println("<br>");
			  out.println("insert failed");
			  out.println("<br>");
			  %><button style="font-size:14pt; background-color:#90D5EC; margin-top:1em;" onclick="window.location.href='ShowAuctions.jsp';">Try to Bid Again!</button><%
		     }catch (Exception ex) {
			   out.print(ex);
		       out.println("<br>");
			  out.print("insert failed");
			    out.println("<br>");
			%><button style="font-size:14pt; background-color:#90D5EC; margin-top:1em;" onclick="window.location.href='ShowAuctions.jsp';">Try to Bid Again!</button><%
		     }
	        %>

</body>
</html>