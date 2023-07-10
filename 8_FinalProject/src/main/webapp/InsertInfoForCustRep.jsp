<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Information For Customer Rep</title>
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
		%><p style="font-size:16pt;"><b>Not all fields are filled! Please make sure no fields are empty: <a href='CreateAnAccountForRep.jsp'> Try Again</a></b></p><%
	}
	else{
    if (resultSet.next()) {
    	%><p style="font-size:16pt;"><b>The userID already exists, please try another userID <a href= 'CreateAnAccountForRep.jsp'>Try Again</a></b></p><%
    } else {
    		
		String insertIntoUser = "INSERT INTO user(userID, name, password, email, phoneNumber, address)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = connection.prepareStatement(insertIntoUser);

		ps.setString(1, userID);
		ps.setString(2, name);
		ps.setString(3, password);
		ps.setString(4, email);
		ps.setString(5, phone);
		ps.setString(6, address);
		
		ps.executeUpdate();
		String insertIntoUser1 = "INSERT INTO customerrepresentative(custRepID)"
					+ "VALUES (?)";
			
			PreparedStatement ps2 = connection.prepareStatement(insertIntoUser1);

			ps2.setString(1, userID);
			
			
			ps2.executeUpdate();


		
		
			connection.close();
		out.println("<p>insert succeeded</p>");
		
	    //username stored in the session
        response.sendRedirect("AdminSuccess.jsp"); 
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