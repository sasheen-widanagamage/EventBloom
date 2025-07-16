<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="loginControl.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - EventBloom</title>
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href='css/userInfoDisplay.css' rel='stylesheet'>
</head>
<body>
	<div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event <span>Bloom</span></h2>
            <h3 class="logo">Admin Panel</h3>
            <ul>
            <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                <li><a href="adminPannel.jsp"><i class='bx bxs-user'></i>Profile</a></li>
                <li><a href="addModerator.jsp"><i class='bx bxs-user-plus'></i>Add Event Moderator</a></li>
                <li><a href="addPlanner.jsp"><i class='bx bxs-user-plus'></i>Add Event Planner</a></li>
                <li><a href="DisplayUserDetailsServlet"><i class='bx bxs-user-detail'></i>User Details</a></li>
                <li><a href="DisplayStaffDetailsServlet"><i class='bx bxs-user-detail'></i>Staff Details</a></li>
                <li><a href="adminNotification.jsp"><i class='bx bxs-message'></i>Notifications</a></li>
                <li><a href="GetAllPlannerServlet"><i class='bx bxs-user-account'></i> Planners</a></li>
                <li><a href="GetAllModeratorServlet"><i class='bx bxs-user-account'></i> Moderators</a></li>
                <li><a href="AdminLogoutServlet" onclick="return confirm('Are you sure you want to log out?')"><i class='bx bx-log-out'></i>Logout</a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <h2>User Details</h2>
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Search here..." onkeyup="filterPayments()">
                <i class='bx bx-search' onclick="filterPayments()"></i>
            </div>
            <div id="noResultsMessage" class="no-payments" style="display: none;">
                No users match your search.
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>DOB</th>
                        <th>Gender</th>
                        <th>Membership</th>
                        <th>Remember</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <%
                        List<User> userDetails = (List<User>) request.getAttribute("userDetails");
                        if (userDetails != null && !userDetails.isEmpty()) {
                            for (User user : userDetails) {
                    %>
                    <tr data-id="<%= user.getId() %>"
                        data-username="<%= user.getUsername() != null ? user.getUsername() : "" %>"
                        data-email="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                        data-address="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                        data-dob="<%= user.getDob() != null ? user.getDob() : "" %>"
                        data-gender="<%= user.getGender() != null ? user.getGender() : "" %>"
                        data-membership="<%= user.getMembership() != null ? user.getMembership() : "" %>"
                        data-remember="<%= user.isRemember() ? "Yes" : "No" %>">
                        <td><%= user.getId() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getAddress() != null ? user.getAddress() : "N/A" %></td>
                        <td><%= user.getDob() != null ? user.getDob() : "N/A" %></td>
                        <td><%= user.getGender() %></td>
                        <td><%= user.getMembership() %></td>
                        <td><%= user.isRemember() ? "Yes" : "No" %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8">No user details available.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterPayments() {
            const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();
            const rows = document.querySelectorAll("#userTableBody tr");
            const noResultsMessage = document.getElementById("noResultsMessage");
            let hasVisibleRows = false;

            rows.forEach(row => {
                const id = (row.getAttribute("data-id") || "").toLowerCase();
                const username = (row.getAttribute("data-username") || "").toLowerCase();
                const email = (row.getAttribute("data-email") || "").toLowerCase();
                const address = (row.getAttribute("data-address") || "").toLowerCase();
                const dob = (row.getAttribute("data-dob") || "").toLowerCase();
                const gender = (row.getAttribute("data-gender") || "").toLowerCase();
                const membership = (row.getAttribute("data-membership") || "").toLowerCase();
                const remember = (row.getAttribute("data-remember") || "").toLowerCase();

                const matches = id.includes(searchTerm) || username.includes(searchTerm) || email.includes(searchTerm) ||
                               address.includes(searchTerm) || dob.includes(searchTerm) || gender.includes(searchTerm) ||
                               membership.includes(searchTerm) || remember.includes(searchTerm);

                row.style.display = matches ? "" : "none";
                if (matches) hasVisibleRows = true;
            });

            noResultsMessage.style.display = hasVisibleRows ? "none" : "block";
        }
    </script>
</body>
</html>