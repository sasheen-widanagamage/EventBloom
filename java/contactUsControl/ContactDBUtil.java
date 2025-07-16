package contactUsControl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class ContactDBUtil {
	
	private static boolean isSuccess;
	private static Connection con=null;
	private static Statement stmt =null;
	private static ResultSet rs =null;
	
	
//Insert message details
public static boolean insertMessage(String fname, String lname, String email, String mobile, String message) {
		
		boolean isSuccess= false;
				try {
					con = DBconnector.getConnection();
					stmt = con.createStatement();
					String sql = "INSERT INTO contact_messages (fname, lname, email, mobile, message) " +
				             "VALUES (?, ?, ?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, fname);
				ps.setString(2, lname);
				ps.setString(3, email);
				ps.setString(4, mobile);
				ps.setString(5, message);
				
				    int result = ps.executeUpdate();

					if(result>0) 
					{
						isSuccess= true;
					}
					else
					{
						isSuccess=false;
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
		
		  return isSuccess;
	}
	

//get latest messege
public static List<ContactUs> getLatestMessegeDetails() {
    ArrayList<ContactUs> contactDetails = new ArrayList<>();

    try {
        con = DBconnector.getConnection();
        String sql = "SELECT * FROM contact_messages ORDER BY submittedat DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String fname = rs.getString("fname");
            String lname = rs.getString("lname");
            String email = rs.getString("email");
            String mobile = rs.getString("mobile");
            String message = rs.getString("message");
            String submittedat = rs.getString("submittedat");

            ContactUs contact = new ContactUs(id, fname, lname, email, mobile, message, submittedat);
            contactDetails.add(contact);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return contactDetails;
}


//update message details
	public static boolean updateMessage(String Id, String fname, String lname, String email, String mobile, String message)
	{
		int convertedID=Integer.parseInt(Id);
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE contact_messages SET fname='" + fname + "', lname='" + lname + "', email='" + email +
		             "', mobile='" + mobile + "',  message='" +  message + 
		             "' WHERE id=" + convertedID;

			
			 int rs = stmt.executeUpdate(sql);

				if(rs>0) 
				{
					isSuccess= true;
				}
				else
				{
					isSuccess=false;
				}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public static boolean updateContactMessage(int id, String fname, String lname, String email, String mobile, String message) throws SQLException {
        String sql = "UPDATE contact_messages SET fname = ?, lname = ?, email = ?, mobile = ?, message = ? WHERE id = ?";
        
        try (Connection con = DBconnector.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, fname);
            pstmt.setString(2, lname);
            pstmt.setString(3, email);
            pstmt.setString(4, mobile);
            pstmt.setString(5, message);
            pstmt.setInt(6, id);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

    public static ContactUs getContactMessageById(int id) throws SQLException {
        String sql = "SELECT * FROM contact_messages WHERE id = ?";
        
        try (Connection con = DBconnector.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return new ContactUs(
                    rs.getInt("id"),
                    rs.getString("fname"),
                    rs.getString("lname"),
                    rs.getString("email"),
                    rs.getString("mobile"),
                    rs.getString("message"),
                    rs.getString("submittedat")
                );
            }
            return null;
        } catch (SQLException e) {
            throw e;
        }
    }
 
 
 //delete Payment
    public static boolean deleteContactMessage(int id) throws SQLException {
        String sql = "DELETE FROM contact_messages WHERE id = ?";
        
        try (Connection con = DBconnector.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw e;
        }
    }
	


}
