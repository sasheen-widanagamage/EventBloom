<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="adminControl.Staff" %>
<%@ page import="adminControl.EventPlanner" %>
<%@ page import="adminControl.EventModerator" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Details - EventBloom</title>
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
            <h2>Staff Details</h2>
            <!-- Search Bar -->
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Search here..." onkeyup="filterPayments()">
                <i class='bx bx-search' onclick="filterPayments()"></i>
            </div>
            <div id="noResultsMessage" class="no-payments" style="display: none;">
                No staff members match your search.
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
                        <th>Role</th>
                        <th>Specialization</th>
                    </tr>
                </thead>
                <tbody id="staffTableBody">
                    <%
                        List<Staff> staffDetails = (List<Staff>) request.getAttribute("staffDetails");
                        if (staffDetails != null && !staffDetails.isEmpty()) {
                            for (Staff staff : staffDetails) {
                    %>
                    <tr data-id="<%= staff.getId() %>"
                        data-name="<%= staff.getName() != null ? staff.getName() : "" %>"
                        data-nic="<%= staff.getNic() != null ? staff.getNic() : "" %>"
                        data-phone="<%= staff.getPhone() != null ? staff.getPhone() : "" %>"
                        data-email="<%= staff.getEmail() != null ? staff.getEmail() : "" %>"
                        data-address="<%= staff.getAddress() != null ? staff.getAddress() : "" %>"
                        data-district="<%= staff.getDistrict() != null ? staff.getDistrict() : "" %>"
                        data-province="<%= staff.getProvince() != null ? staff.getProvince() : "" %>"
                        data-birthday="<%= staff.getBirthday() != null ? staff.getBirthday() : "" %>"
                        data-gender="<%= staff.getGender() != null ? staff.getGender() : "" %>"
                        data-role="<%= (staff instanceof EventPlanner) ? "Planner" : "Moderator" %>"
                        data-specialization="<%= (staff instanceof EventPlanner) ? ((EventPlanner) staff).getSpecialization() != null ? ((EventPlanner) staff).getSpecialization() : "N/A" : "N/A" %>">
                        <td><%= staff.getId() %></td>
                        <td><%= staff.getName() %></td>
                        <td><%= staff.getNic() %></td>
                        <td><%= staff.getPhone() %></td>
                        <td><%= staff.getEmail() %></td>
                        <td><%= staff.getAddress() %></td>
                        <td><%= staff.getDistrict() %></td>
                        <td><%= staff.getProvince() %></td>
                        <td><%= staff.getBirthday() %></td>
                        <td><%= staff.getGender() %></td>
                        <td><%= (staff instanceof EventPlanner) ? "Planner" : "Moderator" %></td>
                        <td><%= (staff instanceof EventPlanner) ? ((EventPlanner) staff).getSpecialization() : "N/A" %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="12">No staff details available.</td>
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
            const rows = document.querySelectorAll("#staffTableBody tr");
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
                const role = (row.getAttribute("data-role") || "").toLowerCase();
                const specialization = (row.getAttribute("data-specialization") || "").toLowerCase();

                const matches = id.includes(searchTerm) || name.includes(searchTerm) || nic.includes(searchTerm) ||
                               phone.includes(searchTerm) || email.includes(searchTerm) || address.includes(searchTerm) ||
                               district.includes(searchTerm) || province.includes(searchTerm) || birthday.includes(searchTerm) ||
                               gender.includes(searchTerm) || role.includes(searchTerm) || specialization.includes(searchTerm);

                row.style.display = matches ? "" : "none";
                if (matches) hasVisibleRows = true;
            });

            noResultsMessage.style.display = hasVisibleRows ? "none" : "block";
        }
    </script>
</body>
</html>