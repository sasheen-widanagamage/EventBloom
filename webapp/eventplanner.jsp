<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>FAQ | Event Bloom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .hero {
            position: relative;
            z-index: 10;
        }

        .navbar-nav .nav-link {
            font-weight: bold;
        }

        footer {
            background-color: #24262b;
            color: white;
            margin-top: auto;  /* Pushes the footer to the bottom */
        }

        footer h4 {
            font-size: 18px;
            margin-bottom: 30px;
            font-weight: 500;
        }

        footer a {
            text-decoration: none;
            color: white;
        }

        footer a:hover {
            color: #f97316;
        }

        .social-links a {
            font-size: 20px;
            color: white;
            margin-right: 15px;
        }

        .social-links a:hover {
            color: #0569ff;
        }

        .select-planner-section {
            background-color: #f8f9fa;
            padding: 50px 0;
        }

        .select-planner-section h2 {
            margin-bottom: 30px;
            font-size: 28px;
        }

        .select-planner-section .form-select {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<!-- Navigation bar -->
<div class="hero">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Event<span>Bloom</span></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="aboutUs.html">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="eventsInfo.html">Events</a></li>
                    <li class="nav-item"><a class="nav-link" href="contactus.jsp">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="faq.html">FAQ</a></li>
                </ul>
            </div>
        </div>
    </nav>
</div>

<!-- Select Event Planner Section -->
<div class="select-planner-section">
    <div class="container text-center">
        <h2>Select Your Event Planner & Make Event Booking</h2>
        <p>Choose from a list of professional event planners who will help you organize your next event.</p>
        <form action="insertForm.jsp" method="POST">
            <select class="form-select" aria-label="Select Event Planner">
                <option selected>Select an Event Planner</option>
                <option value="1">Event Planner 1</option>
                <option value="2">Event Planner 2</option>
                <option value="3">Event Planner 3</option>
                <option value="4">Event Planner 4</option>
                <option value="5">Event Planner 5</option>
            </select>
            <button type="submit" class="btn btn-primary mt-3">Make Event Booking</button>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h4>Event Bloom</h4>
                <ul class="list-unstyled">
                    <li><a href="terms.html" class="text-white">Terms & Conditions</a></li>
                    <li><a href="privacy.html" class="text-white">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h4>Support</h4>
                <ul class="list-unstyled">
                    <li><a href="faq.html" class="text-white">FAQ</a></li>
                    <li><a href="contactus.jsp" class="text-white">Help Center</a></li>
                    <li><a href="eventsInfo.html" class="text-white">Our Services</a></li>
                    <li><a href="poption.html" class="text-white">Payment Options</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h4>Follow Us</h4>
                <div class="social-links">
                    <a href="https://www.facebook.com/" class="text-white me-3"><i class='bx bxl-facebook-circle'></i></a>
                    <a href="https://www.instagram.com/" class="text-white me-3"><i class='bx bxl-instagram-alt'></i></a>
                    <a href="https://x.com/" class="text-white me-3"><i class='bx bxl-twitter'></i></a>
                    <a href="https://web.whatsapp.com/" class="text-white me-3"><i class='bx bxl-whatsapp'></i></a>
                </div>
            </div>
            <div class="col-md-3">
                <h4>Contact</h4>
                <ul class="list-unstyled">
                    <li>contact@EventBloom.com</li>
                    <li>+9471235679</li>
                    <li>1102/B, Bambala Pitiya, Colombo 03</li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
