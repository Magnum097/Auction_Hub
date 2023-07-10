<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login successful</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
	<%@ page import ="java.sql.*" %>
<%
    String userID = request.getParameter("UserID");   
    String password = request.getParameter("Password");
    
    ApplicationDB database = new ApplicationDB();	
    Connection con = database.getConnection();	
	Statement statement = con.createStatement();
    ResultSet resultSet1;
    resultSet1 = statement.executeQuery("select * from user where userID='" + userID + "'");
    if (resultSet1.next()){
    	 ResultSet resultSet2;
    	 resultSet2 = statement.executeQuery("select * from user where userID='" + userID + "' and password='" + password + "'");
    	    if (resultSet2.next()) {
    	    	ResultSet username;
    	    	username = statement.executeQuery("select * from user where userID='" + userID + "' and password='" + password + "'");
    	    	String name = "";
    	    	if(username.next())name = username.getString("name");
    	    	ResultSet isEndUser = statement.executeQuery("select * from enduser where enduserID='" + userID + "'");
    	    	if(isEndUser.next())response.sendRedirect("Success.jsp");
    	    	else{
    	    		ResultSet isCustomerRep = statement.executeQuery("select * from customerrepresentative where custRepID='" + userID + "'");
    	    		if(isCustomerRep.next())response.sendRedirect("CustRepSuccess.jsp");    //succesful login for customer representative
    	    		else{
    	    			Statement statement1 = con.createStatement();
    	    			ResultSet isAdmin = statement1.executeQuery("select * from admin where adminID='" + userID + "'");
        	    		if(isAdmin.next())response.sendRedirect("AdminSuccess.jsp");         //successful login for admin
    	    		}
    	    	}
    	    	session.setAttribute("enduserID", userID);
    	     
    	    } else {%>
    	        <p style = "font-size:16pt; position:relative; top:2px;"><b> your password is invalid, <a href='Login.jsp'>try again!</a></b></p><% 
    	    }
    }
    else{%>
    	<p align=center style="font-size:15pt; position:relative; top:2px;">
    	<b style="font-family:Monaco;"> UserID doesn't exist! Try Again <br>
    	<br></br>
    	<a style="font-size:14pt; font-family:Monaco;" href= 'Register.jsp'> Register An Account <br>or </a> 
    	<br> <a style="font-size:14pt; font-family:Monaco;" href = 'Login.jsp' >Go Back To The Login Page</a></b></p><%
    }
    con.close();
%>

</body>
</html>