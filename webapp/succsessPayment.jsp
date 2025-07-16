<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href='css/sucssesPayment.css' rel='stylesheet'>
    
</head>
<body>

   
    <div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event <span>Bloom</span></h2>
            <ul>
                <li><a href="userProfile.jsp"><i class='bx bxs-user'></i>Profile</a></li>
                <li><a href="consultationPayment.jsp"><i class='bx bxs-book'></i>Payment</a></li>
                <li><a href="consultation.jsp"><i class='bx bxs-calendar'></i>Book Consultation</a></li>
                <li><a href="#"><i class='bx bxs-pen'></i>Edit Profile</a></li>
                <li><a href="paymentHistory.html"><i class='bx bxs-user-detail'></i>Payment History</a></li>
                <li><a href="userNotification.html"><i class='bx bxs-message'></i>Notifications</a></li>
                <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                <li class="delete-account"><a href="#"><i class='bx bxs-trash'></i>Delete Account</a></li>
              
               
            </ul>
        </div>

        <!-- Main Content -->
    <div class="content">
        <div class="success-box">
            <img src="image/confirm1.jpg" alt="Success" class="checkmark" /> <!-- Replace with actual checkmark image or use emoji/icon -->
            <h2>Success</h2>
            <p>Check your email for a booking confirmation.<br>We'll see you soon!</p>
            <button class="ok-btn" onclick="window.location.href='consultationPayment.jsp'">OK</button>
        </div>
    </div>
    
            
    </div> 

</body>
</html>



  
 
  
  



















