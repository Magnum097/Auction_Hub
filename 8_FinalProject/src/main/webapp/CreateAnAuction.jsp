<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">

<title>Create an Auction</title>
</head>
<body style = "background:#FAEBEFFF; font-family:optima;">

	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';"> Return to User Dashboard</button>

	<form action="InsertItemAndAuction.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about your <i style="color:blue">Shoe</i></b></p>
	 <table style="font-size:16pt; text-align:left">
       <tr>
		   <td>
		   Select the type of <i style="color:blue">shoe</i> you want to sell: 
		   </td>
	   </tr>
	   <tr>
		   <td>
			   <input type="radio" name="shoe" value="isSneakers"/> Sneakers
			   <input type="radio" name="shoe" value="isBoots"/> Boots
			   <input type="radio" name="shoe" value="isSandals"/> Sandals
		   </td>
	   </tr>
	   
	   <tr height=15px></tr>
	   
	   <tr>
	   	<td><u style="color:blue">[required fields]</u> &nbsp</td>	
	   </tr>
	   
	   <!-- required fields -->
	   <tr>    
	   <td> Name of the shoe: <input type="text" name="nameOfShoe" placeholder="name" required></td>
	   </tr>
	   
	   <tr>    
	   <td> Color: <input type="text" name="color" placeholder="Color" required></td>
	   </tr>
	   
	   <tr>    
	   <td> Size: <input type="number" step="any" name="size" placeholder="0.0" required></td>
	   </tr>
	   
	   <tr>    
	   <td> Material: <input type="text" name="material" placeholder="leather/rubber/foam" required></td>
	   </tr>
	   
	   <tr>    
	   <td> Company/Brand: <input type="text" name="companyOrBrand" placeholder="company/brand name" required></td>
	   </tr>
	   
	   <tr height=15px></tr>
	   <!-- NON- required fields -->
	   <tr>
	   	<td> <u style="color:blue">[non-required fields]</u> &nbsp</td>	
	   </tr>
	   
	   <tr>    
	   <td>Purpose: <input type="text" name="purpose" placeholder="casual/walking/running"></td>
	   </tr>
	    
	   <tr>    
	   <td>HighTop: <input type="text" name="highTop" placeholder="yes/no"></td>     <!-- change to varchar in sql -->
	   </tr>
	   
	   <tr>
	   <td>Heel Height: <input type="number" step="any" name="heelHeight" placeholder="0.0"></td>
	   </tr>
	   
	   <tr>
	   <td>Type: <input type="text" step="any" name="type" placeholder="laced/ankled/snow"></td>
	   </tr>
	   
	   
	   <tr>    
	   <td>Ankle Straps: <input type="text" step="any" name="ankleStraps" placeholder="yes/no"></td>
	   </tr>
	   
	   <tr>    
	   <td>Open Toed: <input type="text" name="openToed" placeholder="yes/no"></td>
	   </tr>
	   
		
	 </table>
	   
	   		
		   <p style = "font-size:16pt;"><b>Enter the details about your Auction</b></p>
		   <table style="font-size:16pt; text-align:left">
		   		
			   <tr>    
			   <td>Enter the initial price of this item: <input type="number" step="any" name="initialPrice" placeholder="0.0" required></td>
			   </tr>
			   
			   <tr>    
			   <td>Enter the minimum price of this item: <input type="number" step="any" name="minimumPrice" placeholder="0.0" required></td>
			   </tr>
			   
			   <tr>    
			   <td>Enter the standard bidding increment of this auction: <input type="number" step="any" name="standardBiddingIncrement" placeholder="0.0" required></td>
			   </tr>
			   
			    <tr>    
			   <td>Enter opening date of auction: <input type="text" name="openingDate" placeholder="yyyy-mm-dd hh:mm:ss" required></td>
			   </tr> 
			   
			   <tr>    
			   <td>Enter closing date of auction: <input type="text" name="closingDate" placeholder="yyyy-mm-dd hh:mm:ss" required></td>
			   </tr> 
			   
			   <tr>
			   <td><br><input style="font-size:14pt; background-color:#90D5EC;" type="submit" value="Create Auction"></td>
			   </tr>
	   		</table>
	   		
	   		
	</form>

</body>
</html>