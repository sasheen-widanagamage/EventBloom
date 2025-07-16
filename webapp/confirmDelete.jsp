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
      String username = request.getParameter("username");
      String password = request.getParameter("password");
      String email = request.getParameter("email");
      String address = request.getParameter("address");
      String dob = request.getParameter("dob");
      String gender = request.getParameter("gender");
      String membership = request.getParameter("membership");
    %>
   
    <div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event <span>Bloom</span></h2>
            <ul>
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
                <h3>You are about to delete your Account</h3>
                <p>This will delete your Account from our platform<br>Are you sure?</p>
                
                
                <form action="DeleteUserServlet" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="<%= request.getParameter("username") %>" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" required><%= request.getParameter("address") %></textarea>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= request.getParameter("email") %>" required>
                </div>

                <div class="form-group">
                    <label for="dob">Date of Birth</label>
                    <input type="date" id="dob" name="dob" value="<%= request.getParameter("dob") %>" required>
                </div>

                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <option value="male" <%= "male".equals(request.getParameter("gender")) ? "selected" : "" %>>Male</option>
                        <option value="female" <%= "female".equals(request.getParameter("gender")) ? "selected" : "" %>>Female</option>
                        <option value="other" <%= "other".equals(request.getParameter("gender")) ? "selected" : "" %>>Other</option>
                    </select>
                </div>

                <div class="form-group membership-group">
                 <label>Membership</label>
                 <div class="membership-options">
                      <input type="radio" id="basic" name="membership" value="basic" <%= "basic".equals(request.getParameter("membership")) ? "checked" : "" %>>
                      <label for="basic">Basic</label>
 
                <input type="radio" id="premium" name="membership" value="premium" <%= "premium".equals(request.getParameter("membership")) ? "checked" : "" %>>
                <label for="premium">Premium</label>
               </div>
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



  
 
  
  



















