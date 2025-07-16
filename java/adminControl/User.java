package adminControl;


import java.sql.Date;

public class User {
	
	private int id;
    private String username;
    private String email;
    private String address;
    private Date dob;
    private String gender;
    private String membership;
    private String password;
    private boolean remember;
    private java.sql.Timestamp createdAt;
	
    public User(int id, String username, String email, String address, Date dob, String gender,
            String membership, String password, boolean remember) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.address = address;
    this.dob = dob;
    this.gender = gender;
    this.membership = membership;
    this.password = password;
    this.remember = remember;
}

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

	public int getId() {
		return id;
	}

	public String getUsername() {
		return username;
	}

	public String getEmail() {
		return email;
	}

	public String getAddress() {
		return address;
	}

	public Date getDob() {
		return dob;
	}

	public String getGender() {
		return gender;
	}

	public String getMembership() {
		return membership;
	}

	public String getPassword() {
		return password;
	}

	public boolean isRemember() {
		return remember;
	}

	

	
    
    
    

}