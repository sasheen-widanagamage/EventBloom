package contactUsControl;

public class ContactUs {
	
	private int id;
    private String fname;
    private String lname;
    private String email;
    private String mobile;
    private String message;
    private String submittedat;
	
    public ContactUs(int id, String fname, String lname, String email, String mobile, String message,
			String submittedat) {
		super();
		this.id = id;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.mobile = mobile;
		this.message = message;
		this.submittedat = submittedat;
	}

	public int getId() {
		return id;
	}

	public String getFname() {
		return fname;
	}

	public String getLname() {
		return lname;
	}

	public String getEmail() {
		return email;
	}

	public String getMobile() {
		return mobile;
	}

	public String getMessage() {
		return message;
	}

	public String getSubmittedat() {
		return submittedat;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setSubmittedat(String submittedat) {
		this.submittedat = submittedat;
	}
	
    
    

}
