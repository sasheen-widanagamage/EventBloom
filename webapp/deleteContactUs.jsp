<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - EventBloom</title>
    <link rel="stylesheet" href="css/contactus.css">
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
        <form action="DeleteContactServlet" method="post">
            <h1>Delete message</h1>
            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
            <input type="text" id="fname" name="fname" placeholder="First Name" value="<%= request.getParameter("fname") %>" required>
            <input type="text" id="lname" name="lname" placeholder="Last Name" value="<%= request.getParameter("lname") %>" required>
            <input type="email" id="email" name="email" placeholder="Email" value="<%= request.getParameter("email") %>" required>
            <input type="text" id="mobile" name="mobile" placeholder="Mobile" value="<%= request.getParameter("mobile") %>" required>
            
            <h4>Type your Message Here...</h4>
            <textarea name="message" required><%= request.getParameter("message") %></textarea>
            
            <button type="submit" class="delete-btn">delete</button>

        </form>
    </div>


      
</body>
</html>
