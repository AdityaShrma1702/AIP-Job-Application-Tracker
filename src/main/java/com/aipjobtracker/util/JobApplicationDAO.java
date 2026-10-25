
package com.aipjobtracker.util;

import com.aipjobtracker.model.JobApplication;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobApplicationDAO {

    public List<JobApplication> getAllApplications()
            throws SQLException {

        List<JobApplication> list = new ArrayList<>();

        String sql = "SELECT * FROM job_applications "
                   + "ORDER BY application_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                JobApplication a = new JobApplication();

                a.setApplicationId(rs.getInt("application_id"));
                a.setCompanyName(rs.getString("company_name"));
                a.setJobTitle(rs.getString("job_title"));
                a.setJobLocation(rs.getString("job_location"));
                a.setApplicationStatus(
                        rs.getString("application_status"));
                a.setApplicationDate(
                        rs.getDate("application_date"));

                list.add(a);
            }
        }

        return list;
    }

    public JobApplication getApplicationById(int id)
            throws SQLException {

        String sql = "SELECT * FROM job_applications "
                   + "WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    JobApplication a = new JobApplication();

                    a.setApplicationId(rs.getInt("application_id"));
                    a.setCompanyName(rs.getString("company_name"));
                    a.setJobTitle(rs.getString("job_title"));
                    a.setJobLocation(rs.getString("job_location"));
                    a.setApplicationStatus(
                            rs.getString("application_status"));
                    a.setApplicationDate(
                            rs.getDate("application_date"));

                    return a;
                }
            }
        }

        return null;
    }

    public void addApplication(String companyName,
                               String jobTitle,
                               String jobLocation,
                               String status,
                               Date applicationDate)
            throws SQLException {

        String sql = "INSERT INTO job_applications "
                   + "(company_name, job_title, job_location, "
                   + "application_status, application_date) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, companyName);
            ps.setString(2, jobTitle);
            ps.setString(3, jobLocation);
            ps.setString(4, status);

            ps.setDate(5, applicationDate != null
                    ? applicationDate
                    : new Date(System.currentTimeMillis()));

            ps.executeUpdate();
        }
    }

    public void updateApplication(int id,
                                  String companyName,
                                  String jobTitle,
                                  String jobLocation,
                                  String status,
                                  Date applicationDate)
            throws SQLException {

        String sql = "UPDATE job_applications SET "
                   + "company_name = ?, job_title = ?, "
                   + "job_location = ?, application_status = ?, "
                   + "application_date = ? WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, companyName);
            ps.setString(2, jobTitle);
            ps.setString(3, jobLocation);
            ps.setString(4, status);

            ps.setDate(5, applicationDate != null
                    ? applicationDate
                    : new Date(System.currentTimeMillis()));

            ps.setInt(6, id);

            ps.executeUpdate();
        }
    }

    public void deleteApplication(int id) throws SQLException {

        String sql = "DELETE FROM job_applications "
                   + "WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Dashboard statistics

    public int getTotalApplications() throws SQLException {
        return getCount("SELECT COUNT(*) FROM job_applications");
    }

    public int getApplicationsByStatus(String status)
            throws SQLException {

        String sql = "SELECT COUNT(*) FROM job_applications "
                   + "WHERE application_status = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    private int getCount(String sql) throws SQLException {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }
}
