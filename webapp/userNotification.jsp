<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="loginControl.UserDBUtil" %>
<%@ page import="loginControl.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="loginControl.ConsultationPayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Notifications - Event Bloom</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href='css/userNotification.css' rel='stylesheet'>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

  <div class="dashboard">
    <!-- Sidebar -->
    <div class="sidebar">
      <h2 class="logo">Event <span>Bloom</span></h2>
      <ul>
                <li><a href="userProfile.jsp"><i class='bx bxs-user'></i>Profile</a></li>
                <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                <li><a href="LoadUserServlet?page=consultationPayment"><i class='bx bxs-book'></i>Payment</a></li>
                <li><a href="LoadUserServlet?page=consultation"><i class='bx bxs-calendar'></i>Book Consultation</a></li>
               <li><a href="${updateUser}"><i class='bx bxs-pen'></i>Edit Profile</a></li>
                <li><a href="LoadUserServlet?page=paymentHistory"><i class='bx bxs-user-detail'></i>Payment History</a></li>
                <li><a href="LoadUserServlet?page=userNotification"><i class='bx bxs-message'></i>Notifications</a></li>
                <li><a href="LogoutServlet" onclick="return confirm('Are you sure you want to log out?')"><i class='bx bx-log-out'></i>Logout</a></li>
                <li class="delete-account"><a href="${deleteUser}"><i class='bx bxs-trash'></i>Delete Account</a></li>
               
            </ul>
    </div>

    <!-- Main Notification Panel -->
    <div class="notifications-container">
      <h2 class="notification-header">User Notifications</h2>

      <div id="notificationList">
        <%
          // Fetch user details (assuming username is in session or request)
          String username = (String) session.getAttribute("username");
          if (username == null && request.getParameter("username") != null) {
              username = request.getParameter("username");
          }
          if (username == null) {
              username = "defaultUser"; // Fallback if no username available
          }
          List<User> users = UserDBUtil.getUserDetails(username);
          List<ConsultationPayment> payments = UserDBUtil.getPaymentHistory(username);
          LocalDateTime now = LocalDateTime.now();
          User user = users != null && !users.isEmpty() ? users.get(0) : null;

          // Debug output
          out.println("<!-- Debug: Username: " + username + ", User: " + (user != null ? user.getUsername() : "null") + ", Payments: " + (payments != null ? payments.size() : 0) + ", User DOB: " + (user != null && user.getDob() != null ? user.getDob() : "null") + " -->");

          // Registration notification (using current date as fallback since dob is invalid for this)
          if (user != null) {
              LocalDateTime regDateTime = LocalDateTime.now().minusDays(2); // Simulate registration 2 days ago
              long daysDiff = ChronoUnit.DAYS.between(regDateTime, now);
              String timeAgo = (daysDiff == 0) ? "Just now" : (daysDiff == 1) ? "Yesterday"
                      : (daysDiff <= 7) ? daysDiff + " days ago" : daysDiff + " days ago";
        %>
        <div class="notification">
          <div class="tag green">Registration</div>
          <h4>Account Registered Successfully</h4>
          <p class="description">Welcome to EventBloom, <%= user.getUsername() %>!</p>
          <span class="time"><%= timeAgo %></span>
          <button class="close-btn" title="Mark as Read">×</button>
        </div>
        <hr>
        <%
          } else {
        %>
        <div class="notification">
          <div class="tag red">Error</div>
          <h4>Unable to Load User Data</h4>
          <p class="description">Please try again later or contact support.</p>
          <span class="time">Just now</span>
          <button class="close-btn" title="Mark as Read">×</button>
        </div>
        <hr>
        <%
          }

          // Profile update notification (using current date as fallback since dob is invalid for this)
          if (user != null) {
              LocalDateTime updateDateTime = LocalDateTime.now().minusDays(1); // Simulate update 1 day ago
              long daysDiff = ChronoUnit.DAYS.between(updateDateTime, now);
              String timeAgo = (daysDiff == 0) ? "Just now" : (daysDiff == 1) ? "Yesterday"
                      : (daysDiff <= 7) ? daysDiff + " days ago" : daysDiff + " days ago";
        %>
        <div class="notification">
          <div class="tag blue">Profile Update</div>
          <h4>Profile Updated Successfully</h4>
          <p class="description">Your profile information was successfully updated.</p>
          <span class="time"><%= timeAgo %></span>
          <button class="close-btn" title="Mark as Read">×</button>
        </div>
        <hr>
        <%
          }

          // Payment notifications
          if (payments != null) {
              for (ConsultationPayment payment : payments) {
                  java.sql.Timestamp paymentTime = payment.getPaymentTimestamp();
                  if (paymentTime != null) {
                      LocalDateTime paymentDateTime = paymentTime.toLocalDateTime();
                      long daysDiff = ChronoUnit.DAYS.between(paymentDateTime, now);
                      String timeAgo = (daysDiff == 0) ? "Just now"
                              : (daysDiff == 1) ? "Yesterday at " + paymentDateTime.toLocalTime()
                              : daysDiff + " days ago";
                      String amount = "LKR 2,500"; // Hardcoded for now; should fetch from payment data
        %>
        <div class="notification">
          <div class="tag orange">Payment</div>
          <h4>Payment Successful</h4>
          <p class="description">Your payment of <%= amount %> for the Consultation was successful.</p>
          <span class="time"><%= timeAgo %></span>
          <button class="close-btn" title="Mark as Read">×</button>
        </div>
        <hr>
        <%
                  }
              }
          }
        %>
      </div>
    </div>
  </div>

</body>
</html>