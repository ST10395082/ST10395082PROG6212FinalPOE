<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="WebApplication11.Homepage" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claims Application Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .nav-links {
            margin-top: 20px;
        }
        .nav-button {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            margin: 10px;
        }
        .nav-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h1>Welcome to the Claims Management Application</h1>
<p>Please choose an option below:</p>

<div class="nav-links">
    <a href="LecturerClaim.aspx" class="nav-button">Submit a Claim</a>
    <a href="ClaimsReview.aspx" class="nav-button">Review Claims</a>
    <a href="AcademicManager.aspx" class="nav-button">Academic Manager</a>
    <a href="ProgrammeCoordinator.aspx" class="nav-button">Programme Coordinator</a>
    <a href="HR.aspx" class="nav-button"> HR</a>
</div>

</body>
</html>
