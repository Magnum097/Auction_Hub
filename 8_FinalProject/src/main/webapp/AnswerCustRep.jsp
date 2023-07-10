<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answer Question of the enduser</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<%@ page import ="java.sql.*" %>
<%

	ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	int qID = Integer.parseInt(request.getParameter("qID"));
	String enduserID = request.getParameter("enduserID");
	String answerText = request.getParameter("answer");
	
	boolean qIDenduserIDexists = false;
	
	//checking if qID and enduserID exist
	ResultSet resultSet1;
	resultSet1 = statement.executeQuery("select * from question");
	while(resultSet1.next()){
		int questionid = resultSet1.getInt("qID");
		
		String enduserid = resultSet1.getString("enduserID");
		
		String answertext = resultSet1.getString("answerText");
		
		if(qID == questionid && enduserID.equals(enduserid) && answertext == null){
			qIDenduserIDexists = true;
			PreparedStatement statement2 = connection.prepareStatement("UPDATE question set answerText=? where qID = " + qID+ "");
			statement2.setString(1, answerText);
			statement2.executeUpdate();
			break;
			
		}
	}
	
	
	if(qIDenduserIDexists == false){
		out.print("No such qID or enduserID exists try again!");%>
		<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
		<%connection.close();
		
	}
	else{
		out.print("You have succesfuly entered an answer!");%>
		<button onclick="window.location.href='ViewCustRep.jsp';">Back to Questions</button>
		<%connection.close();
	}


%>

</body>
</html>