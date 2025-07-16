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
    <link href='css/sucssesdelete.css' rel='stylesheet'>
    
</head>
<body>

   
    <div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event <span>Bloom</span></h2>
            <ul>
                <li><a href="userProfile.jsp"><i class='bx bxs-user'></i>Profile</a></li>
                <li><a href="LoadUserServlet?page=consultationPayment"><i class='bx bxs-book'></i>Payment</a></li>
                <li><a href="LoadUserServlet?page=consultation"><i class='bx bxs-calendar'></i>Book Consultation</a></li>
                <c:forEach var="user" items="${uDEtails}">
                  <c:url value="userEdit.jsp" var="updateUser">
                      <c:param name="username" value="${user.username}"/>
                      <c:param name="address" value="${user.address}"/>
                      <c:param name="email" value="${user.email}"/>
                      <c:param name="dob" value="${user.dob}"/>
                      <c:param name="gender" value="${user.gender}"/>
                      <c:param name="membership" value="${user.membership}"/>
                      <c:param name="password" value="${user.password}"/>
                  </c:url>
               <li><a href="${updateUser}"><i class='bx bxs-pen'></i>Edit Profile</a></li>
               </c:forEach>
                <li><a href="LoadUserServlet?page=paymentHistory"><i class='bx bxs-user-detail'></i>Payment History</a></li>
                <li><a href="LoadUserServlet?page=userNotification"><i class='bx bxs-message'></i>Notifications</a></li>
                <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                <c:forEach var="user" items="${uDEtails}">
                  <c:url value="confirmDelete.jsp" var="deleteUser">
                      <c:param name="username" value="${user.username}"/>
                      <c:param name="address" value="${user.address}"/>
                      <c:param name="email" value="${user.email}"/>
                      <c:param name="dob" value="${user.dob}"/>
                      <c:param name="gender" value="${user.gender}"/>
                      <c:param name="membership" value="${user.membership}"/>
                      <c:param name="password" value="${user.password}"/>
                  </c:url>
                <li class="delete-account"><a href="${deleteUser}"><i class='bx bxs-trash'></i>Delete Account</a></li>
                </c:forEach>
            </ul>
        </div>

        <!-- Main Content -->
    <div class="content">
        <div class="success-box">
            <img src="image/redtick.jpg" alt="Success" class="checkmark" /> <!-- Replace with actual checkmark image or use emoji/icon -->
            <h2>Successfully Deleted</h2>
            <p>Check your a booking history for confirmation.<br>We'll see you soon!</p>
            <button class="ok-btn" onclick="window.location.href='consultationPayment.jsp'">OK</button>
        </div>
    </div>
    
            
    </div> 

</body>
</html>