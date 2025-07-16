document.addEventListener("DOMContentLoaded", () => {
    const params = new URLSearchParams(window.location.search);
    const selectedEvent = params.get("event");
    const formTitle = document.getElementById("formTitle");
    const backgroundWrapper = document.getElementById("backgroundWrapper");

    const backgroundImages = {
        "weddings": "Images/Vimage1.jpg",
        "birthdays": "Images/Vimage2.jpg",
        "corporate meetings": "Images/Vimage6.jpg",
        "social gatherings": "Images/Vimage4.jpeg",
        "festivals & cultural events": "Images/Vimage5.png",
        "anniversaries and gatherings": "Images/Vimage3.webp"
    };

    if (selectedEvent) {
        const cleanEvent = selectedEvent.trim().toLowerCase();
        const bgUrl = backgroundImages[cleanEvent] || "Images/default.jpg";
        console.log("Selected event:", cleanEvent, "Background URL:", bgUrl);

        // Set background image
        backgroundWrapper.style.backgroundImage = `url('${bgUrl}')`;
        // Capitalize event name for title
        const formattedEvent = selectedEvent
            .split(" ")
            .map(word => word.charAt(0).toUpperCase() + word.slice(1))
            .join(" ");
        formTitle.textContent = `Customize Your ${formattedEvent} Plan`;
    } else {
        console.warn("No event parameter provided, using default settings");
        backgroundWrapper.style.backgroundImage = `url('Images/default.jpg')`;
        formTitle.textContent = "Customize Your Event Plan";
    }
});