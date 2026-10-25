<%-- 
    Document   : edit-application
    Created on : Oct 23, 2026, 10:06:30 PM
    Author     : hp
--%>

<%-- 
    Document   : edit-application
    Created on : Oct 23, 2026
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.aipjobtracker.model.JobApplication"%>

<%
    JobApplication jobApp =
            (JobApplication) request.getAttribute("application");

    if (jobApp == null) {
        response.sendRedirect(
                request.getContextPath() + "/applications"
        );
        return;
    }

    String applicationDate = "";

    if (jobApp.getApplicationDate() != null) {
        applicationDate = jobApp.getApplicationDate().toString();
    }

    String status = jobApp.getApplicationStatus();

    if (status == null || status.trim().isEmpty()) {
        status = "Applied";
    }

    String companyName = jobApp.getCompanyName() == null
            ? "" : jobApp.getCompanyName();

    String jobTitle = jobApp.getJobTitle() == null
            ? "" : jobApp.getJobTitle();

    String jobLocation = jobApp.getJobLocation() == null
            ? "" : jobApp.getJobLocation();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Job Application</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f3f4f6;
            margin: 0;
            padding: 40px 20px;
        }

        .container {
            max-width: 550px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px #00000012;
        }

        h2 {
            color: #1f2937;
            margin-top: 0;
            margin-bottom: 24px;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 6px;
            font-weight: bold;
            color: #374151;
        }

        input,
        select {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 15px;
            background: #fff;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 2px #2563eb20;
        }

        button {
            margin-top: 24px;
            width: 100%;
            padding: 12px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #1d4ed8;
        }

        .back {
            display: inline-block;
            margin-top: 18px;
            color: #2563eb;
            text-decoration: none;
        }

        .back:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Edit Job Application</h2>

    <form action="<%= request.getContextPath() %>/applications"
          method="post">

        <input type="hidden"
               name="applicationId"
               value="<%= jobApp.getApplicationId() %>">

        <label for="companyName">Company Name *</label>
        <input type="text"
               id="companyName"
               name="companyName"
               value="<%= companyName %>"
               required>

        <label for="jobTitle">Job Title *</label>
        <input type="text"
               id="jobTitle"
               name="jobTitle"
               value="<%= jobTitle %>"
               required>

        <label for="jobLocation">Location</label>
        <input type="text"
               id="jobLocation"
               name="jobLocation"
               value="<%= jobLocation %>">

        <label for="status">Application Status</label>
        <select id="status" name="status">
            <option value="Applied"
                <%= "Applied".equalsIgnoreCase(status) ? "selected" : "" %>>
                Applied
            </option>

            <option value="Interview"
                <%= "Interview".equalsIgnoreCase(status) ? "selected" : "" %>>
                Interview
            </option>

            <option value="Selected"
                <%= "Selected".equalsIgnoreCase(status) ? "selected" : "" %>>
                Selected
            </option>

            <option value="Rejected"
                <%= "Rejected".equalsIgnoreCase(status) ? "selected" : "" %>>
                Rejected
            </option>
        </select>

        <label for="applicationDate">Application Date</label>
        <input type="date"
               id="applicationDate"
               name="applicationDate"
               value="<%= applicationDate %>">

        <button type="submit">Update Application</button>

    </form>

    <a class="back"
       href="<%= request.getContextPath() %>/applications">
        &larr; Back to Applications
    </a>

</div>

</body>
</html>