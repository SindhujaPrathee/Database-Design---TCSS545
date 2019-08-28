<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	ResultSet resultset = null;
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking</title>
</head>
<body>
<body bgcolor="#FEBAAD">
	<form name="booking" method="post" action="successPage.jsp"
		onsubmit="return required()">
		<form method="get" action="successPage.jsp"
			onsubmit="return required()">

			<%
				int bus_route_id = Integer.parseInt(request.getParameter("Id"));
				session.setAttribute("bus_route_id", bus_route_id);
				String travel_date = (String) session.getAttribute("travel_date");
				session.setAttribute("travel_date", travel_date);
				String status = "booked";

				try {
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection connection =  DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2?user=rnd91&password=rituja123");
					//Connection connection = DriverManager
							//.getConnection("jdbc:mysql://localhost/bharathi?user=root&password=Santy@87");
					Statement statement = connection.createStatement();
					String Query1 = "select A.source, A.destination, B.departure_time, B.arrival_time, B.available_seats, B.cost from Bus A,Bus_schedule B where B.bus_route_id='"
							+ bus_route_id + "' and B.bus_id = A.bus_id";

					resultset = statement.executeQuery(Query1);

					while (resultset.next()) {
						int s = resultset.getInt(5);
						//for(int i=1; i <= columnCount; i++) {
						//out.print("<TD>" + resultset.getString(i));
			%>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="30%">&nbsp;</td>
					<td width="70%">&nbsp;</td>
				</tr>
				<tr>
					<td>From</td>
					<td><input type="text" name="source"
						value="<%=resultset.getString(1)%>" readonly></td>
				</tr>

				<tr>

					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>To</td>
					<td><input type="text" name="destination"
						value="<%=resultset.getString(2)%>" readonly></td>
				</tr>
				<tr>

					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Departure Time</td>
					<td><input type="text" name="departure_time" value="<%=resultset.getString(3)%>" readonly></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Arrival Time</td>
					<td><input type="text" name="arrival_time" value="<%=resultset.getString(4)%>" readonly></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Available Number of seats</td>
					<td><input type="text" name="available_seats"
						id="available_seats" value="<%=resultset.getInt(5)%>" readonly></td>
				</tr>

				<%
					session.setAttribute("available_seats", s);
				%>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Cost</td>
					<td><input type="number" name="cost"
						value="<%=resultset.getInt(6)%>" readonly></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>First Name</td>
					<td><input type="text" name="f_name"></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>Last Name</td>
					<td><input type="text" name="l_name"></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Number of Passengers</td>
					<td><input type="text" name="no_of_passengers"
						id="no_of_passengers"
						onkeypress="if (isNaN(String.fromCharCode(event.keyCode))) return false;" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>Mobile Number</td>
					<td><input type="text" name="mobile_no"
						onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Book"></td>
				</tr>
			</table>

			<%
				}

				}

				catch (Exception e) {
					out.println("wrong entry" + e);
				}
			%>
		</form>

		<script src="booking_error.js"></script>
</body>
</html>