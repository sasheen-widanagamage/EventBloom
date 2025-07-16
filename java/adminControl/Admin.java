package adminControl;

public class Admin {

	private int id;
    private String username;
    private String email;
    private String address;
    private String password;
	
    public Admin(int id, String username, String email, String address, String password) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.address = address;
		this.password = password;
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

	public String getPassword() {
		return password;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setPassword(String password) {
		this.password = password;
	}
    
    
    
    
}
