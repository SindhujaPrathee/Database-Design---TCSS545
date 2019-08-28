<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<h2>RBS Online Bus Booking System </h2><br>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking History</title>
</head>
<body>
<body bgcolor="#FEBAAD">
	<%
		String driverName = "com.mysql.jdbc.Driver";
		Connection connection = null;
		Statement st = null;
		String sqlQuery = "";
		ResultSet rs = null;

		String booking_id = "";
		String mobile = "";
		try {
			booking_id = request.getParameter("booking_id");
			mobile = request.getParameter("phone_number");
		} catch (NullPointerException e) {
			out.println(e);
		}

		Properties properties = new Properties();
		properties.setProperty("useSSL", "false");
		properties.setProperty("user", "rnd91");
		properties.setProperty("password", "rituja123");
		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	%>
	<h2 align="center">
		<font><strong>Your Travel History is shown below: </strong></font>
	</h2>
	
		<%
			try {
					connection = DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2", properties);
					st = connection.createStatement();

					if ((booking_id == "") && ( mobile == ""))
					{
	                   
						out.println("You need to enter either mobile number or booking ID to retrieve your booking.....");
	                
					}
					else	if (!booking_id.equals("booking id") && !mobile.equals("mobile number") && booking_id != "" && mobile != "")
					
					{
						sqlQuery = "SELECT bk.booking_id, p.First_Name,p.Last_Name,bk.mobile_number, bk.seats_booked,b.source,b.destination,bk.travel_date,bk.status FROM Booking bk, Passenger p, Bus_schedule bs, Bus b WHERE bk.bus_route_id=bs.bus_route_id and bs.bus_id=b.bus_id and p.mobile_number=bk.mobile_number and bk.booking_id =" +booking_id;
					} 
					
					else if (!booking_id.equals("booking id") && booking_id != "")
					{
						sqlQuery = "SELECT bk.booking_id, p.First_Name,p.Last_Name,bk.mobile_number, bk.seats_booked,b.source,b.destination,bk.travel_date,bk.status FROM Booking bk, Passenger p, Bus_schedule bs, Bus b WHERE bk.bus_route_id=bs.bus_route_id and bs.bus_id=b.bus_id and p.mobile_number=bk.mobile_number and bk.booking_id = " + booking_id;
					} 
					
					else if (!mobile.equals("mobile number") && mobile != "")

					{
						sqlQuery = "SELECT bk.booking_id, p.First_Name,p.Last_Name,bk.mobile_number, bk.seats_booked,b.source,b.destination,bk.travel_date,bk.status FROM Booking bk, Passenger p, Bus_schedule bs, Bus b WHERE bk.bus_route_id=bs.bus_route_id and bs.bus_id=b.bus_id and p.mobile_number=bk.mobile_number and bk.mobile_number = " + mobile;
					} 
				
					rs = st.executeQuery(sqlQuery);
				    if (rs.next()) {
		%>
		<table align="center" cellpadding="5" cellspacing="5" border="1">
		<tr>

		</tr>
			<tr bgcolor="#91F3F1">
			<th>Booking ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Mobile Number</th>
			<th>Number of Seats Booked</th>
			<th>Source</th>
			<th>Destination</th>
			<th>Date of Journey</th>
			<th>Booking Status</th>
		</tr>
		<%
			do {
		%>

		<tr bgcolor="#91F3AF">
			<td><%=rs.getString("Booking_Id")%></td>
			<td><%=rs.getString("First_Name")%></td>
			<td><%=rs.getString("Last_Name")%></td>
			<td><%=rs.getString("mobile_number")%></td>
			<td><%=rs.getString("seats_booked")%></td>
			<td><%=rs.getString("source")%></td>
			<td><%=rs.getString("destination")%></td>
			<td><%=rs.getString("travel_date")%></td>
			<td><%=rs.getString("status")%></td>
		</tr>
		<%
			} while (rs.next());
				} else
					out.println("Record not found");
				%>
				<a href="BookingHistory.html"> Search Again</a>
				<a href="index.html">Home Page</a>
				<%

			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</table>
</body>
</html>