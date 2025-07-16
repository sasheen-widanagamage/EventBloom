<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="loginControl.UserDBUtil" %>
<%@ page import="loginControl.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Check if user data is in session
    List<User> uDEtails = (List<User>) session.getAttribute("userDetails");
    String username = (String) session.getAttribute("username");

    // If session data is missing or empty, fetch from database
    if (username != null && (uDEtails == null || uDEtails.isEmpty())) {
        uDEtails = UserDBUtil.getUserDetails(username);
        session.setAttribute("userDetails", uDEtails);
    }

    // If still no data or no username, redirect to login
    if (username == null || uDEtails == null || uDEtails.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Set uDEtails in request scope
    request.setAttribute("uDEtails", uDEtails);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href='css/userProfile.css' rel='stylesheet'>
    <script>
        // Toggle upload form visibility
        function toggleUploadForm() {
            const uploadForm = document.getElementById('uploadForm');
            uploadForm.style.display = uploadForm.style.display === 'none' ? 'block' : 'none';
        }

        // Validate photo upload
        function validatePhotoUpload() {
            const fileInput = document.getElementById('photo');
            const file = fileInput.files[0];
            if (!file) {
                alert('Please select a photo.');
                return false;
            }
            const validTypes = ['image/jpeg', 'image/png'];
            if (!validTypes.includes(file.type)) {
                alert('Invalid file type. Only JPEG and PNG are allowed.');
                return false;
            }
            if (file.size > 5 * 1024 * 1024) { // 5MB
                alert('File size exceeds 5MB.');
                return false;
            }
            return true;
        }
    </script>
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
                <c:if test="${not empty uDEtails}">
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
                </c:if>
                <li><a href="LoadUserServlet?page=paymentHistory"><i class='bx bxs-user-detail'></i>Payment History</a></li>
                <li><a href="LoadUserServlet?page=userNotification"><i class='bx bxs-message'></i>Notifications</a></li>
                <li><a href="LogoutServlet" onclick="return confirm('Are you sure you want to log out?')"><i class='bx bx-log-out'></i>Logout</a></li>
                <c:if test="${not empty uDEtails}">
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
                </c:if>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- User Info -->
            <div class="user-card">
                <div class="profile-image-container">
                    <c:if test="${not empty uDEtails}">
                        <c:forEach var="user" items="${uDEtails}">
                            <c:choose>
                                <c:when test="${user.photo != null && user.photoLength > 0}">
                                    <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(user.photo)}" alt="User Photo" aria-label="User Profile Photo" onerror="this.src='image/default.jpg'; this.alt='Failed to load user photo';">
                                </c:when>
                                <c:otherwise>
                                    <img src="image/default.jpg" alt="Default User Photo" aria-label="Default User Profile Photo">
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty uDEtails}">
                        <img src="image/default.jpg" alt="Default User Photo" aria-label="Default User Profile Photo">
                    </c:if>
                    <i class='bx bxs-edit edit-icon' onclick="toggleUploadForm()" aria-label="Edit Profile Photo"></i>
                </div>
                <div class="user-info">
                    <c:if test="${not empty uDEtails}">
                        <c:forEach var="user" items="${uDEtails}">
                            <h2>${user.username}</h2>
                            <p>${user.address}</p>
                            <p>${user.email}</p>
                            <c:url value="userEdit.jsp" var="updateUser">
                                <c:param name="username" value="${user.username}"/>
                                <c:param name="address" value="${user.address}"/>
                                <c:param name="email" value="${user.email}"/>
                                <c:param name="dob" value="${user.dob}"/>
                                <c:param name="gender" value="${user.gender}"/>
                                <c:param name="membership" value="${user.membership}"/>
                                <c:param name="password" value="${user.password}"/>
                            </c:url>
                            <div class="greeting-buttons">
                                <button><a href="${updateUser}">Edit Profile</a></button>
                                <form id="uploadForm" action="UploadPhotoServlet" method="post" enctype="multipart/form-data" onsubmit="return validatePhotoUpload()" style="display: none;">
                                    <input type="file" id="photo" name="photo" accept="image/jpeg,image/png" aria-label="Upload Profile Photo">
                                    <button type="submit">Upload Photo</button>
                                    <c:if test="${not empty photoSuccess}">
                                        <p class="success">${photoSuccess}</p>
                                        <% session.removeAttribute("photoSuccess"); %>
                                    </c:if>
                                    <c:if test="${not empty photoError}">
                                        <p class="error">${photoError}</p>
                                        <% session.removeAttribute("photoError"); %>
                                    </c:if>
                                </form>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <section class="greeting">
                    <h2>Welcome Back,
                        <c:if test="${not empty uDEtails}">
                            <c:forEach var="user" items="${uDEtails}">
                                ${user.username}
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty uDEtails}">
                            User
                        </c:if>!</h2>
                    <p>Here's an overview of your event activities.</p>
                </section>
            </div>

            <section class="overview">
                <div class="stat">
                    <h3 id="totalBookings">0</h3>
                    <p>Total Bookings</p>
                </div>
                <div class="stat">
                    <h3 id="engagementRate">0%</h3>
                    <p>Engagement Rate</p>
                </div>
                <div class="stat">
                    <h3 id="activePlans">0</h3>
                    <p>Active Plans</p>
                </div>
            </section>

            <div style="display: flex; gap: 30px; width: 100%;">
                <!-- Left Side: User Details -->
                <div class="courses" style="flex: 1; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);">
                    <h2>User Details</h2>
                    <c:if test="${not empty uDEtails}">
                        <c:forEach var="user" items="${uDEtails}">
                            <p><strong>Name:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                            <p><strong>Address:</strong> ${user.address}</p>
                            <p><strong>DOB:</strong> ${user.dob}</p>
                            <p><strong>Gender:</strong> ${user.gender}</p>
                            <p><strong>Membership:</strong> ${user.membership}</p>
                            <p><strong>Password:</strong> ${user.password}</p>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty uDEtails}">
                        <p>No user details available.</p>
                    </c:if>
                </div>

                <!-- Right Side: Chart -->
                <div class="course" style="flex: 2; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);">
                    <h2>User Activity Analytics</h2>
                    <canvas id="bookingTrendsChart" aria-label="Monthly Event Bookings Chart" style="height: 230px;"></canvas>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            $.ajax({
                                url: 'UserChartDataServlet',
                                method: 'GET',
                                dataType: 'json',
                                success: function(data) {
                                    if (data.error) {
                                        console.error('Error fetching chart data:', data.error);
                                        return;
                                    }

                                    // Update statistics
                                    document.getElementById('totalBookings').textContent = data.totalBookings;
                                    document.getElementById('engagementRate').textContent = data.engagementRate.toFixed(1) + '%';
                                    document.getElementById('activePlans').textContent = data.activePlans;

                                    // Render chart
                                    const bookingTrendsCtx = document.getElementById("bookingTrendsChart").getContext("2d");
                                    new Chart(bookingTrendsCtx, {
                                        type: "bar",
                                        data: {
                                            labels: data.labels,
                                            datasets: [{
                                                label: "Events Booked",
                                                data: data.bookingCounts,
                                                backgroundColor: [
                                                    "#003f7f", "#0059b3", "#0073e6", "#3399ff",
                                                    "#66b3ff", "#99ccff", "#4d94ff", "#1a75ff",
                                                    "#005ce6", "#0047b3", "#003080", "#001a4d"
                                                ],
                                                borderColor: "#005bb5",
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                            plugins: {
                                                title: {
                                                    display: true,
                                                    text: "Monthly Event Bookings",
                                                    color: "#003f7f",
                                                    font: { size: 18 }
                                                },
                                                legend: {
                                                    labels: { color: "#003f7f" }
                                                },
                                                tooltip: {
                                                    enabled: true
                                                }
                                            },
                                            scales: {
                                                x: {
                                                    ticks: { color: "#003f7f" },
                                                    grid: { color: "#d9e6f2" }
                                                },
                                                y: {
                                                    ticks: { color: "#003f7f" },
                                                    grid: { color: "#d9e6f2" },
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });
                                },
                                error: function(xhr, status, error) {
                                    console.error('AJAX error:', status, error);
                                }
                            });
                        });
                    </script>
                </div>

                <div class="courses" style="flex: 1; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);">
                    <h2>Get Consultation</h2>
                    <p>Get consultation from user.</p>
                    <p><strong>If you have any doubt or need guidelines to plan your event, Click here to book session with Event Moderator</strong></p>
                    <a href="LoadUserServlet?page=consultation" class="consult-button">Get Consultation</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>