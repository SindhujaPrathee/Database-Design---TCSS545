package com.database_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class MySqlConnectionFactory {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Properties properties = new Properties();
            properties.setProperty("useSSL", "false");
            properties.setProperty("user", "rnd91");
            //properties.setProperty("user", "root");
            properties.setProperty("password", "rituja123");
            //properties.setProperty("password", "Santy@87");
            Connection connection = DriverManager.getConnection("jdbc:mysql://myindentifier.cqxh33xdqslc.us-east-1.rds.amazonaws.com:3306/BusBookingSystem2", properties);
            //Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/bharathi", properties);
            return connection;
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());

            throw new RuntimeException(ex);
        } catch (IllegalAccessException | InstantiationException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }
    }

}
