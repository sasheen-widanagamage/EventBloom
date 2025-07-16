<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customize Your Own Plan</title>
	<base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="css/customizeUI.css" />
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
            <button type="button"><a href="register.jsp">Sign Up</a></button>
        </nav>
    </div>

    <div class="container">
      <div class="event-box" onclick="openForm('Weddings')">
        <img src="image/Vimage1.jpg" alt="Weddings" />
        <p>Weddings</p>
      </div>

      <div class="event-box" onclick="openForm('Birthdays')">
        <img src="image/Vimage2.jpg" alt="Birthdays" />
        <p>Birthdays</p>
      </div>

      <div class="event-box" onclick="openForm('Corporate Meetings')">
        <img src="image/Vimage6.jpg" alt="Corporate Meetings" />
        <p>Corporate Meetings</p>
      </div>

      <div class="event-box" onclick="openForm('Social Gatherings')">
        <img src="image/Vimage4.jpeg" alt="Social Gatherings" />
        <p>Social Gatherings</p>
      </div>

      <div class="event-box" onclick="openForm('Festivals & Cultural Events')">
        <img src="image/Vimage5.png" alt="Festivals" />
        <p>Festivals and Cultures</p>
      </div>

      <div class="event-box" onclick="openForm('Anniversaries and Gatherings')">
        <img src="image/Vimage3.webp" alt="Anniversaries and Gatherings" />
        <p>Anniversaries and Gatherings</p>
      </div>
    </div>
    
<!-- footer -->
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
    
    <script src="js/customizeUI.js"></script>
</body>
</html>