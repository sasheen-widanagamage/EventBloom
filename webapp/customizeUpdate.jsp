<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Event Form</title>
	<link rel="stylesheet" href="css/customizeUpdate.css" />
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
    
	<div id="backgroundWrapper">
      <div class="form-container">
        <h2 id="formTitle">Update Your Customized Event Plan</h2>
		<%
			String cusId = request.getParameter("cusId").trim();
			String cusName = request.getParameter("cusName").trim();
			String cusEmail = request.getParameter("cusEmail").trim();
			String eventDate = request.getParameter("eventDate").trim();
			int noOfParticipants = Integer.parseInt(request.getParameter("noOfParticipants").trim());
			String eventColour = request.getParameter("eventColour").trim();
			String venueType = request.getParameter("venueType").trim();
			String foodBeverage = request.getParameter("foodBeverage").trim();
			String musicEntertainment = request.getParameter("musicEntertainment").trim();
			String decorations = request.getParameter("decorations").trim();
			String other = request.getParameter("other").trim();

		%>
	
		<form action= "UpdateServlet" method= "post">
		  	<label for="Id">ID:</label>
          	<input type="text" id="cusId" name="cusId" value="<%=cusId%>" readonly />
          
          	<label for="name">Name:</label>
          	<input type="text" id="cusName" name="cusName" value="<%=cusName%>" required />

          	<label for="email">Email Address:</label>
          	<input
            	type="email"
            	id="cusEmail"
            	name="cusEmail"
            	value="<%=cusEmail%>"
            	required
          	/>

          	<label for="eventDate">Event Date:</label>
          	<input type="date" id="eventDate" name="eventDate" value="<%=eventDate%>" required />

          	<label for="participants">Number of Participants:</label>
          	<input
            	type="number"
            	id="noOfParticipants"
            	name="noOfParticipants"
            	value="<%=noOfParticipants%>"
            	min="1"
            	required
          	/>

          	<label for="requirements">Event Requirements:</label>

          	<br />

          	<!-- Event customization fields -->

          	<label for="colorScheme">Color Scheme:</label>
          	<select id="eventColour" name="eventColour" required>
            	<option value="gold_white" <%="gold_white".equals(eventColour)?"selected":""%>>Gold and White</option>
            	<option value="blue_white" <%="blue_white".equals(eventColour)?"selected":""%>>Blue and White</option>
            	<option value="pastel" <%="pastel".equals(eventColour)?"selected":""%>>Pastel</option>
            	<option value="vibrant" <%="vibrant".equals(eventColour)?"selected":""%>>Vibrant</option>
            	<option value="monochrome" <%="monochrome".equals(eventColour)?"selected":""%>>Monochrome</option>
            	<option value="other" <%="other".equals(eventColour)?"selected":""%>>Other</option>
          	</select>

          	<br />

          	<label for="venueType">Venue Type:</label>
          	<select id="venueType" name="venueType" required>
            	<option value="indoor" <%="indoor".equals(venueType)?"selected":""%>>Indoor</option>
            	<option value="outdoor" <%="outdoor".equals(venueType)?"selected":""%>>Outdoor</option>
            	<option value="banquetHall" <%="banquetHall".equals(venueType)?"selected":""%>>Banquet Hall</option>
            	<option value="beach" <%="beach".equals(venueType)?"selected":""%>>Beach</option>
            	<option value="other" <%="other".equals(venueType)?"selected":""%>>Other</option>
          	</select>

          	<br />

          	<label for="foodBeverage">Food And Beverage:</label>
          	<select id="foodBeverage" name="foodBeverage" required>
            	<option value="buffet" <%="buffet".equals(foodBeverage)?"selected":""%>>Buffet</option>
            	<option value="platedMeal" <%="platedMeal".equals(foodBeverage)?"selected":""%>>Plated meal</option>
            	<option value="vegetarian" <%="vegetarian".equals(foodBeverage)?"selected":""%>>Vegetarian options</option>
            	<option value="other" <%="other".equals(foodBeverage)?"selected":""%>>Other</option>
          	</select>

          	<br />

          	<label for="musicEntertainment">Music/Entertainment:</label>
          	<select id="musicEntertainment" name="musicEntertainment" required>
            	<option value="dj" <%="dj".equals(musicEntertainment)?"selected":""%>>DJ</option>
            	<option value="liveBand" <%="liveBand".equals(musicEntertainment)?"selected":""%>>Live Band</option>
            	<option value="traditional" <%="traditional".equals(musicEntertainment)?"selected":""%>>Traditional</option>
            	<option value="none" <%="none".equals(musicEntertainment)?"selected":""%>>None</option>
          	</select>

          	<br />

          	<label for="decoration">Decoration Preferences:</label>
          	<select id="decorations" name="decorations" required>
            	<option value="floral" <%="floral".equals(decorations)?"selected":""%>>Floral</option>
            	<option value="minimalist" <%="minimalist".equals(decorations)?"selected":""%>>Minimalist</option>
            	<option value="balloons" <%="balloons".equals(decorations)?"selected":""%>>Balloons</option>
            	<option value="none" <%="none".equals(decorations)?"selected":""%>>None</option>
          	</select>

          	<br />

          	<label for="comments">Additional Comments or Instructions:</label>
          	<textarea
          		id="other"
            	name="other"
          	><%=other%>
          	</textarea>

          	<button type="submit">Submit</button>
        </form>
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
      
</body>
</html>