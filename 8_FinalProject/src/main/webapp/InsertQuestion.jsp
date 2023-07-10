<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert a Question to ask</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<%@ page import ="java.sql.*" %>
<%

	ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	String enduserID = (session.getAttribute("enduserID")).toString();
	String questionText = request.getParameter("question");
	
    
	String insertIntoQuestion = "INSERT INTO question(enduserID, questionText)"
			+ "VALUES (?, ?)";
	
	PreparedStatement ps = connection.prepareStatement(insertIntoQuestion);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, enduserID);
	ps.setString(2, questionText);
	
	
	ps.executeUpdate();
	
	connection.close();
	
    response.sendRedirect("BrowseQandA.jsp");

%>


</body>
</html>