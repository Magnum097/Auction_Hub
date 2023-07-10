<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questions</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

<button style="font-size:14pt; background-color:#90D5EC; margin-bottom:2em;" onclick="window.location.href='Success.jsp';">Go Back</button>
	
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
			
				<%ResultSet resultSet1 = statement.executeQuery("select * from question q");%>
						
						
					</tr>
						
						<%while(resultSet1.next()){%>
							<tr>
								<td><%=resultSet1.getInt("q.qID")%></td>
								<td><%=resultSet1.getInt("q.enduserID")%></td>
								<td><%=resultSet1.getString("q.questionText")%></td>
								<td><%=resultSet1.getString("q.answerText")%></td>
							</tr>
						<%}%>
						
		
		</table>
					
		<% 
		database.closeConnection(connection);
		%>
		
			
		<%} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>