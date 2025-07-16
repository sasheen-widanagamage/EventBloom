package adminControl;

import java.sql.Date;

public class EventModerator implements Staff{
	
	private int id;
    private String name;
    private String nic;
    private String phone;
    private String email;
    private String address;
    private String district;
    private String province;
    private java.sql.Date birthday;
    private String gender; 
    private String password;
	
    
    public EventModerator(int id, String name, String nic, String phone, String email, String address, String district,
			String province, Date birthday, String gender, String password) {
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
	}

    public EventModerator(String name, String nic, String phone, String email, String address, String district,
			String province, Date birthday, String gender, String password) {
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


	
	
    
    
    

}
