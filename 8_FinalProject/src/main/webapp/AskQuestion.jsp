<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>


	<br>
	<form action="InsertQuestion.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about for your question</b></p>
	
	<style>
		td{
			padding-bottom: 2em;
		}
	</style>
	
	
	<table>
		<tr>
		<td> <i style="color:red">Note:</i> If you would like to <i style="color:blue">edit</i> your account, <i style="color:blue">delete</i> your account, <i style="color:blue">remove an auction</i> or <i style="color:blue">remove a bid</i> please specify the following:</td>
		</tr>
		
		<tr>
		<td><a style="color:blue">Edit Account:</a> Please state which of the following you would like changed to: <i style="color:blue"> 'password', &nbsp 'name', &nbsp 'phoneNumber', &nbsp 'email', and &nbsp 'address' </i></td>
		</tr>
		<tr>
		<td><a style="color:blue">Delete Account:</a> Please state that you would like to <i style="color:blue">delete</i> your account!</td>
		</tr>
		<tr>
		<td><a style="color:blue">Remove an Auction:</a> Please state the <i style="color:blue">auctionID</i> you would like to remove!</td>
		</tr>
		<tr>
		<td><a style="color:blue">Remove a bid:</a> Please state the <i style="color:blue">bidID</i> which you would like to remove!</td>
		</tr>
	</table>


	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter your question: <input type="text" name="question" placeholder="question" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit Question" style="font-size:14pt; background-color:#90D5EC;">
	</form>
	<br>
	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='BrowseQandA.jsp';">Click here to browse questions and answers</button>

</body>
</html>