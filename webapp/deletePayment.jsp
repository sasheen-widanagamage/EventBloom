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
    <link href='css/confirmDelete.css' rel='stylesheet'>
    
</head>
<body>
    <%
      String  name = request.getParameter(" name");
      String cardNumber = request.getParameter("cardNumber");
      String cvv = request.getParameter("cvv");
      String expiryMonth = request.getParameter("expiryMonth");
      String expiryYear = request.getParameter("expiryYear");
      String password = request.getParameter("password");
      String id = request.getParameter("id");
    %>
   
   
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

        
        <div class="delete-container">
            <div class="delete-card">
                <div class="delete-icon">
                    <img src="image/bin.jpg" alt="Delete Icon" />
                </div>
                <h3>You are about to delete your Payment</h3>
                <p>This will delete your Payment from our platform<br>Are you sure?</p>
                
                
                <form action="DeletePaymentServlet" method="post">
                <div class="form-group">
                
                  <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
                  
                    <label for="name">Username</label>
                    <input type="text" id="name" name="name" value="<%= request.getParameter("name") %>" required>
                </div>

                <div class="form-group">
                    <label for="cardNumber">Card Number</label>
                    <textarea id="cardNumber" name="cardNumber" required><%= request.getParameter("cardNumber") %></textarea>
                </div>

                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" value="<%= request.getParameter("cvv") %>" required>
                </div>

                <div class="form-group">
                    <label for="expiryMonth">Expiry Month</label>
                    <input type="text" id="expiryMonth" name="expiryMonth" value="<%= request.getParameter("expiryMonth") %>" required>
                </div>

                <div class="form-group">
                    <label for="expiryYear">Expiry Year</label>
                    <input type="text" id="expiryYear" name="expiryYear" value="<%= request.getParameter("expiryYear") %>" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" id="password" name="password" value="<%= request.getParameter("password") %>" required>
                </div>

                 <div class="delete-buttons">
                    <button class="cancel-btn">Cancel</button>
                    <button class="delete-btn">Delete</button>
                </div>
            </div>
            </form>
               
            
        </div>
            
    </div> 

</body>
</html>
