<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Payment</title>
    <link rel="stylesheet" href="css/confirmPayment.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
        <div class="main-content">
            <h1>Payment Details</h1>
            <div class="payment-info">
                <c:if test="${not empty paymentDetails}">
                    <c:forEach var="payment" items="${paymentDetails}">
                        <p><strong>Payment Id:</strong> ${payment.id}</p>
                        <p><strong>Name:</strong> ${payment.name}</p>
                        <p><strong>Amount:</strong> Rs. ${payment.amount}</p>
                        <p><strong>Card Number:</strong> ${payment.cardNumber}</p>
                        <p><strong>CVV:</strong> ${payment.cvv}</p>
                        <p><strong>Expire Month:</strong> ${payment.expiryMonth}</p>
                        <p><strong>Expire Year:</strong> ${payment.expiryYear}</p>
                        <p><strong>Password:</strong> ${payment.password}</p>
                        <p><strong>Payment Method:</strong> ${payment.paymentMethod}</p>
                        <p><strong>Payment Status:</strong> ${payment.paymentStatus}</p>
                        <p><strong>Payment Timestamp:</strong> ${payment.paymentTimestamp}</p>
                    </c:forEach>
                </c:if>
                <c:if test="${empty paymentDetails}">
                    <p>No payment details available.</p>
                </c:if>
            </div>
            <div class="button-group">
                <a href="paymentHistory.jsp" class="btn green">Go to Payment History</a>
                <c:if test="${not empty paymentDetails}">
                    <c:forEach var="payment" items="${paymentDetails}">
                        <c:url value="editPayment.jsp" var="updatePayment">
                            <c:param name="id" value="${payment.id}"/>
                            <c:param name="name" value="${payment.name}"/>
                            <c:param name="cardNumber" value="${payment.cardNumber}"/>
                            <c:param name="cvv" value="${payment.cvv}"/>
                            <c:param name="expiryMonth" value="${payment.expiryMonth}"/>
                            <c:param name="expiryYear" value="${payment.expiryYear}"/>
                            <c:param name="password" value="${payment.password}"/>
                            <c:param name="paymentMethod" value="${payment.paymentMethod}"/>
                            <c:param name="amount" value="${payment.amount}"/>
                        </c:url>
                        <a href="${updatePayment}" class="btn blue">Edit</a>
                    </c:forEach>
                    <c:forEach var="payment" items="${paymentDetails}">
                        <c:url value="deletePayment.jsp" var="deletePayment">
                            <c:param name="id" value="${payment.id}"/>
                            <c:param name="name" value="${payment.name}"/>
                            <c:param name="cardNumber" value="${payment.cardNumber}"/>
                            <c:param name="cvv" value="${payment.cvv}"/>
                            <c:param name="expiryMonth" value="${payment.expiryMonth}"/>
                            <c:param name="expiryYear" value="${payment.expiryYear}"/>
                            <c:param name="password" value="${payment.password}"/>
                            <c:param name="paymentMethod" value="${payment.paymentMethod}"/>
                            <c:param name="amount" value="${payment.amount}"/>
                        </c:url>
                        <a href="${deletePayment}" class="btn red">Delete</a>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>