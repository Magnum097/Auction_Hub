<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Dashboard</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<div>
		<h1 align = center>
			<i>
			Customer Representative Dashboard
			</i>
		</h1>
	</div>

	<%
		if(session.getAttribute("enduserID") == null){
	%>	
		<p style="font-size:16pt; position:relative; top:2px;" >
		<br>You are not logged in<br/>
		<a href="Login.jsp">Please Login</a>
		</p>
	<%}else{
		
		ApplicationDB database = new ApplicationDB();
		Connection connection = database.getConnection();
		Statement statement = connection.createStatement();
		String enduserID = (session.getAttribute("enduserID")).toString();
		ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
		String name = "";
		if(username.next())name = username.getString("name");
	
	%>
		<p align=center style="font-size:16pt; position:relative; top:2px;"> Welcome customer representative, <%=name%>
		
		</p>
		
	
		<div class="frontend">
			<ul>
				<li><a href="ViewCustRep.jsp">See/Respond to Questions</a></li>
			</ul>
			<ul>
				<li><a href="AccountInformation.jsp">Edit User Account Info</a></li>
			</ul>
			<ul>
				<li><a href="RemoveBid.jsp">Remove Bids</a></li>
			</ul>
			<ul>
				<li><a href="RemoveAuction.jsp">Remove Auctions</a></li>
			</ul>
		</div>
		
		<p><a href="Logout.jsp" >Logout</a></p>
	
	<%
		}
	%>
	
</body>
</html>