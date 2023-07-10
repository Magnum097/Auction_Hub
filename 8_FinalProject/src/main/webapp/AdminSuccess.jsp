<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<div>
		<h1 align = center>
			<i>
			Admin Dashboard
			</i>
		</h1>
	</div>
	
	<%
	    if ((session.getAttribute("enduserID") == null)) {
	%>
	<p style="font-size:16pt; position:relative; top:2px;" >
	<br>You are not logged in<br/>
	<a href="Login.jsp">Please Login</a>
	</p>
	<%} else {
		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();	
		Statement statement = connection.createStatement();
		//check if the admin login is successful
		String enduserID = (session.getAttribute("enduserID")).toString();
		ResultSet username = statement.executeQuery("select * from user where userID='" + enduserID + "'");
		String name = "";
		//getting name of the admin
		if(username.next())name = username.getString("name");
	%>  
	
		<p  align=center style="font-size:16pt; position:relative; top:2px;" >Welcome admin, <%=name%>!  
		
		
		<div class="frontend">
			<h2 style = "font-size:16pt;">Would you like to generate a sales report? </h2>
			<ul>
				<li><a href="GenerateSalesReport.jsp">Generate Sales Report</a></li>
			</ul>
			<ul>
				<li><a href="CreateAnAccountForRep.jsp">Create an Account for Customer Representative</a></li>
			</ul>
		<a href="Logout.jsp" >Logout</a>
		</p>
		</div>
	<%
	    }
	%>


</body>
</html>