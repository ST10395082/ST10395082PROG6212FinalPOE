<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerClaim.aspx.cs" Inherits="WebApplication11.LecturerClaim" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Claim Submission</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .nav-links {
            margin-bottom: 20px;
        }
        .nav-button {
            text-decoration: none;
            color: #007bff;
            padding: 10px;
            border: 1px solid #007bff;
            border-radius: 5px;
            margin-right: 10px;
            background-color: white;
        }
        .nav-button:hover {
            background-color: #007bff;
            color: white;
        }
        .claim-submission-form {
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-submit {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
        .final-payment {
            font-weight: bold;
            color: #28a745;
        }
        #fileName {
            display: block;
            margin-top: 5px;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="nav-links">
        <a href="Homepage.aspx" class="nav-button">Home</a>
        <a href="ClaimsReview.aspx" class="nav-button">Review Claims</a>
    </div>

    <div class="claim-submission-form">
        <h2>Submit Your Claim</h2>
        <form id="claimForm" enctype="multipart/form-data" onsubmit="submitClaim(event)">
            <div class="form-group">
                <label for="claimId">Claim ID:</label>
                <input type="text" id="claimId" required>
            </div>
            <div class="form-group">
                <label for="lecturerName">Lecturer Name:</label>
                <input type="text" id="lecturerName" required>
            </div>
            <div class="form-group">
                <label for="lecturerId">Lecturer ID:</label>
                <input type="text" id="lecturerId" required>
            </div>
            <div class="form-group">
                <label for="programmeCode">Programme Code:</label>
                <input type="text" id="programmeCode" required>
            </div>
            <div class="form-group">
                <label for="moduleCode">Module Code:</label>
                <input type="text" id="moduleCode" required>
            </div>
            <div class="form-group">
                <label for="hoursWorked">Hours Worked:</label>
                <input type="number" id="hoursWorked" min="1" required oninput="calculatePayment()">
            </div>
            <div class="form-group">
                <label for="hourlyRate">Hourly Rate:</label>
                <input type="number" id="hourlyRate" min="1" required oninput="calculatePayment()">
            </div>
            <div class="form-group">
                <label for="finalPayment">Final Payment:</label>
                <input type="text" id="finalPayment" readonly class="final-payment">
            </div>
            <div class="form-group">
                <label for="claimDate">Claim Date:</label>
                <div style="display: flex; gap: 10px;">
                    <input type="number" id="claimYear" placeholder="YYYY" min="2020" max="2026" required style="width: 60px;">
                    <input type="number" id="claimMonth" placeholder="MM" min="1" max="12" required style="width: 60px;">
                    <input type="number" id="claimDay" placeholder="DD" min="1" max="31" required style="width: 80px;">
                </div>
            </div>
            <div class="form-group">
                <label for="additionalNotes">Additional Notes:</label>
                <textarea id="additionalNotes"></textarea>
            </div>
            <div class="form-group">
                <label for="supportingDocument">Upload Supporting Document:</label>
                <input type="file" id="supportingDocument" accept=".pdf,.docx,.xlsx">
                <span id="fileName"></span>
            </div>
            <button type="submit" class="btn-submit">Submit</button>
        </form>
    </div>

    <script>
        document.getElementById('supportingDocument').onchange = function () {
            document.getElementById('fileName').textContent = this.files[0] ? this.files[0].name : '';
        };

        function calculatePayment() {
            const hoursWorked = parseFloat(document.getElementById('hoursWorked').value) || 0;
            const hourlyRate = parseFloat(document.getElementById('hourlyRate').value) || 0;
            const finalPayment = hoursWorked * hourlyRate;
            document.getElementById('finalPayment').value = finalPayment ? `R${finalPayment.toFixed(2)}` : '';
        }

        function submitClaim(event) {
            event.preventDefault();

            const claimData = {
                claimId: document.getElementById('claimId').value,
                lecturerName: document.getElementById('lecturerName').value,
                lecturerId: document.getElementById('lecturerId').value,
                programmeCode: document.getElementById('programmeCode').value,
                moduleCode: document.getElementById('moduleCode').value,
                hoursWorked: document.getElementById('hoursWorked').value,
                hourlyRate: document.getElementById('hourlyRate').value,
                finalPayment: document.getElementById('finalPayment').value,
                claimDate: `${document.getElementById('claimYear').value}-${document.getElementById('claimMonth').value}-${document.getElementById('claimDay').value}`,
                additionalNotes: document.getElementById('additionalNotes').value,
                supportingDocument: document.getElementById('fileName').textContent
            };

            const claimsData = JSON.parse(localStorage.getItem('claimsData')) || [];
            claimsData.push(claimData);
            localStorage.setItem('claimsData', JSON.stringify(claimsData));

            alert('Claim submitted successfully!');
            window.location.href = 'ClaimsReview.aspx';
        }
    </script>
</body>
</html>
