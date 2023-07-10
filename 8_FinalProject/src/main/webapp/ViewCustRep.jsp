<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Cust Rep</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<button style="font-size:14pt; background-color:#90D5EC; margin-bottom:1em;" onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		ApplicationDB database = new ApplicationDB();	
		Connection connection = database.getConnection();
		Statement statement = connection.createStatement();
	
		%>
		
		
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

th{
	background: #F0E1B9FF;
}

</style>
<table style="width:100%">
<thead>
    <tr>	
		<th>Question ID</th>
		<th>EndUser ID</th>
		<th>Question</th>
		<th>Answer</th>
	
		<%ResultSet result1 = statement.executeQuery("select * from question q");%>
					
	</tr>
					
		<%while(result1.next()){%>
			<tr>
				<td><%=result1.getInt("q.qID")%></td>
				<td><%=result1.getInt("q.enduserID")%></td>
				<td><%=result1.getString("q.questionText")%></td>
				<td><%=result1.getString("q.answerText")%></td>
			</tr>
		<%}%>
					
	
	</table>
			
	<form action="AnswerCustRep.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about the question you want to answer: </b></p>
	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter the question ID: <input type="text" name="qID" placeholder="qID" required></td>
	   </tr>
	   <tr>    
	   <td>Enter the enduser ID : <input type="text" name="enduserID" placeholder="enduserID" required></td>
	   </tr>
	   <tr>    
	   <td>Enter your Answer : <input type="text" name="answer" placeholder="answer" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit Answer" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	
	</form>	
	

	<%
	database.closeConnection(connection);
	%>

		
	<%} catch (Exception e) {
		out.print(e);
	}%>
		

</body>
</html>