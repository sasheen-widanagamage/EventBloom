<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Form</title>
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="css/customizeUI.css" />
    <link rel="stylesheet" href="css/form.css" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation bar -->
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
            <button><a href="register.jsp">Sign Up</a></button>
        </nav>
    </div>

    <div id="backgroundWrapper">
        <div class="form-container">
            <h2 id="formTitle">Customize Your Event Plan</h2>
            <form id="eventForm" action="InsertServlet" method="post">
                <label for="cusName">Name:</label>
                <input type="text" id="cusName" name="cusName" placeholder="Enter your name" required />

                <label for="cusEmail">Email Address:</label>
                <input type="email" id="cusEmail" name="cusEmail" placeholder="Enter your email" required />

                <label for="eventDate">Event Date:</label>
                <input type="date" id="eventDate" name="eventDate" required />

                <label for="noOfParticipants">Number of Participants:</label>
                <input type="number" id="noOfParticipants" name="noOfParticipants" min="1" placeholder="e.g., 100" required />

                <label for="eventColour">Color Scheme:</label>
                <select id="eventColour" name="eventColour" required>
                    <option value="gold_white">Gold and White</option>
                    <option value="blue_white">Blue and White</option>
                    <option value="pastel">Pastel</option>
                    <option value="vibrant">Vibrant</option>
                    <option value="monochrome">Monochrome</option>
                    <option value="other">Other</option>
                </select>

                <label for="venueType">Venue Type:</label>
                <select id="venueType" name="venueType" required>
                    <option value="indoor">Indoor</option>
                    <option value="outdoor">Outdoor</option>
                    <option value="banquetHall">Banquet Hall</option>
                    <option value="beach">Beach</option>
                    <option value="other">Other</option>
                </select>

                <label for="foodBeverage">Food And Beverage:</label>
                <select id="foodBeverage" name="foodBeverage" required>
                    <option value="buffet">Buffet</option>
                    <option value="platedMeal">Plated Meal</option>
                    <option value="vegetarian">Vegetarian Options</option>
                    <option value="other">Other</option>
                </select>

                <label for="musicEntertainment">Music/Entertainment:</label>
                <select id="musicEntertainment" name="musicEntertainment" required>
                    <option value="dj">DJ</option>
                    <option value="liveBand">Live Band</option>
                    <option value="traditional">Traditional</option>
                    <option value="none">None</option>
                </select>

                <label for="decorations">Decoration Preferences:</label>
                <select id="decorations" name="decorations" required>
                    <option value="floral">Floral</option>
                    <option value="minimalist">Minimalist</option>
                    <option value="balloons">Balloons</option>
                    <option value="none">None</option>
                </select>

                <label for="other">Additional Comments or Instructions:</label>
                <textarea id="other" name="other" placeholder="Write any additional instructions or comments here..." rows="4"></textarea>

                <button type="submit">Submit</button>
            </form>
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
                        <li><a href="eventsInfo.html">Our Services</a></li>
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
                        <li>1102/B, Bambala Pitiya, Colombo 03</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <script src="form.js"></script>
</body>
</html>