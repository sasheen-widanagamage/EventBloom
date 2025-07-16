<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href='css/register.css' rel='stylesheet'>
    <!-- Add SweetAlert2 for better UX -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <!-- Header -->
    <div class="hero">
        <nav>
            <h2 class="logo">Event<span>Bloom</span></h2>
            <ul>
                <li><a href="home.html">Home</a></li>
                <li><a href="aboutUs.html">About Us</a></li>
                <li><a href="eventsInfo.html">Events</a></li>
                <li><a href="contactus.jsp">Contact</a></li>
                <li><a href="faq.html">FAQ</a></li>
            </ul>
            <button type="button"><a href="register.jsp">Sign Up</a></button>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Left panel -->
            <div class="left-panel">
                <video autoplay loop muted playsinline>
                    <source src="image/singupvideo.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
                <div class="text-overlay">
                    <h2>THEGOOD NETWORK</h2>
                    <p>We are Invite only right now.</p>
                    <p>10 Million+ people have joined our network. We invite you to join the tribe.</p>
                    <p>Already have an account? <a href="login.jsp">Sign in</a></p>
                    <p><a href="adminLogin.jsp">Admin Login</a></p>
                </div>
            </div>

            <!-- Right panel -->
            <div class="right-panel">
                <h2>Sign Up</h2>
                <c:if test="${not empty errorMessage}">
                    <p style="color: red; text-align: center;">${errorMessage}</p>
                </c:if>
                <form id="signupForm" action="InsertUserServlet" method="post">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i> Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" rows="4" placeholder="Enter your address" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="dob">Date of Birth</label>
                        <input type="date" id="dob" name="dob" required max="">
                    </div>

                    <div class="form-group">
                        <label for="gender"><i class="fas fa-user"></i> Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="">Select your gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Membership Type</label>
                        <div>
                            <input type="radio" id="basic" name="membership" value="Basic" required>
                            <label for="basic">Basic</label>
                            <input type="radio" id="premium" name="membership" value="Premium">
                            <label for="premium">Premium</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <div class="remember-forgot">
                        <label><input type="checkbox" name="remember"> Remember me </label>
                        <a href="forget.html">Forgot password?</a>
                    </div>

                    <button type="submit" name="submit" value="register">Sign Up</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="f_container">
            <div class="row">
                <div class="footer-col">
                    <h4>Event Bloom</h4>
                    <ul>
                        <li><a href="terms.jsp">Terms & Conditions</a></li>
                        <li><a href="privacy.jsp">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Support</h4>
                    <ul>
                        <li><a href="faq.html">FAQ</a></li>
                        <li><a href="contactus.jsp">Help Center</a></li>
                        <li><a href="eventsInfo.html"> Our Services</a></li>
                        <li><a href="poption.html">Payment Options</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Follow Us</h4>
                    <div class="social-links">
                        <a href="https://www.facebook.com/"><i class='bx bxl-facebook-circle'></i></a>
                        <a href="https://www.instagram.com/"><i class='bx bxl-instagram-alt'></i></a>
                        <a href="https://x.com/"><i class='bx bxl-twitter'></i></a>
                        <a href="https://web.whatsapp.com/"><i class='bx bxl-whatsapp'></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Contact</h4>
                    <ul>
                        <li>contact@EventBloom.com</li>
                        <li>+9471235679</li>
                        <li>1102/B,Bambala Pitiya, Colombo 03</li>
                    </ul>
                </div>
            </div>
        </div>   
    </footer>

    <script>
    // Set max date for dob to yesterday
    const today = new Date();
    today.setDate(today.getDate() - 1); // Subtract 1 day to exclude today
    const maxDate = today.toISOString().split("T")[0]; // Format as YYYY-MM-DD
    document.getElementById("dob").setAttribute("max", maxDate);

    document.getElementById("signupForm").addEventListener("submit", function(e) {
        let username = document.getElementById("username").value.trim();
        let email = document.getElementById("email").value.trim();
        let address = document.getElementById("address").value.trim();
        let dob = document.getElementById("dob").value;
        let gender = document.getElementById("gender").value;
        let membershipChecked = document.querySelector('input[name="membership"]:checked');
        let password = document.getElementById("password").value;

        let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;

        // Validate username
        if (username === "") {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please enter a username.'
            });
            e.preventDefault();
            return;
        }

        // Validate email
        if (!emailPattern.test(email)) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please enter a valid email address.'
            });
            e.preventDefault();
            return;
        }

        // Validate address
        if (address === "") {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please enter your address.'
            });
            e.preventDefault();
            return;
        }

        // Validate date of birth
        if (dob === "") {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please select your date of birth.'
            });
            e.preventDefault();
            return;
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
            e.preventDefault();
            return;
        }

        // Validate gender
        if (gender === "") {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please select your gender.'
            });
            e.preventDefault();
            return;
        }

        // Validate membership
        if (!membershipChecked) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please select a membership type.'
            });
            e.preventDefault();
            return;
        }

        // Validate password
        if (password.length < 6) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Password must be at least 6 characters.'
            });
            e.preventDefault();
            return;
        }
    });
    </script>
</body>
</html>