package adminControl;

import java.sql.Date;

public class EventPlanner implements Staff{
	
	private int id;
    private String name;
    private String nic;
    private String phone;
    private String email;
    private String address;
    private String district;
    private String province;
    private java.sql.Date birthday;
    private String gender; // "Male" or "Female"
    private String password;
    private String specialization;
	
    
    public EventPlanner(int id, String name, String nic, String phone, String email, String address, String district,
			String province, Date birthday, String gender, String password, String specialization) {
		super();
		this.id = id;
		this.name = name;
		this.nic = nic;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.district = district;
		this.province = province;
		this.birthday = birthday;
		this.gender = gender;
		this.password = password;
		this.specialization = specialization;
	}
    
    public EventPlanner(String name, String nic, String phone, String email, String address, String district,
			String province, Date birthday, String gender, String password, String specialization) {
		super();
		this.name = name;
		this.nic = nic;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.district = district;
		this.province = province;
		this.birthday = birthday;
		this.gender = gender;
		this.password = password;
		this.specialization = specialization;
	}


	public int getId() {
		return id;
	}


	public String getName() {
		return name;
	}


	public String getNic() {
		return nic;
	}


	public String getPhone() {
		return phone;
	}


	public String getEmail() {
		return email;
	}


	public String getAddress() {
		return address;
	}


	public String getDistrict() {
		return district;
	}


	public String getProvince() {
		return province;
	}


	public java.sql.Date getBirthday() {
		return birthday;
	}


	public String getGender() {
		return gender;
	}


	public String getPassword() {
		return password;
	}


	public String getSpecialization() {
		return specialization;
	}


	public void setId(int id) {
		this.id = id;
	}


	public void setName(String name) {
		this.name = name;
	}


	public void setNic(String nic) {
		this.nic = nic;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public void setDistrict(String district) {
		this.district = district;
	}


	public void setProvince(String province) {
		this.province = province;
	}


	public void setBirthday(java.sql.Date birthday) {
		this.birthday = birthday;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

    
    
	
	

    
    

}
