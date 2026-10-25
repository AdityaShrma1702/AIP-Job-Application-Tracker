
package com.aipjobtracker.util;

import com.aipjobtracker.model.JobApplication;
import java.sql.SQLException;
import java.util.List;

public class DAOTest {

    public static void main(String[] args) {
        JobApplicationDAO dao = new JobApplicationDAO();

        try {
            List<JobApplication> applications =
                    dao.getAllApplications();

            System.out.println("Applications found: "
                    + applications.size());

            for (JobApplication app : applications) {
                System.out.println(
                        app.getApplicationId() + " | "
                        + app.getCompanyName() + " | "
                        + app.getJobTitle() + " | "
                        + app.getApplicationStatus()
                );
            }

        } catch (SQLException e) {
            System.out.println("Failed to retrieve applications.");
            System.out.println(e.getMessage());
        }
    }
}
