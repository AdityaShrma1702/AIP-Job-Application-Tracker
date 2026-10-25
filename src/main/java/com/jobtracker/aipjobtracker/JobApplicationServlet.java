
package com.jobtracker.aipjobtracker;

import com.aipjobtracker.model.JobApplication;
import com.aipjobtracker.util.JobApplicationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/applications")
public class JobApplicationServlet extends HttpServlet {

    private final JobApplicationDAO dao = new JobApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String edit = request.getParameter("edit");

            // Load an application for editing
            if (edit != null && !edit.isBlank()) {
                int id = Integer.parseInt(edit);

                JobApplication application = dao.getApplicationById(id);

                if (application == null) {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Application not found"
                    );
                    return;
                }

                request.setAttribute("application", application);

                request.getRequestDispatcher("/edit-application.jsp")
                       .forward(request, response);
                return;
            }

            // Load applications and dashboard statistics
            List<JobApplication> applications = dao.getAllApplications();

            request.setAttribute("applications", applications);
            request.setAttribute("totalApplications",
                    dao.getTotalApplications());
            request.setAttribute("appliedCount",
                    dao.getApplicationsByStatus("Applied"));
            request.setAttribute("interviewCount",
                    dao.getApplicationsByStatus("Interview"));
            request.setAttribute("selectedCount",
                    dao.getApplicationsByStatus("Selected"));

            request.getRequestDispatcher("/applications.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application ID"
            );

        } catch (Exception e) {
            throw new ServletException("Unable to load applications", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // DELETE APPLICATION
        if ("delete".equalsIgnoreCase(action)) {

            // Accept either parameter name from the delete form
            String idText = request.getParameter("applicationId");

            if (idText == null || idText.isBlank()) {
                idText = request.getParameter("id");
            }

            try {
                if (idText == null || idText.isBlank()) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Application ID is missing"
                    );
                    return;
                }

                int id = Integer.parseInt(idText);

                System.out.println(
                        "DELETE ACTION RECEIVED. Application ID: " + id
                );

                dao.deleteApplication(id);

                System.out.println(
                        "DELETE DAO METHOD COMPLETED. Application ID: " + id
                );

                response.sendRedirect(
                        request.getContextPath() + "/applications"
                );
                return;

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid application ID"
                );
                return;

            } catch (Exception e) {
                throw new ServletException(
                        "Unable to delete application", e
                );
            }
        }

        // ADD OR UPDATE APPLICATION
        try {
            String idText = request.getParameter("applicationId");

            String company = request.getParameter("companyName");
            String title = request.getParameter("jobTitle");
            String location = request.getParameter("jobLocation");
            String status = request.getParameter("status");
            String dateText = request.getParameter("applicationDate");

            if (company == null || company.isBlank()
                    || title == null || title.isBlank()) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Company name and job title are required"
                );
                return;
            }

            Date date = (dateText == null || dateText.isBlank())
                    ? null
                    : Date.valueOf(dateText);

            if (location == null) {
                location = "";
            }

            if (status == null || status.isBlank()) {
                status = "Applied";
            }

            if (idText != null && !idText.isBlank()) {
                int id = Integer.parseInt(idText);

                dao.updateApplication(
                        id,
                        company.trim(),
                        title.trim(),
                        location.trim(),
                        status,
                        date
                );

            } else {
                dao.addApplication(
                        company.trim(),
                        title.trim(),
                        location.trim(),
                        status,
                        date
                );
            }

            response.sendRedirect(
                    request.getContextPath() + "/applications"
            );

        } catch (IllegalArgumentException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid application ID or date"
            );

        } catch (Exception e) {
            throw new ServletException("Unable to save application", e);
        }
    }
}
