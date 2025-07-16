<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - EventBloom</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href='css/adminPannel.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <!-- User Info -->
            <div class="user-card">
                <img src="image/ad2.jpg" alt="User Photo">
                <section class="greeting">
                    <div style="display: flex; align-items: center; gap: 20px;">
                        <h2><c:out value="${uDEtails[0].username}" default="Admin" /></h2>
                        <div class="greeting-buttons">
                            <button><a href="home.html">Home</a></button>
                        </div>
                    </div>
                    <p>Email: <c:out value="${uDEtails[0].email}" default="N/A" /></p>
                    <p>Address: <c:out value="${uDEtails[0].address}" default="N/A" /></p>
                </section>
                <div class="week-calendar">
                    <div class="calendar-header">
                        <button id="prevWeek"><</button>
                        <span id="calendarMonthYear">May 2025</span>
                        <button id="nextWeek">></button>
                    </div>
                    <div class="calendar-days">
                        <div>Sun</div>
                        <div>Mon</div>
                        <div>Tue</div>
                        <div>Wed</div>
                        <div>Thu</div>
                        <div>Fri</div>
                        <div>Sat</div>
                    </div>
                    <div class="calendar-dates" id="weekDays">
                        <!-- Dynamic Dates Will Be Populated Here -->
                    </div>
                </div>
            </div>

            <h2 style="text-align: center;">EventBloom Analytics</h2>

            <div class="chart-container">
                <canvas id="eventTypeChart"></canvas>
                <canvas id="revenueChart"></canvas>
            </div>

            <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Fetch overview stats via AJAX
                $.ajax({
                    url: 'OverviewStatsServlet',
                    method: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        if (data.error) {
                            console.error('Error fetching overview stats:', data.error);
                            return;
                        }

                        // Update the DOM with the fetched stats
                        document.getElementById("totalBookings").textContent = data.totalBookings;
                        document.getElementById("totalUsers").textContent = data.totalUsers;
                        document.getElementById("totalPlans").textContent = data.totalPlans;
                        document.getElementById("totalPlanners").textContent = data.totalPlanners;
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error for overview stats:', status, error);
                    }
                });

                // Fetch chart data via AJAX
                $.ajax({
                    url: 'ChartDataServlet',
                    method: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        if (data.error) {
                            console.error('Error fetching chart data:', data.error);
                            return;
                        }

                        // Event Type Distribution (Pie Chart)
                        const eventTypeCtx = document.getElementById("eventTypeChart").getContext("2d");
                        new Chart(eventTypeCtx, {
                            type: "pie",
                            data: {
                                labels: data.eventLabels,
                                datasets: [{
                                    data: data.eventCounts,
                                    backgroundColor: ["#003f7f", "#0059b3", "#0073e6", "#3399ff", "#66b3ff"],
                                    borderColor: "#ffffff",
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    title: {
                                        display: true,
                                        text: "Event Type Distribution",
                                        color: "#003f7f",
                                        font: { size: 18 }
                                    },
                                    legend: {
                                        labels: { color: "#003f7f" }
                                    }
                                }
                            }
                        });

                        // Monthly Revenue (Bar Chart)
                        const revenueCtx = document.getElementById("revenueChart").getContext("2d");
                        new Chart(revenueCtx, {
                            type: "bar",
                            data: {
                                labels: data.revenueLabels,
                                datasets: [{
                                    label: "Revenue (USD)",
                                    data: data.revenues,
                                    backgroundColor: "#0073e6",
                                    borderColor: "#0059b3",
                                    borderWidth: 2
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    title: {
                                        display: true,
                                        text: "Monthly Revenue",
                                        color: "#003f7f",
                                        font: { size: 18 }
                                    },
                                    legend: {
                                        labels: { color: "#003f7f" }
                                    }
                                },
                                scales: {
                                    x: {
                                        ticks: { color: "#003f7f" },
                                        grid: { color: "#d9e6f2" }
                                    },
                                    y: {
                                        ticks: { color: "#003f7f" },
                                        grid: { color: "#d9e6f2" }
                                    }
                                }
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error:', status, error);
                    }
                });

                // Calendar logic
                function generateWeek(startDate) {
                    const weekDaysContainer = document.getElementById("weekDays");
                    weekDaysContainer.innerHTML = "";
                    const options = { day: "numeric" };
                    for (let i = 0; i < 7; i++) {
                        const date = new Date(startDate);
                        date.setDate(date.getDate() + i);
                        const dayDiv = document.createElement("div");
                        dayDiv.textContent = date.toLocaleDateString("en-US", options);
                        dayDiv.classList.add("calendar-date");
                        if (i === 0) {
                            dayDiv.classList.add("active");
                        }
                        weekDaysContainer.appendChild(dayDiv);
                    }
                    document.getElementById("calendarMonthYear").textContent =
                        startDate.toLocaleDateString("en-US", { month: "long", year: "numeric" });
                }

                function getStartOfWeek(date) {
                    const day = date.getDay();
                    return new Date(date.setDate(date.getDate() - day));
                }

                let currentWeekStart = getStartOfWeek(new Date());
                generateWeek(currentWeekStart);

                document.getElementById("prevWeek").addEventListener("click", function () {
                    currentWeekStart.setDate(currentWeekStart.getDate() - 7);
                    generateWeek(currentWeekStart);
                });

                document.getElementById("nextWeek").addEventListener("click", function () {
                    currentWeekStart.setDate(currentWeekStart.getDate() + 7);
                    generateWeek(currentWeekStart);
                });
            });
            </script>
        </div>
    </div>

    <section class="overview">
    <div class="stat">
        <h3 id="totalBookings">23</h3>
        <p>Total Bookings</p>
    </div>
    <div class="stat">
        <h3 id="totalUsers">11</h3>
        <p>Users</p>
    </div>
    <div class="stat">
        <h3 id="totalPlans">6</h3>
        <p>Event Plans</p>
    </div>
    <div class="stat">
        <h3 id="totalPlanners">7</h3>
        <p>Event Planners</p>
    </div>
</section>

    

    

    
</body>
</html>