<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Q and A</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">


<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>

					  
	<br>
	<form action="BrowseKeyword.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the keyword you would like to search for:</b></p>
	
		 <table align=center style="font-size:16pt;">
		   <tr>    
		   <td>Enter your keyword: <input type="text" name="keyword" placeholder="keyword" required></td>
		   </tr>
		 </table>
		 
	   <input type="submit" value="Submit" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	</form>
	<br>

</body>
</html>