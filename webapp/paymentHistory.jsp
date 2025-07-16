<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="loginControl.UserDBUtil" %>
<%@ page import="loginControl.User" %>
<%@ page import="java.util.List" %>
<%
    List<User> uDEtails = (List<User>) session.getAttribute("userDetails");
    String username = (String) session.getAttribute("username");

    if (username != null && (uDEtails == null || uDEtails.isEmpty())) {
        uDEtails = UserDBUtil.getUserDetails(username);
        session.setAttribute("userDetails", uDEtails);
    }

    if (username == null || uDEtails == null || uDEtails.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    request.setAttribute("uDEtails", uDEtails);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href='css/paymentHistory.css' rel='stylesheet'>
    <style>
      
        .status-completed {
            color: green;
            font-weight: bold;
        }
        .status-failed {
            color: red;
            font-weight: bold;
        }
        .status-pending {
            color: orange;
            font-weight: bold;
        }
        .view-details {
            color: #007bff;
            text-decoration: none;
        }
        .view-details:hover {
            text-decoration: underline;
        }
    </style>
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
                <li><a href="LogoutServlet"><i class='bx bxs-log-out'></i>Logout</a></li>
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
            <h2>Payment History</h2>
            <!-- Search Bar -->
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Search by ID, Card, Date, Method, or Status..." onkeyup="filterPayments()">
                <i class='bx bx-search' onclick="filterPayments()"></i>
            </div>

            <div id="noResultsMessage" class="no-payments" style="display: none;">
                No payments match your search.
            </div>

            <c:choose>
                <c:when test="${not empty paymentHistory}">
                    <table class="payment-table">
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Card Number (Last 4)</th>
                                <th>Expiry Date</th>
                                <th>Amount</th>
                                <th>Payment Method</th>
                                <th>Payment Status</th>
                                <th>Payment Date</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody id="paymentTableBody">
                            <c:forEach var="payment" items="${paymentHistory}">
                                <tr data-id="${payment.id != null ? payment.id : ''}"
                                    data-card="${payment.cardNumber != null ? payment.cardNumber.substring(payment.cardNumber.length() - 4) : ''}"
                                    data-date="${payment.paymentTimestamp != null ? payment.paymentTimestamp : ''}"
                                    data-method="${payment.paymentMethod != null ? payment.paymentMethod.toLowerCase() : ''}"
                                    data-status="${payment.paymentStatus != null ? payment.paymentStatus.toLowerCase() : ''}">
                                    <td>${payment.id}</td>
                                    <td>xxxx xxxx ${payment.cardNumber.substring(payment.cardNumber.length() - 4)}</td>
                                    <td>${payment.expiryMonth}/${payment.expiryYear}</td>
                                    <td>Rs. ${payment.amount}</td>
                                    <td>${payment.paymentMethod}</td>
                                    <td>
                                        <span class="status-${payment.paymentStatus.toLowerCase()}">
                                            ${payment.paymentStatus}
                                        </span>
                                    </td>
                                    <td>${payment.paymentTimestamp}</td>
                                    <td>
                                        <c:url value="confirmPayment.jsp" var="viewDetails">
                                            <c:param name="id" value="${payment.id}"/>
                                        </c:url>
                                        <a href="LoadUserServlet?page=paymentDetails&id=${payment.id}" class="view-details">View</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="no-payments">No payment history available.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function filterPayments() {
            const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();
            const rows = document.querySelectorAll("#paymentTableBody tr");
            const noResultsMessage = document.getElementById("noResultsMessage");
            let hasVisibleRows = false;

            rows.forEach(row => {
                const id = (row.getAttribute("data-id") || "").toLowerCase();
                const card = (row.getAttribute("data-card") || "").toLowerCase();
                const date = (row.getAttribute("data-date") || "").toLowerCase();
                const method = (row.getAttribute("data-method") || "").toLowerCase();
                const status = (row.getAttribute("data-status") || "").toLowerCase();

                const matches = id.includes(searchTerm) || 
                               card.includes(searchTerm) || 
                               date.includes(searchTerm) || 
                               method.includes(searchTerm) || 
                               status.includes(searchTerm);

                row.style.display = matches ? "" : "none";
                if (matches) hasVisibleRows = true;
            });

            noResultsMessage.style.display = hasVisibleRows ? "none" : "block";
        }
    </script>
</body>
</html>