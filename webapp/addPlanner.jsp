<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Event Planner</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="css/addModerator.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <%
        String[] districts = {
            "Colombo","Gampaha","Kalutara","Kandy","Matale","Nuwara Eliya",
            "Galle","Matara","Hambantota","Jaffna","Kilinochchi","Mannar",
            "Vavuniya","Mullaitivu","Batticaloa","Ampara","Trincomalee",
            "Kurunegala","Puttalam","Anuradhapura","Polonnaruwa",
            "Badulla","Monaragala","Ratnapura","Kegalle"
        };
        String[] provinces = {
            "Western","Central","Southern","Uva","Sabaragamuwa",
            "North Western","North Central","Northern","Eastern"
        };
        String[] specializations = {
            "Wedding Planning","Birthday Party Planning","Annual Planning",
            "Business Event Planning","Sport Event Planning","Other"
        };
        request.setAttribute("districtList", districts);
        request.setAttribute("provinceList", provinces);
        request.setAttribute("specializationList", specializations);
    %>

    <div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event<span>Bloom</span></h2>
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
            <form class="staff-form" action="AddPlannerServlet" method="POST" onsubmit="return validateForm()">
                <h2>Event Planner Registration</h2>

                <label for="name">Full Name <i class="bx bxs-user"></i></label>
                <input type="text" id="name" name="name" placeholder="Enter full name (e.g., John Doe)" required>

                <label for="nic">NIC <i class="bx bxs-id-card"></i></label>
                <input type="text" id="nic" name="nic" placeholder="e.g., 200012345678 or 200012345V" required>

                <label for="phone">Phone <i class="bx bxs-phone"></i></label>
                <input type="text" id="phone" name="phone" placeholder="e.g., 0712345678" required>

                <label for="email">Email <i class="bx bxs-envelope"></i></label>
                <input type="text" id="email" name="email" placeholder="e.g., john@example.com" required>

                <label for="address">Address Line 1 <i class="bx bxs-location-plus"></i></label>
                <input type="text" id="address" name="address" placeholder="Street, Town, City" required>

                <label for="district">District</label>
                <select id="district" name="district" required>
                    <option value="">-- Select District --</option>
                    <c:forEach var="d" items="${districtList}">
                        <option value="${d}">${d}</option>
                    </c:forEach>
                </select>

                <label for="province">Province</label>
                <select id="province" name="province" required>
                    <option value="">-- Select Province --</option>
                    <c:forEach var="p" items="${provinceList}">
                        <option value="${p}">${p}</option>
                    </c:forEach>
                </select>

                <label for="birthday">Birthday</label>
                <input type="date" id="birthday" name="birthday" required max="">

                <label>Gender <i class="bx bxs-male-female"></i></label>
                <div class="radio-group">
                    <label><input type="radio" name="gender" value="Male" required> Male</label>
                    <label><input type="radio" name="gender" value="Female"> Female</label>
                </div>

                <label for="password">Login Password <i class="bx bxs-lock"></i></label>
                <input type="password" id="password" name="password" placeholder="At least 6 characters" required>

                <label for="specialization">Specialization</label>
                <select id="specialization" name="specialization" required>
                    <option value="">-- Select Specialization --</option>
                    <c:forEach var="s" items="${specializationList}">
                        <option value="${s}">${s}</option>
                    </c:forEach>
                </select>

                <div class="checkbox-group">
                    <label><input type="checkbox" required> Confirm this is a new user</label>
                </div>

                <button type="submit">Register</button>
            </form>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <c:if test="${not empty insertSuccess}">
                <script>
                    Swal.fire({
                        icon: '${insertSuccess == "true" ? "success" : "error"}',
                        title: '${insertSuccess == "true" ? "Planner Added Successfully!" : "Failed to Add Planner!"}',
                        text: '${insertSuccess == "true" ? "" : errorMessage}',
                        showConfirmButton: ${insertSuccess == "true" ? "false" : "true"},
                        timer: ${insertSuccess == "true" ? "2000" : "undefined"}
                    });
                </script>
            </c:if>

            <script>
                // Set max date for birthday to yesterday
                const today = new Date();
                today.setDate(today.getDate() - 1); // Subtract 1 day to exclude today
                const maxDate = today.toISOString().split("T")[0]; // Format as YYYY-MM-DD
                document.getElementById("birthday").setAttribute("max", maxDate);

                function validateForm() {
                    const name = document.getElementById('name').value.trim();
                    const nic = document.getElementById('nic').value.trim();
                    const phone = document.getElementById('phone').value.trim();
                    const email = document.getElementById('email').value.trim();
                    const password = document.getElementById('password').value.trim();
                    const specialization = document.getElementById('specialization').value.trim();
                    const birthday = document.getElementById('birthday').value;

                    const nicRegex = /^(\d{9}[Vv]|\d{12})$/;
                    const phoneRegex = /^0\d{9}$/;
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                    if (name.length < 3) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Name must be at least 3 characters long.'
                        });
                        return false;
                    }

                    if (!nicRegex.test(nic)) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'NIC must be 12 digits or 9 digits followed by "V".'
                        });
                        return false;
                    }

                    if (!phoneRegex.test(phone)) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Enter a valid 10-digit Sri Lankan phone number starting with 0.'
                        });
                        return false;
                    }

                    if (!emailRegex.test(email)) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Enter a valid email address.'
                        });
                        return false;
                    }

                    if (password.length < 6) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Password must be at least 6 characters.'
                        });
                        return false;
                    }

                    if (!specialization) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Please select a specialization.'
                        });
                        return false;
                    }

                    // Birthday validation: Ensure it's strictly in the past
                    const selectedDate = new Date(birthday);
                    const todayDate = new Date();
                    todayDate.setHours(0, 0, 0, 0); // Reset time to 00:00 for comparison
                    if (selectedDate >= todayDate) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Validation Error',
                            text: 'Birthday must be a date in the past (before today).'
                        });
                        return false;
                    }

                    return true;
                }
            </script>
        </div>
    </div>
</body>
</html>