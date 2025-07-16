<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Payment</title>
    <link rel="stylesheet" href="css/consultationPayment.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
            <div class="form-section">
                <div class="header">
                    <h2>Edit Payment Details</h2>
                    <div class="timer">20:00</div> <!-- Timer -->
                </div>
               
                <form action="UpdatePaymentServlet" method="post">
                    <div class="form-group">
                        <input type="hidden" name="id" value="${param.id}">

                        <label for="name">Name</label>
                        <div class="input-group">
                            <input type="text" id="name" name="name" placeholder="Enter your Name" maxlength="21" value="${param.name}" required>
                            <i class='bx bx-credit-card'></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="card-number">Card Number</label>
                        <div class="input-group">
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter your card number" maxlength="19" value="${param.cardNumber}" required>
                            <i class='bx bx-credit-card'></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <div class="input-group">
                            <input type="text" id="cvv" name="cvv" placeholder="Enter CVV" maxlength="3" value="${param.cvv}" required>
                            <i class='bx bx-lock'></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="expiry">Expiry Date</label>
                        <div class="expiry-input">
                            <input type="text" id="expiryMonth" name="expiryMonth" placeholder="MM" maxlength="2" value="${param.expiryMonth}" required>
                            <span>/</span>
                            <input type="text" id="expiryYear" name="expiryYear" placeholder="YY" maxlength="2" value="${param.expiryYear}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <input type="password" id="password" name="password" placeholder="Enter your dynamic password" value="${param.password}" required>
                            <i class='bx bx-key'></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment Method</label>
                        <div class="input-group">
                            <select id="paymentMethod" name="paymentMethod" required>
                                <option value="creditCard" ${param.paymentMethod == 'creditCard' ? 'selected' : ''}>Credit Card</option>
                                <option value="paypal" ${param.paymentMethod == 'paypal' ? 'selected' : ''}>PayPal</option>
                                <option value="bankTransfer" ${param.paymentMethod == 'bankTransfer' ? 'selected' : ''}>Bank Transfer</option>
                            </select>
                            <i class='bx bx-wallet'></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="amount">Amount (LKR)</label>
                        <div class="input-group">
                            <input type="text" id="amount" name="amount" placeholder="Enter amount" value="${param.amount}" required>
                            <i class='bx bx-money'></i>
                        </div>
                    </div>
                    <button type="submit" class="pay-btn">Update Payment Details</button>
                </form>      
            </div>
        </div>
    </div>
</body>
</html>