<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	ResultSet resultset = null;
%>
<html>
<h2>RBS Online Bus Booking System </h2><br>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search_Results</title>
</head>
<body bgcolor="#FEBAAD">
<body>
	<form method="post" action="booking.jsp">
	<form method="get" action="booking.jsp">
		

			<%
				try {
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection connection =  DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2?user=rnd91&password=rituja123");
					//Connection connection = DriverManager
							//.getConnection("jdbc:mysql://localhost/bharathi?user=root&password=Santy@87");
					Statement statement = connection.createStatement();

					String From = request.getParameter("From");

					String To = request.getParameter("To");

					String Travel_date = request.getParameter("date");
					session.setAttribute("travel_date", Travel_date);

					String Query3 = "select B.bus_route_id, A.bus_id, A.source, A.destination, B.departure_time, B.arrival_time, B. total_seats, B.available_seats, B.cost from Bus A, Bus_schedule B where A.source='"
							+ From
							+ "' AND A.destination='"
							+ To
							+ "' AND A.Bus_id = B.Bus_id";
					String Query4 = "select B.bus_route_id, A.bus_id from Bus A,Bus_schedule B where A.source='"
							+ From
							+ "' AND A.destination='"
							+ To
							+ "' AND A.bus_id = B.bus_id";
					resultset = statement.executeQuery(Query3);

					out.println("<TABLE BORDER=1");

					ResultSetMetaData resultSetMetaData = resultset.getMetaData();
					int columnCount = resultSetMetaData.getColumnCount();
					out.println("<TR>");

					for (int i = 1; i <= columnCount; i++) {
						out.print("<TH>" + resultSetMetaData.getColumnName(i));
					}
					out.print("<TH>" + "Journey Date");
					out.println();

					while (resultset.next()) {

						out.println("<TR>");

						out.print("<TD>");
			%>
			<a href=<%="\"booking.jsp?Id=" + resultset.getInt(1) + "\""%>><%=resultset.getInt(1)%></a>
			<%
				out.print("<TD>" + resultset.getInt(2));
						out.print("<TD>" + resultset.getString(3));
						out.print("<TD>" + resultset.getString(4));
						out.print("<TD>" + resultset.getString(5));
						out.print("<TD>" + resultset.getString(6));
						out.print("<TD>" + resultset.getInt(7));
						out.print("<TD>" + resultset.getInt(8));
						out.print("<TD>" + resultset.getInt(9));
						out.print("<TD>" + Travel_date);
						//}
						out.println();
					}
					out.println();
					out.println("</TABLE>");
					resultset = statement.executeQuery(Query4);
					if (!resultset.next()) {
						out.println("NO ROUTES AVAILABLE!!");
			%>
			</br>
			</br>
			<a href="booking_search_criteria.jsp"> Search Again</a>
			<%
				}
				} catch (Exception e) {
					out.println("wrong entry" + e);
				}
			%>
	</form>	
</BODY>
</HTML>