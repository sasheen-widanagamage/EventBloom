<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Customized Event Plan</title>
	<link rel="stylesheet" href="css/customizeOutput.css" />

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
<h2>My Event Details</h2>
<div class="container">
    <c:forEach var="customer" items="${allCustomers}">
        <div class="card">
            <p><strong>ID:</strong> ${customer.cusId}</p>
            <p><strong>Name:</strong> ${customer.cusName}</p>
            <p><strong>Email:</strong> ${customer.cusEmail}</p>
            <p><strong>Event Date:</strong> ${customer.eventDate}</p>
            <p><strong>No. of Participants:</strong> ${customer.noOfParticipants}</p>
            <p><strong>Event Colour:</strong> ${customer.eventColour}</p>
            <p><strong>Venue Type:</strong> ${customer.venueType}</p>
            <p><strong>Food And Beverage:</strong> ${customer.foodBeverage}</p>
            <p><strong>Music And Entertainment:</strong> ${customer.musicEntertainment}</p>
            <p><strong>Decorations:</strong> ${customer.decorations}</p>
            <p><strong>Other:</strong> ${customer.other}</p>
            <div class="action-buttons">
                <a href="customizeUpdate.jsp?cusId=${customer.cusId}
                                &cusName=${customer.cusName}
                                &cusEmail=${customer.cusEmail}
                                &eventDate=${customer.eventDate}
                                &noOfParticipants=${customer.noOfParticipants}
                                &eventColour=${customer.eventColour}
                                &venueType=${customer.venueType}
                                &foodBeverage=${customer.foodBeverage}
                                &musicEntertainment=${customer.musicEntertainment}
                                &decorations=${customer.decorations}
                                &other=${customer.other}">
                    <button>Update</button>
                </a>
                <form action="DeleteServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this event plan?');">
                    <input type="hidden" name="cusId" value="${customer.cusId}" />
                    <button class="delete-btn">Delete</button>
                </form>
            </div>
        </div>
    </c:forEach>
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

</body>
</html>