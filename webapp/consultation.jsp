<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User Profile</title>
    <link rel="stylesheet" href="css/consultation.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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

  <div class="booking-container">
    <div class="doctor-info">
      <img src="image/moda.jpg" alt="Doctor">
      <h2>Mr. Tharindu Akalanka</h2><br>
      <p class="small-text">You can book a Event Moderator if you need any consultation.</p>
      <div class="price">RS.2500 / session</div>
    </div>

    <div class="calendar-header">
      <h3 id="month">Select date for a consultation</h3>
      <button id="prevWeek">←</button>
      <h3 id="monthDisplay">April 2025</h3>
      <button id="nextWeek">→</button>
    </div>
    <div class="calendar-week" id="calendarWeek"></div>

    <div class="slots-section">
      <h3>Showing Available Time Only</h3>
      <div class="slots" id="slots">
        <div class="slot">12:30 PM</div>
        <div class="slot">12:45 PM</div>
        <div class="slot">1:00 PM</div>
        <div class="slot">1:30 PM</div>
        <div class="slot">2:00 PM</div>
        <div class="slot">2:30 PM</div>
      </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const slots = document.querySelectorAll('.slot');
        slots.forEach(slot => {
          slot.addEventListener('click', () => {
            slots.forEach(s => s.classList.remove('selected'));
            slot.classList.add('selected');
          });
        });
      });
    </script>
    

    <button class="next-button">
        <a href="consultationPayment.jsp" class="no-underline">Next</a>
     </button>
  </div>

  <script>
      const weekContainer = document.getElementById("calendarWeek");
const monthDisplay = document.getElementById("monthDisplay");
const prevWeekBtn = document.getElementById("prevWeek");
const nextWeekBtn = document.getElementById("nextWeek");

let currentDate = new Date();

function getStartOfWeek(date) {
  const day = date.getDay(); // 0 (Sun) - 6 (Sat)
  const diff = date.getDate() - day;
  return new Date(date.setDate(diff));
}

function generateWeekView(date) {
  weekContainer.innerHTML = "";

  const startOfWeek = getStartOfWeek(new Date(date));
  const options = { weekday: "short", day: "numeric" };

  for (let i = 0; i < 7; i++) {
    const day = new Date(startOfWeek);
    day.setDate(day.getDate() + i);

    const dayBox = document.createElement("div");
    dayBox.classList.add("day-box");

    if (isSameDay(day, new Date())) {
      dayBox.classList.add("today");
    }

    dayBox.textContent = day.toLocaleDateString("en-US", options);
    dayBox.addEventListener("click", () => {
      document.querySelectorAll(".day-box").forEach(d => d.classList.remove("selected"));
      dayBox.classList.add("selected");
    });

    weekContainer.appendChild(dayBox);
  }

  // Show the month and year of the middle day in the week
  const middleDate = new Date(startOfWeek);
  middleDate.setDate(middleDate.getDate() + 3);
  monthDisplay.textContent = middleDate.toLocaleDateString("en-US", {
    month: "long",
    year: "numeric",
  });
}

function isSameDay(d1, d2) {
  return (
    d1.getDate() === d2.getDate() &&
    d1.getMonth() === d2.getMonth() &&
    d1.getFullYear() === d2.getFullYear()
  );
}

prevWeekBtn.addEventListener("click", () => {
  currentDate.setDate(currentDate.getDate() - 7);
  generateWeekView(currentDate);
});

nextWeekBtn.addEventListener("click", () => {
  currentDate.setDate(currentDate.getDate() + 7);
  generateWeekView(currentDate);
});

generateWeekView(currentDate);
</script>

</body>
</html>
