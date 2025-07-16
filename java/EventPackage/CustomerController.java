package EventPackage;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;



public class CustomerController {
	
	//Connect DB
	private static boolean isSuccess;
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
	
	// Validate user
	public static List<User> validate(String username, String password) {
	    ArrayList<User> userDetails = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    try {
	        con = DBConnection.getConnection();
	        if (con == null) {
	            System.err.println("Database connection failed in validate");
	            return userDetails;
	        }
	        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, username);
	        ps.setString(2, password);
	        rs = ps.executeQuery(); // Added missing executeQuery()

	        if (rs.next()) {
	            int id = rs.getInt("id");
	            String name = rs.getString("username");
	            String email = rs.getString("email");
	            String address = rs.getString("address");
	            Date dob = rs.getDate("dob");
	            String gender = rs.getString("gender");
	            String membership = rs.getString("membership");
	            String passU = rs.getString("password");
	            boolean remember = rs.getBoolean("remember");
	            byte[] photo = rs.getBytes("photo");

	            User us = new User(id, name, email, address, dob, gender, membership, passU, remember, photo);
	            userDetails.add(us);
	        }
	    } catch (Exception e) {
	        System.err.println("Exception in validate for username " + username + ": " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return userDetails;
	}
    
 // Get user details
    public static List<User> getUserDetails(String username) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection for getUserDetails");
                return users;
            }
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                byte[] photo = rs.getBytes("photo");
                System.out.println("Retrieved photo length for " + username + ": " + (photo != null ? photo.length : 0));
                users.add(new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getDate("dob"),
                    rs.getString("gender"),
                    rs.getString("membership"),
                    rs.getString("password"),
                    rs.getBoolean("remember"),
                    photo
                ));
            }
        } catch (SQLException e) {
            System.err.println("SQLException in getUserDetails for username " + username + ": " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error in getUserDetails for username " + username + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return users;
    }
	
	//Insert Data Function
	public static boolean insertdata(String cusName, String cusEmail, String eventDate, int noOfParticipants, String eventColour, String venueType, String foodBeverage, String musicEntertainment, String decorations, String other) {
		
		boolean isSuccess = false;
		
		try {
			//DB Connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			
			//SQL QUERY
			String sql = "insert into customer values(0, '"+cusName+"', '"+cusEmail+"', '"+eventDate+"', '"+noOfParticipants+"', '"+eventColour+"', '"+venueType+"', '"+foodBeverage+"', '"+musicEntertainment+"', '"+decorations+"', '"+other+"')";
			
			int rs = stmt.executeUpdate(sql);
			if(rs > 0) {
				isSuccess = true;
			}
			else {
				isSuccess = false;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	//GetById Function
	public static List<CustomerModel> getById (String cusID){
		
		int convertedID = Integer.parseInt(cusID);
		
		ArrayList <CustomerModel> customer = new ArrayList<>();
		
		try {
			//DB Connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			
			//SQL Query
			String sql = "select * from customer where cusId='"+convertedID+"'";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				int cusId = rs.getInt(1);
				String cusName = rs.getString(2);
				String cusEmail = rs.getString(3);
				String eventDate = rs.getString(4);
				int noOfParticipants = rs.getInt(5);
				String eventColour = rs.getString(6);
				String venueType = rs.getString(7);
				String foodBeverage = rs.getString(8);
				String musicEntertainment = rs.getString(9);
				String decorations = rs.getString(10);
				String other = rs.getString(11);
				
				CustomerModel ck = new CustomerModel(cusId, cusName, cusEmail, eventDate, noOfParticipants, eventColour, venueType, foodBeverage, musicEntertainment, decorations, other);
				customer.add(ck);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return customer;
	}
	
	//GetAll Data Function
	public static List<CustomerModel> getAllCustomer(){
		
		ArrayList <CustomerModel> customers = new ArrayList<>();
		
		try {
			//DB Connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			
			//SQL Query
			String sql = "select * from customer";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				int cusId = rs.getInt(1);
				String cusName = rs.getString(2);
				String cusEmail = rs.getString(3);
				String eventDate = rs.getString(4);
				int noOfParticipants = rs.getInt(5);
				String eventColour = rs.getString(6);
				String venueType = rs.getString(7);
				String foodBeverage = rs.getString(8);
				String musicEntertainment = rs.getString(9);
				String decorations = rs.getString(10);
				String other = rs.getString(11);
				
				CustomerModel ck = new CustomerModel(cusId, cusName, cusEmail, eventDate, noOfParticipants, eventColour, venueType, foodBeverage, musicEntertainment, decorations, other);
				customers.add(ck);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return customers;
	}
	
	
	//Update Data Function
	public static boolean updatedata(String cusName, String cusEmail, String eventDate, int noOfParticipants, String eventColour, String venueType, String foodBeverage, String musicEntertainment, String decorations, String other, String cusId) {
				
		try {
			//DB Connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			
			//SQL Query
			String sql = "update customer set cusName = '"+cusName+"', "
											+ "cusEmail = '"+cusEmail+"', "
											+ "eventDate = '"+eventDate+"', "
											+ "noOfParticipants = '"+noOfParticipants+"', "
											+ "eventColour = '"+eventColour+"', "
											+ "venueType = '"+venueType+"', "
											+ "foodBeverage = '"+foodBeverage+"', "
											+ "musicEntertainment = '"+musicEntertainment+"', "
											+ "decorations = '"+decorations+"', "
											+ "other = '"+other+"'"
							+"where cusId = '"+cusId+"'";
			
			int rs = stmt.executeUpdate(sql);
			if(rs > 0) {
				isSuccess = true;
			}
			else {
				isSuccess = false;
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	//Delete Data Function
	public static boolean deletedata(String cusId) {
		
		int convID = Integer.parseInt(cusId);
		
		try {
			
			//DB Connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			
			//SQL Query
			String sql = "delete from customer where cusId = '"+convID+"'";
			
			int rs = stmt.executeUpdate(sql);
			if(rs > 0) {
				isSuccess = true;
			}
			else {
				isSuccess = false;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
}
