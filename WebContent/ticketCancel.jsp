<%@ page import="com.database_project.CancellationManager" %>
<%@ page import="com.database_project.BookingModel" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	ResultSet resultset = null;
%>
<%
	ResultSet rs = null;
%>
<%
	ResultSet rs1 = null;
%>
<%
	String bookingId = request.getParameter("BookingId");
%>

<html>
<head>
<title>Ticket Cancellation</title>
</head>
<body bgcolor="#FEBAAD">
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver");
	Connection connection =  DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2?user=rnd91&password=rituja123");
	//Connection connection =DriverManager.getConnection("jdbc:mysql://localhost/bharathi?user=root&password=Santy@87");
		Statement statement = connection.createStatement();

		String query4 = "select * from Booking where booking_id ="
				+ bookingId + " and status='CANCELLED'";
		rs1 = statement.executeQuery(query4);

		if (rs1.next()) {
			out.println("Booking is already cancelled!!");
		}

		else {
			String query1 = "select * from Booking where booking_id ="
					+ bookingId + "";
			rs = statement.executeQuery(query1);
			if (rs.next()) {
	%>
	Canceling the Booking :
	<%=bookingId%>
	<%
		CancellationManager cancellationManager = new CancellationManager();
				cancellationManager.cancelReservation(Integer
						.valueOf(bookingId));
				

				String query2 = "select * from Booking where booking_id ="
						+ bookingId + "";
				resultset = statement.executeQuery(query2);
				if (resultset.next()) {
	%>
	<br />
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="30%">&nbsp;</td>
			<td width="70%">&nbsp;</td>
		</tr>

		<tr>
			<td><b> Cancellation Information </b></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Booking ID</td>
			<td><%=resultset.getInt(1)%>
			<td></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Phone Number</td>
			<td><%=resultset.getString(2)%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Route ID</td>
			<td><%=resultset.getInt(4)%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Date</td>
			<td><%=resultset.getString(5)%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>No. of seats</td>
			<td><%=resultset.getString(3)%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Status</td>
			<td><%=resultset.getString(6)%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<%
		}
			} else {
				out.println("Booking ID doesnot exist!!");
			}
		}
	%>
</body>
</html>
