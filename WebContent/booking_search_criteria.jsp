<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%ResultSet resultset =null;%>


<html>
<h2>RBS Online Bus Booking System </h2><br>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search_Buses</title>

</head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  
  <script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  </script>
<body>

<body bgcolor="#FEBAAD">

<form name="booking_criteria"  method="post" action="booking_search_results.jsp" onsubmit="return required()">

<%
    try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection connection =  DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2?user=rnd91&password=rituja123");
			//Connection connection =  DriverManager.getConnection("jdbc:mysql://localhost/bharathi?user=root&password=Santy@87");
       		Statement statement = connection.createStatement() ;
     	    String Query1="select DISTINCT source from Bus";
    	    String Query2="select DISTINCT destination from Bus";
   	 	    resultset =statement.executeQuery(Query1) ;
%>
        
      <select type="hidden" name ="From" style="width: 160; height: 24; background-color: #97cfc3">  
      
      <option >From</option>
        <%  while(resultset.next()){ %>
       <option value="<%= resultset.getString(1)%>"><%= resultset.getString(1)%></option>
             <% } %>
        </select>       
        
<%
  			resultset =statement.executeQuery(Query2) ;
            
%>
			<select type="Hidden" name="To" style="width: 160; height: 24; background-color: #97cfc3">
			
			<option value="To" >To</option>
        	<%  while(resultset.next()){ %>
            <option value="<%= resultset.getString(1)%>" ><%= resultset.getString(1)%></option>
             <% } %>
        </select> 
         
Date: <input type="text" id="datepicker" name="date" required style="width: 160; height: 24; background-color: #97cfc3" >

      <input type="submit" value="submit" style="width: 160; height: 24; background-color: #97cfc3" >    
      
<%

  }
		
        catch(Exception e)
        {
             out.println("wrong entry"+e);
        }

%>
</form>
<script src="errorvalidation.js"></script>
</BODY>
</HTML>