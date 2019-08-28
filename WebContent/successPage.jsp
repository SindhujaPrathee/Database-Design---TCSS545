<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success page</title>
</head>
<body bgcolor="#FEBAAD">
<body>
	<%
		ResultSet resultset = null;
	%>
	<%
		ResultSet rs = null;
	%>
	<%
		CallableStatement procstate1 = null;
	%>
	<%
		CallableStatement procstate2 = null;
	%>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		String f_name = request.getParameter("f_name");
		String l_name = request.getParameter("l_name");

		int no_of_passengers = Integer.parseInt(request
				.getParameter("no_of_passengers"));

		String travel_date = (String) session.getAttribute("travel_date");

		String mobile_no = request.getParameter("mobile_no");
		int bus_route_id = (Integer) session.getAttribute("bus_route_id");

		int s = (Integer) session.getAttribute("available_seats");
		int seat_availability = s - no_of_passengers;
		int i = 0;

		String status = "BOOKED";

		try {

			if (seat_availability > 0) {

				Class.forName("com.mysql.jdbc.Driver");
				Connection connection =  DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2?user=rnd91&password=rituja123");
				//java.sql.Connection connection = DriverManager
					//	.getConnection("jdbc:mysql://localhost/bharathi?user=root&password=Santy@87");
				Statement statement = connection.createStatement();
				String query1 = "select * from Passenger where mobile_number='"
						+ mobile_no + "'";
				resultset = statement.executeQuery(query1);
				if (!resultset.next()) {

					String query2 = "insert into Passenger (mobile_number,first_name,last_name) values('"
							+ mobile_no
							+ "','"
							+ f_name
							+ "', '"
							+ l_name
							+ "')";
					i = statement.executeUpdate(query2);

					procstate1 = connection
							.prepareCall("{call INSERT_INTO_BOOKING(?,?,?,?,?,?)}");
					procstate1.setEscapeProcessing(true);
					procstate1.setQueryTimeout(90);
					procstate1.setString(1, mobile_no);
					procstate1.setInt(2, no_of_passengers);
					procstate1.setInt(3, bus_route_id);
					procstate1.setString(4, status);
					procstate1.setInt(5, seat_availability);
					procstate1.setString(6, travel_date);
					i = procstate1.executeUpdate();

					procstate2 = connection
							.prepareCall("{call SELECT_BOOKINGID(?,?,?)}");
					procstate2.setEscapeProcessing(true);
					procstate2.setQueryTimeout(90);
					procstate2.setString(1, mobile_no);
					procstate2.setInt(2, bus_route_id);
					procstate2.registerOutParameter(3, Types.INTEGER);
					procstate2.execute();

					out.println("Your booking id is "
							+ procstate2.getInt(3));
				} else {
					String query3 = "select * from Passenger where mobile_number='"
							+ mobile_no
							+ "' and first_name='"
							+ f_name
							+ "' and last_name='" + l_name + "'";
					rs = statement.executeQuery(query3);
					if (!rs.next()) {
						out.println("The mobile number is already registered with another user. Same user can only book!!");
					} else {
						procstate1 = connection
								.prepareCall("{call INSERT_INTO_BOOKING(?,?,?,?,?,?)}");
						procstate1.setEscapeProcessing(true);
						procstate1.setQueryTimeout(90);
						procstate1.setString(1, mobile_no);
						procstate1.setInt(2, no_of_passengers);
						procstate1.setInt(3, bus_route_id);
						procstate1.setString(4, status);
						procstate1.setInt(5, seat_availability);
						procstate1.setString(6, travel_date);
						i = procstate1.executeUpdate();

						procstate2 = connection
								.prepareCall("{call SELECT_BOOKINGID(?,?,?)}");
						procstate2.setEscapeProcessing(true);
						procstate2.setQueryTimeout(90);
						procstate2.setString(1, mobile_no);
						procstate2.setInt(2, bus_route_id);
						procstate2.registerOutParameter(3, Types.INTEGER);
						procstate2.execute();

						out.println("Your booking id is "
								+ procstate2.getInt(3));
					}
				}
			} else {
				out.println("Please check the seat Availability and Enter the number of passengers accordingly!!");
			}
			
			
		}
		
		catch (Exception e) {
			out.println("wrong entry" + e);
		}
	%>
	</br>
	</br>
	<a href="index.html"> Home</a>
</body>
</html>