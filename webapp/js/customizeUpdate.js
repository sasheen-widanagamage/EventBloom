document.addEventListener("DOMContentLoaded", () => {
	const eventDateInput = document.getElementById("eventDate");
	const participantsInput = document.getElementById("noOfParticipants");
	const emailInput = document.getElementById("cusEmail");
	const form = document.getElementById("eventForm");
	
	//Set minimum date to today
	const today = new Date();
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-based
	const day = String(today.getDate()).padStart(2, '0');
	const minDate = `${year}-${month}-${day}`;
	eventDateInput.setAttribute("min", minDate);
		
	// Enforce min and max for number of participants
	participantsInput.setAttribute("min", "1");
	participantsInput.setAttribute("max", "500");

	// Add event listener to prevent values outside the range
	participantsInput.addEventListener("input", () => {
		let value = parseInt(participantsInput.value);
		if (value < 1) {
			   participantsInput.value = 1; // Reset to minimum if below 1
		} else if (value > 500) {
			   participantsInput.value = 500; // Reset to maximum if above 500
		}
	});
			
	// Validate email on form submission
	form.addEventListener("submit", (event) => {
		const emailValue = emailInput.value;
		if (!emailValue.includes("@")) {
			    event.preventDefault(); // Prevent form submission
			    alert("Please enter a valid email address with an @ sign.");
			    emailInput.focus();
		}
	});
	
});

	