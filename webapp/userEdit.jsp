<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User Profile</title>
    <link rel="stylesheet" href="css/userEdit.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- Add SweetAlert2 for validation feedback -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                
                <li><a href="LogoutServlet" onclick="return confirm('Are you sure you want to log out?')"><i class='bx bx-log-out'></i>Logout</a></li>
                <li class="delete-account"><a href="${deleteUser}"><i class='bx bxs-trash'></i>Delete Account</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="form-header">
                <h2>Edit Profile</h2>
                <p>Update your account information</p>
            </div>

            <form action="UpdateUserServlet" method="post" onsubmit="return validateForm()">
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
                    <input type="date" id="dob" name="dob" value="<%= request.getParameter("dob") %>" required max="">
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

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" value="<%= request.getParameter("password") %>" required>
                </div>

                <button type="submit">Update Profile</button>
            </form>
        </div>
    </div>

    <script>
    // Set max date for dob to yesterday
    const today = new Date();
    today.setDate(today.getDate() - 1); // Subtract 1 day to exclude today
    const maxDate = today.toISOString().split("T")[0]; // Format as YYYY-MM-DD
    document.getElementById("dob").setAttribute("max", maxDate);

    function validateForm() {
        let dob = document.getElementById("dob").value;

        // Validate date of birth
        if (dob === "") {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please select your date of birth.'
            });
            return false;
        }

        // Ensure dob is strictly in the past
        const selectedDate = new Date(dob);
        const todayDate = new Date();
        todayDate.setHours(0, 0, 0, 0); // Reset time to 00:00 for comparison
        if (selectedDate >= todayDate) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Date of birth must be a date in the past (before today).'
            });
            return false;
        }

        return true;
    }
    </script>
</body>
</html>