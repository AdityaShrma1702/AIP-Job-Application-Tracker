
package com.aipjobtracker.util;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionTest {

    public static void main(String[] args) {
        try (Connection connection = DBConnection.getConnection()) {
            System.out.println("MySQL connection successful!");
            System.out.println("Database: "
                    + connection.getCatalog());
        } catch (SQLException e) {
            System.out.println("MySQL connection failed.");
            System.out.println(e.getMessage());
        }
    }
}
