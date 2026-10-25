
package com.aipjobtracker.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/job_tracker";
    private static final String USER = "root";

    // Replace this with your MySQL password locally.
    private static final String PASSWORD = "Apna Password Likho Bhai-not real password.";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
