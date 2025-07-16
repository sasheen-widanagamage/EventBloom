<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - EventBloom</title>
    <link rel="stylesheet" href="css/cofirmMessage.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
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


    <!-- Background Video -->
    <video autoplay muted loop id="bg-video">
        <source src="image/home.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>


    <div class="contact">
       <div class="info">
            <h1>Confirm Your Details</h1>
            <c:forEach var="contact" items="${contactDetails}">
                    <p><strong>First Name :</strong> ${contact.fname}</p>
                    <p><strong>Last Name :</strong> ${contact.lname}</p>
                    <p><strong>Email :</strong> ${contact.email}</p>
                    <p><strong>Phone :</strong> ${contact.mobile}</p>
                    <p><strong>Message :</strong> ${contact.message}</p>
            </c:forEach>
            
            <div class="button-group">
                <a href="confirmContactMessage.html" class="btn green">Confirm</a>
                
                <c:forEach var="contact" items="${contactDetails}">
                        <c:url value="editContactUs.jsp" var="updateMessege">
                        <c:param name="id" value="${contact.id}"/>
                        <c:param name="fname" value="${contact.fname}"/>
                        <c:param name="lname" value="${contact.lname}"/>
                        <c:param name="email" value="${contact.email}"/>
                        <c:param name="mobile" value="${contact.mobile}"/>
                        <c:param name="message" value="${contact.message}"/>
                   </c:url>
                <a href="${updateMessege}" class="btn blue">Edit</a>
                </c:forEach>
                
                <c:forEach var="contact" items="${contactDetails}">
                        <c:url value="deleteContactUs.jsp" var="deleteMessege">
                       <c:param name="id" value="${contact.id}"/>
                        <c:param name="fname" value="${contact.fname}"/>
                        <c:param name="lname" value="${contact.lname}"/>
                        <c:param name="email" value="${contact.email}"/>
                        <c:param name="mobile" value="${contact.mobile}"/>
                        <c:param name="message" value="${contact.message}"/>
                   </c:url>
                <a href="${deleteMessege}" class="btn red">Delete</a>
                </c:forEach>
            </div>
          </div>  
    </div>

    
      
</body>
</html>
