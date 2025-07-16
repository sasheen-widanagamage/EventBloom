// customizeUI.js
function openForm(eventType) {
    // Redirect to form.jsp with the event type as a query parameter
    window.location.href = `form.jsp?event=${encodeURIComponent(eventType)}`;
}
