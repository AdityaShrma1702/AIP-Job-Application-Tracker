<%-- 
    Document   : add-application
    Created on : Oct 23, 2026, 12:38:52 AM
    Author     : hp
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Job Application</title>
    <style>
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
        h2 { color: #1f2937; }
        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 6px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            box-sizing: border-box;
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
        button:hover { background: #1d4ed8; }
        .back { display: inline-block; margin-top: 18px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Job Application</h2>

        <form action="applications" method="post">
            <label for="companyName">Company Name *</label>
            <input type="text" id="companyName"
                   name="companyName" required>

            <label for="jobTitle">Job Title *</label>
            <input type="text" id="jobTitle"
                   name="jobTitle" required>

            <label for="jobLocation">Location</label>
            <input type="text" id="jobLocation"
                   name="jobLocation">

            <label for="status">Application Status</label>
            <select id="status" name="status">
                <option value="Applied">Applied</option>
                <option value="Interview">Interview</option>
                <option value="Selected">Selected</option>
                <option value="Rejected">Rejected</option>
            </select>

            <label for="applicationDate">Application Date</label>
            <input type="date" id="applicationDate"
                   name="applicationDate">

            <button type="submit">Save Application</button>
        </form>

        <a class="back" href="applications">← Back to Applications</a>
    </div>
</body>
</html>
