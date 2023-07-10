<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Information</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
	<%@ page import ="java.sql.*" %>
<%
try{
	 String userID = request.getParameter("UserID");
	 String name = request.getParameter("Name");
	 String password = request.getParameter("Password");
	 String email = request.getParameter("Email");
	 String phone = request.getParameter("Phone");
	 String address = request.getParameter("Address");
	 boolean isUserIDEmpty = (userID == "" || userID.isEmpty());
	 boolean isNameEmpty = (name == "" || name.isEmpty());
	 boolean isPasswordEmpty = (password == "" || password.isEmpty());
	 boolean isEmailEmpty = (email == "" || email.isEmpty());
	 boolean isPhoneEmpty = (phone == "" || phone.isEmpty());
	 boolean isAddressEmpty = (address == "" || address.isEmpty());
	
	ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	
    ResultSet resultSet;
    resultSet = statement.executeQuery("select * from user where userID='" + userID + "'");
    if(isUserIDEmpty ||isNameEmpty || isPasswordEmpty || isEmailEmpty || isPhoneEmpty || isAddressEmpty){
		%><p align=center style="font-family:Monaco; font-size:15pt;"><b> Please fill out all the fields to create a new Account <a style="font-size:14pt;" href='Register.jsp'> <br>Try Again</a></b></p><%
	}
	else{
    if (resultSet.next()) {
    	%><p align=center style="font-family:Monaco; font-size:15pt;"><b>This userID exists already, please try another userID<a style="font-size:14pt;" href='Register.jsp'> <br>Try Again</a></b></p><%
    } else {
    		
    	//INSERT statement for the user table:
		String insertIntoUser = "INSERT INTO user(userID, name, password, email, phoneNumber, address)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
	
		PreparedStatement prestmt = connection.prepareStatement(insertIntoUser);

		prestmt.setString(1, userID);
		prestmt.setString(2, name);
		prestmt.setString(3, password);
		prestmt.setString(4, email);
		prestmt.setString(5, phone);
		prestmt.setString(6, address);
		
		prestmt.executeUpdate();
		
		//INSERT statement for the EndUser table:
		String insertEndUser = "INSERT INTO enduser(enduserID)"
						+ "VALUES (?)";
		
	    PreparedStatement prestmt1 = connection.prepareStatement(insertEndUser);
		
	    prestmt1.setString(1, userID);
	  
	    prestmt1.executeUpdate();

		
		connection.close();
		out.println("<p>insert succeeded</p>");
		session.setAttribute("enduserID", userID); 
        response.sendRedirect("Success.jsp"); 
    	}
    }
}
catch (Exception ex) {
	out.print(ex);
	out.print("<br>insert failed<br>"); 
}
 

%>

</body>
</html>