<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR.aspx.cs" Inherits="WebApplication11.HR" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HR Claims Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
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
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .button {
            padding: 8px 16px;
            margin: 2px;
            color: #fff;
            background-color: #5cb85c;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
        }
        .button.reject {
            background-color: #d9534f;
        }
        .status-approved {
            color: #28a745;
            font-weight: bold;
        }
        .status-rejected {
            color: #dc3545;
            font-weight: bold;
        }
        .nav-links {
            text-align: center;
            margin-bottom: 20px;
        }
        .nav-button {
            margin: 0 10px;
            text-decoration: none;
            color: #333;
            background-color: #e7e7e7;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .nav-button:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="nav-links">
        <a href="Homepage.aspx" class="nav-button">Home</a>
        <a href="ClaimsReview.aspx" class="nav-button">Review Claims</a>
    </div>

    <div class="container">
        <h1>HR Claims Management</h1>

        <!-- Claims Table -->
        <h2>Claims Review</h2>
        <table id="claimsTable">
            <thead>
                <tr>
                    <th>Lecturer Name</th>
                    <th>Lecturer ID</th>
                    <th>Hours Worked</th>
                    <th>Hourly Rate</th>
                    <th>Total Payment</th>
                    <th>Notes</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Dynamically populated claims -->
            </tbody>
        </table>

        <!-- Reports and Data Management -->
        <h2>Generate Reports</h2>
        <button class="button" onclick="generateReport()">Generate Invoice</button>

        <h2>Lecturer Data Management</h2>
        <form id="lecturerForm">
            <label for="lecturerName">Lecturer Name:</label>
            <input type="text" id="lecturerName" name="lecturerName" required>

            <label for="contactDetails">Contact Details:</label>
            <input type="text" id="contactDetails" name="contactDetails" required>

            <button type="submit" class="button">Update Details</button>
        </form>
    </div>

    <script>
        // Load Claims into Table
        function loadClaims() {
            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            const claimsTable = document.getElementById('claimsTable').getElementsByTagName('tbody')[0];
            claimsTable.innerHTML = ""; // Clear existing rows

            claimsData.forEach((claim, index) => {
                const row = claimsTable.insertRow();
                row.innerHTML = `
                    <td>${claim.lecturerName}</td>
                    <td>${claim.lecturerId}</td>
                    <td>${claim.hoursWorked}</td>
                    <td>R${claim.hourlyRate}</td>
                    <td>R${claim.finalPayment}</td>
                    <td>${claim.additionalNotes}</td>
                    <td class="${claim.status === 'Approved' ? 'status-approved' : 'status-rejected'}">
                        ${claim.status || 'Pending'}
                    </td>
                    <td>
                        <button class="button approve" data-index="${index}">Approve</button>
                        <button class="button reject" data-index="${index}">Reject</button>
                    </td>
                `;
            });

            attachEventHandlers();
        }

        // Attach Approve and Reject Handlers
        function attachEventHandlers() {
            document.querySelectorAll('.button.approve').forEach((button) => {
                button.addEventListener('click', (e) => {
                    const index = e.target.dataset.index;
                    updateClaimStatus(index, 'Approved');
                });
            });

            document.querySelectorAll('.button.reject').forEach((button) => {
                button.addEventListener('click', (e) => {
                    const index = e.target.dataset.index;
                    updateClaimStatus(index, 'Rejected');
                });
            });
        }

        // Update Claim Status
        function updateClaimStatus(index, status) {
            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            if (claimsData[index]) {
                claimsData[index].status = status;
                localStorage.setItem('claimsData', JSON.stringify(claimsData));
                loadClaims();
                alert(`Claim ${status}`);
            }
        }

        // Lecturer Form Submission
        document.getElementById('lecturerForm').onsubmit = function (e) {
            e.preventDefault();
            const lecturerName = document.getElementById('lecturerName').value;
            const contactDetails = document.getElementById('contactDetails').value;
            localStorage.setItem('lecturerDetails', JSON.stringify({ lecturerName, contactDetails }));
            alert('Lecturer details updated!');

        };

        // Save Edits Automatically
        function attachEditableHandlers() {
            document.querySelectorAll(".editable").forEach(cell => {
                cell.addEventListener("blur", (e) => {
                    const index = e.target.dataset.index;
                    const key = e.target.dataset.key;
                    const newValue = e.target.textContent;

                    const claimsData = JSON.parse(localStorage.getItem("claimsData"));
                    claimsData[index][key] = isNaN(newValue) ? newValue : parseFloat(newValue); // Handle numbers
                    localStorage.setItem("claimsData", JSON.stringify(claimsData));
                });
            });
        }

        // Generate Report
        function generateReport() {
            alert('Invoice generated successfully!');
            // Logic to generate and download invoice goes here

            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            let csvContent = "data:text/csv;charset=utf-8,";

            // Add headers
            csvContent += "Lecturer Name,Lecturer ID,Hours Worked,Hourly Rate,Total Payment,Notes,Status\n";

            // Add rows
            claimsData.forEach(claim => {
                csvContent += `${claim.lecturerName},${claim.lecturerId},${claim.hoursWorked},${claim.hourlyRate},${claim.finalPayment},"${claim.additionalNotes}",${claim.status}\n`;
            });

            // Create download link
            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "claims_report.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }


        // Load claims on page load
        window.onload = loadClaims;
    </script>
</body>
</html>
