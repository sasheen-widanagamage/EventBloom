<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planner Details - EventBloom</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href='css/userInfoDisplay.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
         
<div class="content-area">
    <h2>Event Planner Details</h2>
    <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Search here..." onkeyup="filterPayments()">
                <i class='bx bx-search' onclick="filterPayments()"></i>
    </div>
    <div id="noResultsMessage" class="no-payments" style="display: none;">
        No planners match your search.
    </div>
    <div class="top-bar">
    <a href="addPlanner.jsp" class="add-moderator-btn">
        <i class='bx bx-plus'></i> Add Planner
    </a>
    </div>
    
        <table>
            <thead>
            <tr>
            <th>ID</th>
            <th>Name</th>
            <th>NIC</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Address</th>
            <th>District</th>
            <th>Province</th>
            <th>Birthday</th>
            <th>Gender</th>
            <th>Specialization</th>
            <th>Password</th>
            <th>Action</th>
        </tr>
            </thead>
            <tbody id="plannerTableBody">
               <c:forEach var="plannerDetails" items="${allPlanner}">
                    <tr data-id="${plannerDetails.id}"
                        data-name="${plannerDetails.name != null ? plannerDetails.name : ''}"
                        data-nic="${plannerDetails.nic != null ? plannerDetails.nic : ''}"
                        data-phone="${plannerDetails.phone != null ? plannerDetails.phone : ''}"
                        data-email="${plannerDetails.email != null ? plannerDetails.email : ''}"
                        data-address="${plannerDetails.address != null ? plannerDetails.address : ''}"
                        data-district="${plannerDetails.district != null ? plannerDetails.district : ''}"
                        data-province="${plannerDetails.province != null ? plannerDetails.province : ''}"
                        data-birthday="${plannerDetails.birthday != null ? plannerDetails.birthday : ''}"
                        data-gender="${plannerDetails.gender != null ? plannerDetails.gender : ''}"
                        data-specialization="${plannerDetails.specialization != null ? plannerDetails.specialization : ''}"
                        data-password="${plannerDetails.password != null ? plannerDetails.password : ''}">
                        <td>${plannerDetails.id}</td>
                        <td>${plannerDetails.name}</td>
                        <td>${plannerDetails.nic}</td>
                        <td>${plannerDetails.phone}</td>
                        <td>${plannerDetails.email}</td>
                        <td>${plannerDetails.address}</td>
                        <td>${plannerDetails.district}</td>
                        <td>${plannerDetails.province}</td>
                        <td>${plannerDetails.birthday}</td>
                        <td>${plannerDetails.gender}</td>
                        <td>${plannerDetails.specialization}</td>
                        <td>${plannerDetails.password}</td>
                        <td>
                            <a href="updatePlanner.jsp?id=${plannerDetails.id}&name=${plannerDetails.name}&nic=${plannerDetails.nic}&phone=${plannerDetails.phone}&email=${plannerDetails.email}&address=${plannerDetails.address}&district=${plannerDetails.district}&province=${plannerDetails.province}&birthday=${plannerDetails.birthday}&gender=${plannerDetails.gender}&specialization=${plannerDetails.specialization}&password=${moderatorDetails.password}">
                                <button class="edit-btn">Edit</button>
                            </a>
                            <form action="DeletePlannerServlet" method="post">
                                <input type="hidden" name="id" value="${plannerDetails.id}" />
                                <button class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterPayments() {
        const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();
        const rows = document.querySelectorAll("#plannerTableBody tr");
        const noResultsMessage = document.getElementById("noResultsMessage");
        let hasVisibleRows = false;

        rows.forEach(row => {
            const id = (row.getAttribute("data-id") || "").toLowerCase();
            const name = (row.getAttribute("data-name") || "").toLowerCase();
            const nic = (row.getAttribute("data-nic") || "").toLowerCase();
            const phone = (row.getAttribute("data-phone") || "").toLowerCase();
            const email = (row.getAttribute("data-email") || "").toLowerCase();
            const address = (row.getAttribute("data-address") || "").toLowerCase();
            const district = (row.getAttribute("data-district") || "").toLowerCase();
            const province = (row.getAttribute("data-province") || "").toLowerCase();
            const birthday = (row.getAttribute("data-birthday") || "").toLowerCase();
            const gender = (row.getAttribute("data-gender") || "").toLowerCase();
            const specialization = (row.getAttribute("data-specialization") || "").toLowerCase();
            const password = (row.getAttribute("data-password") || "").toLowerCase();

            const matches = id.includes(searchTerm) || name.includes(searchTerm) || nic.includes(searchTerm) ||
                           phone.includes(searchTerm) || email.includes(searchTerm) || address.includes(searchTerm) ||
                           district.includes(searchTerm) || province.includes(searchTerm) || birthday.includes(searchTerm) ||
                           gender.includes(searchTerm) || specialization.includes(searchTerm) || password.includes(searchTerm);

            row.style.display = matches ? "" : "none";
            if (matches) hasVisibleRows = true;
        });

        noResultsMessage.style.display = hasVisibleRows ? "none" : "block";
    }
</script>
</body>
</html>