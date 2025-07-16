<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="adminControl.AdminDBUtil" %>
<%@ page import="adminControl.EventModerator" %>
<%@ page import="adminControl.EventPlanner" %>
<%@ page import="loginControl.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Notifications - EventBloom</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/adminNotification.css">
    <style>
        /* Search Bar */
        .search-bar {
            background-color: #0056b3;
            padding: 10px 15px;
            border-radius: 25px;
            display: flex;
            align-items: center;
            max-width: 400px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .search-bar input {
            flex-grow: 1;
            border: none;
            background: none;
            outline: none;
            font-size: 16px;
            color: #fff;
            padding: 5px;
        }

        .search-bar input::placeholder {
            color: #bbb;
            font-style: italic;
        }

        .search-bar i {
            color: white;
            font-size: 20px;
            cursor: pointer;
            transition: color 0.3s;
        }

        .search-bar i:hover {
            color: #ddd;
        }
    </style>
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

    <!-- Notification Content -->
    <div class="notification-panel">
        <h2><i class='bx bxs-bell'></i> Admin Notifications</h2>
        
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search notifications..." onkeyup="filterPayments()">
            <i class='bx bx-search' onclick="filterPayments()"></i>
        </div>

        <div class="clear-btn-wrapper">
            <button class="clear-btn" onclick="clearNotifications()">
                <i class='bx bx-trash'></i> Clear All Notifications
            </button>
        </div>

        <div id="notificationList">
            <%
                List<EventModerator> moderators = AdminDBUtil.getAllModerator();
                List<EventPlanner> planners = AdminDBUtil.getAllPlanner();
                List<User> users = AdminDBUtil.displayUserDetails();
                LocalDate now = LocalDate.now();

                // Combine and sort by birthday (as a proxy for creation date)
                List<Object> allRecords = new ArrayList<>();
                allRecords.addAll(moderators);
                allRecords.addAll(planners);
                allRecords.addAll(users);
                Collections.sort(allRecords, new Comparator<Object>() {
                    @Override
                    public int compare(Object o1, Object o2) {
                        LocalDate date1 = (o1 instanceof EventModerator) ? ((EventModerator) o1).getBirthday().toLocalDate()
                                : (o1 instanceof EventPlanner) ? ((EventPlanner) o1).getBirthday().toLocalDate()
                                : ((User) o1).getDob().toLocalDate();
                        LocalDate date2 = (o2 instanceof EventModerator) ? ((EventModerator) o2).getBirthday().toLocalDate()
                                : (o2 instanceof EventPlanner) ? ((EventPlanner) o2).getBirthday().toLocalDate()
                                : ((User) o2).getDob().toLocalDate();
                        return date2.compareTo(date1); // Descending order
                    }
                });

                for (Object record : allRecords) {
                    String name = (record instanceof EventModerator) ? ((EventModerator) record).getName()
                            : (record instanceof EventPlanner) ? ((EventPlanner) record).getName()
                            : ((User) record).getUsername();
                    LocalDate recordDate = (record instanceof EventModerator) ? ((EventModerator) record).getBirthday().toLocalDate()
                            : (record instanceof EventPlanner) ? ((EventPlanner) record).getBirthday().toLocalDate()
                            : ((User) record).getDob().toLocalDate();
                    long daysDiff = ChronoUnit.DAYS.between(recordDate, now);
                    String timeAgo = (daysDiff == 0) ? "Today" : (daysDiff == 1) ? "Yesterday"
                            : (daysDiff <= 7) ? daysDiff + " days ago"
                            : daysDiff + " days ago";
                    String iconClass = "", iconColor = "";
                    String action = "";

                    if (record instanceof EventModerator) {
                        iconClass = "bx-user-plus";
                        iconColor = "#43a047";
                        action = "New Moderator \"" + name + "\" has been added to the system.";
                    } else if (record instanceof EventPlanner) {
                        iconClass = "bx-user-plus";
                        iconColor = "#43a047";
                        action = "New Planner \"" + name + "\" has been added to the system.";
                    } else if (record instanceof User) {
                        iconClass = "bx-group";
                        iconColor = "#8e24aa";
                        action = "New User \"" + name + "\" registered to EventBloom.";
                    }
            %>
            <div class="notification" data-content="<%= action.toLowerCase() %>">
                <i class='bx <%= iconClass %>' style="color: <%= iconColor %>;"></i>
                <%= action %>
                <span class="time"><%= timeAgo %></span>
            </div>
            <hr>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    function clearNotifications() {
        const panel = document.getElementById('notificationList');
        panel.innerHTML = '<p style="color: gray; text-align: center; margin-top: 20px;">All notifications cleared.</p>';
    }

    function filterPayments() {
        const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();
        const notifications = document.querySelectorAll("#notificationList .notification");
        const noResultsMessage = document.createElement("div");
        noResultsMessage.id = "noResultsMessage";
        noResultsMessage.className = "no-payments";
        noResultsMessage.style.display = "none";
        noResultsMessage.textContent = "No notifications match your search.";
        const notificationList = document.getElementById("notificationList");
        let hasVisibleNotifications = false;

        if (!document.getElementById("noResultsMessage")) {
            notificationList.appendChild(noResultsMessage);
        }

        notifications.forEach(notification => {
            const content = (notification.getAttribute("data-content") || "").toLowerCase();
            const matches = content.includes(searchTerm);

            notification.style.display = matches ? "" : "none";
            if (matches) hasVisibleNotifications = true;
        });

        document.getElementById("noResultsMessage").style.display = hasVisibleNotifications ? "none" : "block";
    }
</script>
</body>
</html>