<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClaimsReview.aspx.cs" Inherits="WebApplication11.ClaimsReview" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claims Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tbody tr:hover {
            background-color: #e9ecef;
        }
        .status-approved {
            color: #28a745;
            font-weight: bold;
        }
        .status-rejected {
            color: #dc3545;
            font-weight: bold;
        }
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        .nav-links {
            margin: 20px 0;
            text-align: center;
        }
        .nav-button {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }
        button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
        }
        .btn-delete {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>

    <div class="nav-links">
        <a href="Homepage.aspx" class="nav-button">Home</a>
        <a href="LecturerClaim.aspx" class="nav-button">Submit a Claim</a>
    </div>

    <div class="container">
        <h2>Submitted Claims and Review</h2>
        <table id="claimsTable">
            <thead>
                <tr>
                    <th>Claim ID</th>
                    <th>Lecturer Name</th>
                    <th>Lecturer ID</th>
                    <th>Programme Code</th>
                    <th>Module Code</th>
                    <th>Hours Worked</th>
                    <th>Hourly Rate</th>
                    <th>Final Payment</th>
                    <th>Claim Date</th>
                    <th>Additional Notes</th>
                    <th>Supporting Document</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="claimDetails"></tbody>
        </table>
    </div>

    <div class="footer">
        &copy; 2024 Claims Management System. All rights reserved.
    </div>

    <script>
        function loadClaims() {
            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            const claimDetails = document.getElementById('claimDetails');
            claimDetails.innerHTML = ''; // Clear previous entries

            claimsData.forEach((claim, index) => {
                const row = claimDetails.insertRow();
                row.innerHTML = `
                    <td>${claim.claimId}</td>
                    <td>${claim.lecturerName}</td>
                    <td>${claim.lecturerId}</td>
                    <td>${claim.programmeCode}</td>
                    <td>${claim.moduleCode}</td>
                    <td>${claim.hoursWorked}</td>
                    <td>R${claim.hourlyRate}</td>
                    <td>R${claim.finalPayment}</td>
                    <td>${claim.claimDate}</td>
                    <td>${claim.additionalNotes || "N/A"}</td>
                    <td><a href="${claim.supportingDocument}" target="_blank">View Document</a></td>
                    <td class="${claim.status === "Approved"
                        ? "status-approved"
                        : claim.status?.startsWith("Rejected")
                            ? "status-rejected"
                            : "status-pending"
                    }">${claim.status || "Pending"}</td>
                    <td><button onclick="deleteClaim(${index})">Delete</button></td>
                    
                `;
            });
        }

        function updateClaimStatus(index, status) {
            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            claimsData[index].status = status;
            localStorage.setItem('claimsData', JSON.stringify(claimsData));
            alert(`Claim ${status.toLowerCase()} successfully!`);
            loadClaims();
        }

    

        function deleteClaim(index) {
            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            claimsData.splice(index, 1);
            localStorage.setItem('claimsData', JSON.stringify(claimsData));
            alert("Claim deleted successfully!");
            loadClaims();
        }

        window.onload = loadClaims;
    </script>
</body>
</html>
