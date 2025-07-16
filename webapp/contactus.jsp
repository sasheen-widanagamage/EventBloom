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
        <form action="InsertMessageServlet" method="post">
            <h1>Contact Us</h1>
            <input type="text" id="fname" name="fname" placeholder="First Name" onkeypress="return allowOnlyLetters(event)" required>
            <input type="text" id="lname" name="lname" placeholder="Last Name" onkeypress="return allowOnlyLetters(event)" required>
            <input type="email" id="email" name="email" placeholder="Email" required>
            <input type="text" id="mobile" name="mobile" placeholder="Mobile" required>
            
            <h4>Type your Message Here...</h4>
            <textarea name="message" required></textarea>
            
            <button type="submit" class="submit-btn">Submit</button>

        </form>
    </div>
    
<script>
  // Allow only letters for name fields
  function allowOnlyLetters(e) {
    const char = String.fromCharCode(e.keyCode);
    const pattern = /^[a-zA-Z\s]*$/;
    return pattern.test(char);
  }

  // Form validation
  document.querySelector("form").addEventListener("submit", function(e) {
    const fname = document.getElementById("fname").value.trim();
    const lname = document.getElementById("lname").value.trim();
    const email = document.getElementById("email").value.trim();
    const mobile = document.getElementById("mobile").value.trim();
    const message = document.querySelector("textarea[name='message']").value.trim();

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const mobilePattern = /^\d{10}$/;

    if (fname === "" || lname === "" || email === "" || mobile === "" || message === "") {
      Swal.fire("All fields are required.");
      e.preventDefault();
      return;
    }

    if (!emailPattern.test(email)) {
      Swal.fire("Please enter a valid email address.");
      e.preventDefault();
      return;
    }

    if (!mobilePattern.test(mobile)) {
      Swal.fire("Mobile number must be 10 digits.");
      e.preventDefault();
      return;
    }

    // Optional: success feedback before form submits
    // Swal.fire("Message submitted!").then(() => this.submit());
  });
</script>


      
</body>
</html>
