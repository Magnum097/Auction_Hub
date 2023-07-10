<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ page import ="java.sql.*" %>

<%

	 //all item data
	 boolean isSneakers = false;
	 boolean isBoots = false;
	 boolean isSandals = false;
	 String shoe = request.getParameter("shoe");
	 if(shoe.equals("isSneakers")){
		 isSneakers = true;
	 }
	 else if(shoe.equals("isBoots")){
		 isBoots = true;
	 }
	 else if(shoe.equals("isSandals")){
		 isSandals = true;
	 }
	 
	 String shoeName = request.getParameter("nameOfShoe");
	 String color = request.getParameter("color");
	 double size = Double.parseDouble(request.getParameter("size"));
	 String material = request.getParameter("material");
	 //String materialType = request.getParameter("materialType");
	 String company = request.getParameter("companyOrBrand");
	 
	 String purpose = request.getParameter("purpose");
	 String highTop = request.getParameter("highTop");
	 
	 String heelHeightString = request.getParameter("heelHeight");
	 double heelHeight = 0;
	 if(heelHeightString.length() != 0) heelHeight = Double.parseDouble(heelHeightString);
	 
	 String type = request.getParameter("type");
	 String ankleStraps = request.getParameter("ankleStraps");
	 String openToed = request.getParameter("openToed");
	 
	//all auction data
	double initialPrice = Double.parseDouble(request.getParameter("initialPrice"));
	double minPrice = Double.parseDouble(request.getParameter("minimumPrice"));
	double standardBidIncrement = Double.parseDouble(request.getParameter("standardBiddingIncrement"));
	String openingDate = request.getParameter("openingDate");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date opendate = sdf1.parse(openingDate);
	java.sql.Timestamp openingTimestamp = new java.sql.Timestamp(opendate.getTime());
	
	String closingDate = request.getParameter("closingDate");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = sdf.parse(closingDate);
	java.sql.Timestamp closingTimestamp = new java.sql.Timestamp(date.getTime());
	
	//who's the seller -> the one who is logged in
	String sellerID = (session.getAttribute("enduserID")).toString();
	ApplicationDB database = new ApplicationDB();	
	Connection con = database.getConnection();	
	Statement stmt = con.createStatement();
	
	String insertIntoShoes = "INSERT INTO shoes(isSneakers, isBoots, isSandals, name, color, size, material, companyOrBrand, purpose, highTop, heelHeight, type, ankleStraps, openToed)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	
	PreparedStatement ps = con.prepareStatement(insertIntoShoes);
	
	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setBoolean(1, isSneakers);
	ps.setBoolean(2, isBoots);
	ps.setBoolean(3, isSandals);
	ps.setString(4, shoeName);
	ps.setString(5, color);
	ps.setDouble(6, size);
	ps.setString(7, material);   //changed
	ps.setString(8, company);
	ps.setString(9, purpose);
	ps.setString(10, highTop);
	ps.setDouble(11, heelHeight);
	ps.setString(12, type);
	ps.setString(13, ankleStraps);
	ps.setString(14, openToed);
	
	ps.executeUpdate();
	ResultSet rs = stmt.executeQuery("select max(shoeID) max from shoes");
	int itemID = 0;
	if(rs.next())itemID = rs.getInt("max");
	
	//save all the auction data
	String insertIntoAuction = "INSERT INTO auction(sellerID, itemID, initialPrice, hiddenMinimumPrice, standardBiddingIncrement, openingDate, closingDate)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement ps1 = con.prepareStatement(insertIntoAuction);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps1.setString(1, sellerID);
	ps1.setInt(2, itemID);
	ps1.setDouble(3, initialPrice);
	ps1.setDouble(4, minPrice);
	ps1.setDouble(5, standardBidIncrement);
	ps1.setTimestamp(6,openingTimestamp);
	ps1.setTimestamp(7,closingTimestamp);
	ps1.executeUpdate();
	con.close();
	
    response.sendRedirect("ShowAuctions.jsp");
	
%>

</body>
</html>