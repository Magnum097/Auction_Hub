<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Sort Items by category</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>

		<% //sorting items based on the selected category %>
		<br>
			<br>
			Sort And Search Auction Items by selecting a category:
			<form method="post" action="ViewItems.jsp">
			
				<select name = "sortType">
					<option>Type</option>
					<option>Company</option>
					<option>Color</option>
					<option>Material</option>
					<option>Listed Price</option>
					<option>Bidding Price</option>
					<option>View All</option>
				</select>
				<br>
				<br>
				<input type="submit" value="Submit" style="font-size:14pt; background-color:#90D5EC;">
			<br>
		</form>
		<br>



</body>
</html>