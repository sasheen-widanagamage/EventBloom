package EventPackage;

public class CustomerModel {
	
	private int cusId;
	private String cusName;
	private String cusEmail;
	private String eventDate;
	private int noOfParticipants;
	private String eventColour;
	private String venueType;
	private String foodBeverage;
	private String musicEntertainment;
	private String decorations;
	private String other;
	
	public CustomerModel(int cusId, String cusName, String cusEmail, String eventDate, int noOfParticipants,
			String eventColour, String venueType, String foodBeverage, String musicEntertainment, String decorations,
			String other) {
		super();
		this.cusId = cusId;
		this.cusName = cusName;
		this.cusEmail = cusEmail;
		this.eventDate = eventDate;
		this.noOfParticipants = noOfParticipants;
		this.eventColour = eventColour;
		this.venueType = venueType;
		this.foodBeverage = foodBeverage;
		this.musicEntertainment = musicEntertainment;
		this.decorations = decorations;
		this.other = other;
	}

	public int getCusId() {
		return cusId;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}

	public String getCusEmail() {
		return cusEmail;
	}

	public void setCusEmail(String cusEmail) {
		this.cusEmail = cusEmail;
	}

	public String getEventDate() {
		return eventDate;
	}

	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}

	public int getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(int noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}

	public String getEventColour() {
		return eventColour;
	}

	public void setEventColour(String eventColour) {
		this.eventColour = eventColour;
	}

	public String getVenueType() {
		return venueType;
	}

	public void setVenueType(String venueType) {
		this.venueType = venueType;
	}

	public String getFoodBeverage() {
		return foodBeverage;
	}

	public void setFoodBeverage(String foodBeverage) {
		this.foodBeverage = foodBeverage;
	}

	public String getMusicEntertainment() {
		return musicEntertainment;
	}

	public void setMusicEntertainment(String musicEntertainment) {
		this.musicEntertainment = musicEntertainment;
	}

	public String getDecorations() {
		return decorations;
	}

	public void setDecorations(String decorations) {
		this.decorations = decorations;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}
	
	
	
	
}
