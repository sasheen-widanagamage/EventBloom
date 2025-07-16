<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Event Moderator</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href='css/addModerator.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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

        
        <div class="main-content">
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

            <form class="staff-form" action="AddModeratorServlet" method="POST">
                <h2>Event Moderator Registration</h2>

                <label for="name">Full Name <i class='bx bxs-user'></i></label>
                <input type="text" id="name" name="name" placeholder="Enter full name (e.g., John Doe)" required>

                <label for="nic">NIC <i class='bx bxs-id-card'></i></label>
                <input type="text" id="nic" name="nic" placeholder="e.g., 200012345678 or 200012345V" required>

                <label for="phone">Phone <i class='bx bxs-phone'></i></label>
                <input type="text" id="phone" name="phone" placeholder="e.g., 0712345678" required>

                <label for="email">Email <i class='bx bxs-envelope'></i></label>
                <input type="text" id="email" name="email" placeholder="e.g., john@example.com" required>

                <label for="address">Address Line 1 <i class='bx bxs-location-plus'></i></label>
                <input type="text" id="address" name="address" placeholder="Street, Town, City" required>

                <label for="district">District</label>
                <select id="district" name="district" required>
                    <option value="">-- Select District --</option>
                    <option>Colombo</option>
                    <option>Gampaha</option>
                    <option>Kalutara</option>
                    <option>Kandy</option>
                    <option>Matale</option>
                    <option>Nuwara Eliya</option>
                    <option>Galle</option>
                    <option>Matara</option>
                    <option>Hambantota</option>
                    <option>Jaffna</option>
                    <option>Kilinochchi</option>
                    <option>Mannar</option>
                    <option>Vavuniya</option>
                    <option>Mullaitivu</option>
                    <option>Batticaloa</option>
                    <option>Ampara</option>
                    <option>Trincomalee</option>
                    <option>Kurunegala</option>
                    <option>Puttalam</option>
                    <option>Anuradhapura</option>
                    <option>Polonnaruwa</option>
                    <option>Badulla</option>
                    <option>Monaragala</option>
                    <option>Ratnapura</option>
                    <option>Kegalle</option>
                </select>

                <label for="province">Province</label>
                <select id="province" name="province" required>
                    <option value="">-- Select Province --</option>
                    <option>Western</option>
                    <option>Central</option>
                    <option>Southern</option>
                    <option>Uva</option>
                    <option>Sabaragamuwa</option>
                    <option>North Western</option>
                    <option>North Central</option>
                    <option>Northern</option>
                    <option>Eastern</option>
                </select>

                <label for="birthday">Birthday</label>
                <input type="date" id="birthday" name="birthday" required max="">

                <label>Gender <i class='bx bxs-male-female'></i></label>
                <div class="radio-group">
                    <label><input type="radio" name="gender" value="Male" required> Male</label>
                    <label><input type="radio" name="gender" value="Female"> Female</label>
                </div>

                <label for="password">Login Password <i class='bx bxs-id-card'></i></label>
                <input type="password" id="password" name="password" placeholder="At least 6 characters" required>

                <div class="checkbox-group">
                    <label><input type="checkbox" required> Confirm this is a new user</label>
                </div>

                <button type="submit">Register</button>
            </form>
        </div>
    </div>

    
    <script>
        // Set max date for birthday to yesterday
        const today = new Date();
        today.setDate(today.getDate() - 1); // Subtract 1 day to exclude today
        const maxDate = today.toISOString().split("T")[0]; // Format as YYYY-MM-DD
        document.getElementById("birthday").setAttribute("max", maxDate);

        document.querySelector('.staff-form').addEventListener('submit', function (e) {
            const name = document.getElementById('name').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const birthday = document.getElementById('birthday').value;

            // Name validation (letters and spaces only)
            if (!/^[a-zA-Z\s]+$/.test(name)) {
                alert("Full name can only contain letters and spaces.");
                e.preventDefault();
                return;
            }

            // Phone number validation (10 digits, starts with 0)
            if (!/^0\d{9}$/.test(phone)) {
                alert("Phone number must be 10 digits and start with 0.");
                e.preventDefault();
                return;
            }

            // Email format check
            if (!/^\S+@\S+\.\S+$/.test(email)) {
                alert("Please enter a valid email address.");
                e.preventDefault();
                return;
            }

            // Password length
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                e.preventDefault();
                return;
            }

            // Birthday validation: Ensure it's strictly in the past
            const selectedDate = new Date(birthday);
            const todayDate = new Date();
            todayDate.setHours(0, 0, 0, 0); // Reset time to 00:00 for comparison
            if (selectedDate >= todayDate) {
                alert("Birthday must be a date in the past (before today).");
                e.preventDefault();
                return;
            }
        });

        // Prevent numbers in the name field in real-time
        document.getElementById('name').addEventListener('input', function () {
            this.value = this.value.replace(/[^a-zA-Z\s]/g, '');
        });
    </script>
</body>
</html>