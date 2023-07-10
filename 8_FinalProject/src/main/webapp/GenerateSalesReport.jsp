<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">


	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='AdminSuccess.jsp';">Return to Dashboard</button> 
		
	<%@ page import ="java.sql.*" %>
		
	<form action="PostReport.jsp" method="POST">		
	<p style = "font-size:16pt;"><b>Generate your custom sales report</b> </p>
	
		<table align=center style="font-size:16pt; text-align:left;">
			
			<tr>
				<td><input type="checkbox" name="totalEarnings" value="totalEarnings"/> Total Earnings of the Auction</td>
			</tr>
			
			<tr>
				<td><input type="checkbox" name="bestSellingItems" value="bestSellingItems"/> Best-Selling Items</td>
			</tr>
			
			<tr>
				<td><input type="checkbox" name="bestBuyers" value="bestBuyers"/> Best Buyers</td>
			</tr>
		
			<tr>
				<td><input type="checkbox" name="earningsPerItem" value="earningsPerItem"/> Earnings per item</td>
			</tr>
			
			<tr>
				<td><input type="checkbox" name="earningsPerItemType" value="earningsPerItemType"/> Earnings per item type</td>
			</tr>
			
			<tr>
				<td><input type="checkbox" name="earningsPerEndUser" value="earningsPerEndUser"/> Earnings per End-User</td>
			</tr>
			
			
			
		</table>	
		
		<input type="submit" value="Submit" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	</form>


</body>
</html>