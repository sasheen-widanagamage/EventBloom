package formPackage;

public class FormModel {
	
	private int id;
	private String name;
	private String email;
	private String phone;
	private String ePackage;
	private String ePlanner;
	private String eDate;
	private String eLocation;
	private int numberOfGuests;
	private String specialRequirements;
	
	public FormModel(int id, String name, String email, String phone, String ePackage, String ePlanner, String eDate,String eLocation, int numberOfGuests, String specialRequirements) {
		
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.ePackage = ePackage;
		this.ePlanner = ePlanner;
		this.eDate = eDate;
		this.eLocation = eLocation;
		this.numberOfGuests = numberOfGuests;
		this.specialRequirements = specialRequirements;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getePackage() {
		return ePackage;
	}

	public void setePackage(String ePackage) {
		this.ePackage = ePackage;
	}

	public String getePlanner() {
		return ePlanner;
	}

	public void setePlanner(String ePlanner) {
		this.ePlanner = ePlanner;
	}

	public String geteDate() {
		return eDate;
	}

	public void seteDate(String eDate) {
		this.eDate = eDate;
	}

	public String geteLocation() {
		return eLocation;
	}

	public void seteLocation(String eLocation) {
		this.eLocation = eLocation;
	}

	public int getNumberOfGuests() {
		return numberOfGuests;
	}

	public void setNumberOfGuests(int numberOfGuests) {
		this.numberOfGuests = numberOfGuests;
	}

	public String getSpecialRequirements() {
		return specialRequirements;
	}

	public void setSpecialRequirements(String specialRequirements) {
		this.specialRequirements = specialRequirements;
	}
	
	
	
	
}
