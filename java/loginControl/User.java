package loginControl;

import java.sql.Date;

/**
 * Represents a user entity with profile details and photo.
 */
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
    private byte[] photo;

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

    public User(int id, String username, String email, String address, Date dob, String gender, String membership,
                String password, boolean remember, byte[] photo) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.address = address;
        this.dob = dob;
        this.gender = gender;
        this.membership = membership;
        this.password = password;
        this.remember = remember;
        this.photo = photo;
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

    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public int getPhotoLength() {
        return photo != null ? photo.length : 0;
    }
}