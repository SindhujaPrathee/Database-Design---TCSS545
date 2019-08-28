package com.database_project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CancellationManager {

    public void cancelReservation(int bookingId) {
        try (Connection connection = MySqlConnectionFactory.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE Booking SET status='CANCELLED' WHERE booking_id=?");
            preparedStatement.setInt(1, bookingId);
            preparedStatement.execute();
            PreparedStatement preparedStatement1 = connection.prepareStatement("SELECT seats_booked, bus_route_id FROM Booking WHERE booking_id =? and status = 'CANCELLED'");
            preparedStatement1.setInt(1, bookingId);
            ResultSet resultSet = preparedStatement1.executeQuery();
            if (resultSet.next()) {
                int seats = resultSet.getInt("seats_booked");
                int route = resultSet.getInt("bus_route_id");
                PreparedStatement preparedStatement2 = connection.prepareStatement("UPDATE Bus_schedule SET available_seats = Bus_schedule.available_seats + ? WHERE bus_route_id = ?");
                preparedStatement2.setInt(1, seats);
                preparedStatement2.setInt(2, route);
                preparedStatement2.execute();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
    	
    	 new CancellationManager().cancelReservation(1);
    }
}
