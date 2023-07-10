<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Remove BidCR</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
<button onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>
<%@ page import ="java.sql.*" %>

	<%
	
	ApplicationDB database = new ApplicationDB();
	Connection connection = database.getConnection();
	Statement statement = connection.createStatement();
	
	int bidID = Integer.parseInt(request.getParameter("bidID"));
	String enduserID = request.getParameter("enduserID");
	
	boolean check = false;
	
	
	//check if qID and enduserID exist
	ResultSet result1;
	result1 = statement.executeQuery("select * from bid");
	while(result1.next()){
		int ID = result1.getInt("bidID");
		String BuyerID = result1.getString("buyerID");
		if(bidID == ID && enduserID.equals(BuyerID)){
			String query1 = "DELETE from bid where bidID= "+ bidID +"" ;
			statement.executeUpdate(query1);
			check = true;
			break;
		}
	}
	
	if(check == true){
		out.println("Deletion was successful!");
		%>
		<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
		<%
	}
	else{
		out.println("Deletion unsuccesful. No such enduserID has this bidID");
		%>
		<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
		<%
	}
	
	connection.close();
	
	%>








</body>
</html>