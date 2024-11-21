<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgrammeCoordinator.aspx.cs" Inherits="WebApplication11.ProgrammeCoordinator" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claims Review and Approval</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn-approve, .btn-reject {
            padding: 8px 12px;
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
        .btn-approve:hover {
            background-color: #218838;
        }
        .btn-reject:hover {
            background-color: #c82333;
        }
        .nav-links {
            margin-bottom: 20px;
        }
        .nav-button {
            text-decoration: none;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            margin-right: 10px;
        }
        .nav-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="nav-links">
        <a href="Homepage.aspx" class="nav-button">Home</a>
       
    </div>

    <h2>Claims Review and Approval</h2>
    <table>
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
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="claimDetails">
            <!-- Claims will be dynamically populated here -->
        </tbody>
    </table>

    <script>
        const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];

        function displayClaims() {
            const claimDetails = document.getElementById('claimDetails');
            claimDetails.innerHTML = ''; // Clear previous entries

            if (claimsData.length === 0) {
                claimDetails.innerHTML = '<tr><td colspan="13">No claims found.</td></tr>';
                return;
            }

            claimsData.forEach((claim, index) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${claim.claimId || '-'}</td>
                    <td>${claim.lecturerName}</td>
                    <td>${claim.lecturerId}</td>
                    <td>${claim.programmeCode || '-'}</td>
                    <td>${claim.moduleCode || '-'}</td>
                    <td>${claim.hoursWorked}</td>
                    <td>R${claim.hourlyRate}</td>
                    <td>R${(claim.hoursWorked * claim.hourlyRate).toFixed(2)}</td>
                    <td>${claim.claimDate || '-'}</td>
                    <td>${claim.additionalNotes || 'None'}</td>
                    <td>
                        ${claim.supportingDocument
                        ? `<a href="${claim.supportingDocument}" target="_blank">View</a>`
                        : 'No Document'}
                    </td>
                    <td class="claim-status">${claim.status || 'Pending'}</td>
                    <td>
                        <button class="btn-approve" onclick="updateClaimStatus(${index}, 'Approved')">Approve</button>
                        <button class="btn-reject" onclick="rejectClaim(${index})">Reject</button>
                    </td>
                `;
                claimDetails.appendChild(row);
            });
        }

        function updateClaimStatus(index, status) {
            claimsData[index].status = status;
            localStorage.setItem('claimsData', JSON.stringify(claimsData));
            alert(`Claim ${status.toLowerCase()}!`);
            displayClaims();
        }

        function rejectClaim(index) {
            const reason = prompt("Enter the reason for rejection:");
            if (reason) {
                updateClaimStatus(index, `Rejected: ${reason}`);
            }
        }

        window.onload = displayClaims;
    </script>
</body>
</html>
