<%-- 
    Document   : applications
    Created on : Oct 23, 2026, 12:33:02 AM
    Author     : hp
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aipjobtracker.model.JobApplication" %>

<%
    List<JobApplication> applications =
        (List<JobApplication>) request.getAttribute("applications");

    Integer totalValue =
        (Integer) request.getAttribute("totalApplications");
    Integer appliedValue =
        (Integer) request.getAttribute("appliedCount");
    Integer interviewValue =
        (Integer) request.getAttribute("interviewCount");
    Integer selectedValue =
        (Integer) request.getAttribute("selectedCount");

    int totalApplications = totalValue == null ? 0 : totalValue;
    int appliedCount = appliedValue == null ? 0 : appliedValue;
    int interviewCount = interviewValue == null ? 0 : interviewValue;
    int selectedCount = selectedValue == null ? 0 : selectedValue;

    int chartApplied = 0;
    int chartInterview = 0;
    int chartSelected = 0;
    int chartRejected = 0;
    int chartOther = 0;

    if (applications != null) {
        for (JobApplication app : applications) {
            String status = app.getApplicationStatus();

            if (status == null) {
                chartOther++;
            } else if (status.equalsIgnoreCase("Applied")) {
                chartApplied++;
            } else if (status.equalsIgnoreCase("Interview")) {
                chartInterview++;
            } else if (status.equalsIgnoreCase("Selected")) {
                chartSelected++;
            } else if (status.equalsIgnoreCase("Rejected")) {
                chartRejected++;
            } else {
                chartOther++;
            }
        }
    }

    int chartTotal = chartApplied + chartInterview
                   + chartSelected + chartRejected + chartOther;

    double successRate = chartTotal == 0 ? 0.0
            : (chartSelected * 100.0 / chartTotal);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Application Tracker</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
            color: #1f2937;
        }

        .container {
            max-width: 1250px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        .page-header h1 {
            margin: 0 0 8px;
            font-size: 30px;
            color: #111827;
        }

        .page-header p {
            margin: 0;
            color: #6b7280;
        }

        .btn {
            display: inline-block;
            padding: 11px 16px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-primary {
            color: white;
            background: #2563eb;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 22px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 18px rgba(0, 0, 0, 0.07);
        }

        .stat-card.active {
            border: 2px solid #2563eb;
        }

        .stat-label {
            color: #6b7280;
            font-size: 14px;
        }

        .stat-number {
            display: block;
            margin-top: 12px;
            font-size: 30px;
            font-weight: bold;
            color: #111827;
        }

        .analytics-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr) minmax(240px, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .panel {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 24px;
            min-width: 0;
        }

        .panel h2 {
            margin: 0 0 7px;
            font-size: 20px;
            color: #111827;
        }

        .panel-subtitle {
            margin: 0 0 25px;
            color: #6b7280;
            font-size: 14px;
        }

        .chart-row {
            margin-bottom: 20px;
        }

        .chart-label {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .chart-track {
            width: 100%;
            height: 12px;
            background: #f3f4f6;
            border-radius: 20px;
            overflow: hidden;
        }

        .chart-bar {
            height: 100%;
            border-radius: 20px;
            transition: width 0.4s ease;
        }

        .applied-bar {
            background: #3b82f6;
        }

        .interview-bar {
            background: #f59e0b;
        }

        .selected-bar {
            background: #22c55e;
        }

        .rejected-bar {
            background: #ef4444;
        }

        .other-bar {
            background: #9ca3af;
        }

        .analytics-total {
            border-top: 1px solid #e5e7eb;
            padding-top: 15px;
            margin: 18px 0 0;
            color: #6b7280;
            font-size: 13px;
        }

        .success-number {
            margin: 22px 0 8px;
            font-size: 42px;
            font-weight: bold;
            color: #16a34a;
        }

        .success-description {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .success-track {
            height: 14px;
            background: #f3f4f6;
            border-radius: 20px;
            overflow: hidden;
            margin-top: 20px;
        }

        .success-fill {
            height: 100%;
            background: #22c55e;
            border-radius: 20px;
        }

        .table-panel {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 24px;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .table-header h2 {
            margin: 0;
            font-size: 20px;
        }

        .filters {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .filters input,
        .filters select {
            min-width: 180px;
            padding: 11px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 14px;
            background: white;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 15px 12px;
            border-bottom: 1px solid #e5e7eb;
            white-space: nowrap;
            font-size: 14px;
        }

        th {
            background: #f9fafb;
            color: #6b7280;
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-applied {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-interview {
            background: #ffedd5;
            color: #c2410c;
        }

        .status-selected {
            background: #dcfce7;
            color: #15803d;
        }

        .status-rejected {
            background: #fee2e2;
            color: #b91c1c;
        }

        .status-other {
            background: #f3f4f6;
            color: #374151;
        }

        .action-link {
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
        }

        .edit-link {
            color: #2563eb;
        }

        .delete-link {
            color: #dc2626;
        }

        .empty-message {
            text-align: center;
            color: #6b7280;
            padding: 30px;
        }

        .no-results {
            display: none;
            padding: 25px;
            text-align: center;
            color: #6b7280;
        }

        @media (max-width: 900px) {
            .dashboard {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .analytics-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 550px) {
            body {
                padding: 15px;
            }

            .dashboard {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .stat-card {
                padding: 15px;
            }

            .stat-number {
                font-size: 25px;
            }

            .panel, .table-panel {
                padding: 16px;
            }

            .filters input, .filters select {
                width: 100%;
                min-width: 0;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <header class="page-header">
        <div>
            <h1>Job Application Tracker</h1>
            <p>Track your applications and monitor your progress.</p>
        </div>

        <a class="btn btn-primary"
           href="<%= request.getContextPath() %>/add-application.jsp">
            + Add Application
        </a>
    </header>

    <!-- Dashboard cards -->
    <section class="dashboard">

        <div class="stat-card active" data-card-status="All">
            <span class="stat-label">Total Applications</span>
            <span class="stat-number"><%= totalApplications %></span>
        </div>

        <div class="stat-card" data-card-status="Applied">
            <span class="stat-label">Applied</span>
            <span class="stat-number"><%= appliedCount %></span>
        </div>

        <div class="stat-card" data-card-status="Interview">
            <span class="stat-label">Interviews</span>
            <span class="stat-number"><%= interviewCount %></span>
        </div>

        <div class="stat-card" data-card-status="Selected">
            <span class="stat-label">Selected</span>
            <span class="stat-number"><%= selectedCount %></span>
        </div>

    </section>

    <!-- Dashboard analytics -->
    <section class="analytics-grid">

        <div class="panel">
            <h2>Status Distribution</h2>
            <p class="panel-subtitle">
                Breakdown of your loaded job applications
            </p>

            <div class="chart-row">
                <div class="chart-label">
                    <span>Applied</span>
                    <strong><%= chartApplied %></strong>
                </div>
                <div class="chart-track">
                    <div class="chart-bar applied-bar"
                         style="width: <%= chartTotal == 0 ? 0 : chartApplied * 100.0 / chartTotal %>%;"></div>
                </div>
            </div>

            <div class="chart-row">
                <div class="chart-label">
                    <span>Interview</span>
                    <strong><%= chartInterview %></strong>
                </div>
                <div class="chart-track">
                    <div class="chart-bar interview-bar"
                         style="width: <%= chartTotal == 0 ? 0 : chartInterview * 100.0 / chartTotal %>%;"></div>
                </div>
            </div>

            <div class="chart-row">
                <div class="chart-label">
                    <span>Selected</span>
                    <strong><%= chartSelected %></strong>
                </div>
                <div class="chart-track">
                    <div class="chart-bar selected-bar"
                         style="width: <%= chartTotal == 0 ? 0 : chartSelected * 100.0 / chartTotal %>%;"></div>
                </div>
            </div>

            <div class="chart-row">
                <div class="chart-label">
                    <span>Rejected</span>
                    <strong><%= chartRejected %></strong>
                </div>
                <div class="chart-track">
                    <div class="chart-bar rejected-bar"
                         style="width: <%= chartTotal == 0 ? 0 : chartRejected * 100.0 / chartTotal %>%;"></div>
                </div>
            </div>

            <% if (chartOther > 0) { %>
            <div class="chart-row">
                <div class="chart-label">
                    <span>Other / Unknown</span>
                    <strong><%= chartOther %></strong>
                </div>
                <div class="chart-track">
                    <div class="chart-bar other-bar"
                         style="width: <%= chartTotal == 0 ? 0 : chartOther * 100.0 / chartTotal %>%;"></div>
                </div>
            </div>
            <% } %>

            <p class="analytics-total">
                Total categorized applications: <%= chartTotal %>
            </p>
        </div>

        <div class="panel">
            <h2>Application Success Rate</h2>
            <p class="panel-subtitle">
                Selected applications as a percentage of all loaded applications
            </p>

            <div class="success-number">
                <%= String.format(java.util.Locale.US, "%.1f", successRate) %>%
            </div>

            <div class="success-description">
                <strong><%= chartSelected %></strong> selected out of
                <strong><%= chartTotal %></strong> loaded applications.
                This is a simple tracking metric, not a prediction of future results.
            </div>

            <div class="success-track">
                <div class="success-fill"
                     style="width: <%= successRate %>%;"></div>
            </div>
        </div>

    </section>

    <!-- Applications table -->
    <section class="table-panel">

        <div class="table-header">
            <h2>Your Applications</h2>
        </div>

        <div class="filters">
            <input
                type="text"
                id="searchInput"
                placeholder="Search company or job title..."
                aria-label="Search company or job title">

            <select id="statusFilter" aria-label="Filter by status">
                <option value="All">All Statuses</option>
                <option value="Applied">Applied</option>
                <option value="Interview">Interview</option>
                <option value="Selected">Selected</option>
                <option value="Rejected">Rejected</option>
            </select>
        </div>

        <div class="table-wrapper">
            <table id="applicationsTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Company</th>
                    <th>Job Title</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Application Date</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>
                <% if (applications != null && !applications.isEmpty()) {
                    for (JobApplication app : applications) {
                        String status = app.getApplicationStatus();
                        String safeStatus = status == null ? "Unknown" : status;
                        String statusClass = "status-other";

                        if ("Applied".equalsIgnoreCase(safeStatus)) {
                            statusClass = "status-applied";
                        } else if ("Interview".equalsIgnoreCase(safeStatus)) {
                            statusClass = "status-interview";
                        } else if ("Selected".equalsIgnoreCase(safeStatus)) {
                            statusClass = "status-selected";
                        } else if ("Rejected".equalsIgnoreCase(safeStatus)) {
                            statusClass = "status-rejected";
                        }

                        String company = app.getCompanyName() == null
                                ? "" : app.getCompanyName();
                        String jobTitle = app.getJobTitle() == null
                                ? "" : app.getJobTitle();
                        String location = app.getJobLocation() == null
                                ? "" : app.getJobLocation();
                        String date = app.getApplicationDate() == null
                                ? "" : app.getApplicationDate().toString();
                %>

                <tr data-status="<%= safeStatus %>">
                    <td><%= app.getApplicationId() %></td>
                    <td class="company-cell"><%= company %></td>
                    <td class="job-cell"><%= jobTitle %></td>
                    <td><%= location %></td>
                    <td>
                        <span class="status <%= statusClass %>">
                            <%= safeStatus %>
                        </span>
                    </td>
                    <td><%= date %></td>
                    <td>
                        <!-- Corrected: route through the servlet to load the selected record -->
                        <a class="action-link edit-link"
                           href="<%= request.getContextPath() %>/applications?edit=<%= app.getApplicationId() %>">
                            Edit
                        </a>

                        <form action="<%= request.getContextPath() %>/applications"
                              method="post"
                              style="display: inline;"
                              onsubmit="return confirm('Are you sure you want to delete this application?');">

                            <input type="hidden"
                                   name="id"
                                   value="<%= app.getApplicationId() %>">

                            <input type="hidden"
                                   name="action"
                                   value="delete">

                            <button type="submit"
                                    class="action-link delete-link"
                                    style="background: none; border: none; padding: 0; cursor: pointer; font: inherit;">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>

                <%  }
                   } else { %>

                <tr>
                    <td colspan="7" class="empty-message">
                        No applications found. Click Add Application to get started.
                    </td>
                </tr>

                <% } %>
                </tbody>
            </table>

            <div id="noResults" class="no-results">
                No applications match your search or selected filter.
            </div>
        </div>

    </section>

</div>

<script>
    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");
    const table = document.getElementById("applicationsTable");
    const noResults = document.getElementById("noResults");
    const cards = document.querySelectorAll(".stat-card");

    function filterApplications() {
        const searchText = searchInput.value.toLowerCase().trim();
        const selectedStatus = statusFilter.value;
        const rows = table.querySelectorAll("tbody tr");
        let visibleRows = 0;

        rows.forEach(function(row) {
            if (!row.hasAttribute("data-status")) {
                return;
            }

            const company = row.querySelector(".company-cell")
                .textContent.toLowerCase();
            const job = row.querySelector(".job-cell")
                .textContent.toLowerCase();
            const status = row.getAttribute("data-status");

            const matchesSearch =
                company.includes(searchText) || job.includes(searchText);

            const matchesStatus =
                selectedStatus === "All" ||
                status.toLowerCase() === selectedStatus.toLowerCase();

            const showRow = matchesSearch && matchesStatus;

            row.style.display = showRow ? "" : "none";

            if (showRow) {
                visibleRows++;
            }
        });

        noResults.style.display = visibleRows === 0 ? "block" : "none";
    }

    searchInput.addEventListener("input", filterApplications);

    statusFilter.addEventListener("change", function() {
        updateActiveCard(statusFilter.value);
        filterApplications();
    });

    function updateActiveCard(status) {
        cards.forEach(function(card) {
            card.classList.toggle(
                "active",
                card.getAttribute("data-card-status").toLowerCase()
                    === status.toLowerCase()
            );
        });
    }

    cards.forEach(function(card) {
        card.addEventListener("click", function() {
            const status = card.getAttribute("data-card-status");
            statusFilter.value = status;
            updateActiveCard(status);
            filterApplications();
        });
    });
</script>

</body>
</html>