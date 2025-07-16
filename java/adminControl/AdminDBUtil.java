package adminControl;

import java.lang.System.Logger;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;

import adminControl.DBconnector;
import loginControl.User;

public class AdminDBUtil {
	
	private static boolean isSuccess;
	private static Connection con=null;
	private static Statement stmt =null;
	private static ResultSet rs =null;
	
	
	// Validate Admin
		public static List<Admin> validate(String username, String password) {
			ArrayList<Admin> userDetails = new ArrayList<>();
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				con = DBconnector.getConnection();
				String sql = "SELECT * FROM adminEventBloom WHERE username = ? AND password = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);
				rs = ps.executeQuery();

				if (rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("username");
					String email = rs.getString("email");
					String address = rs.getString("address");
					String passU = rs.getString("password");

					Admin us = new Admin(id, name, email, address, passU);
					userDetails.add(us);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try { if (rs != null) rs.close(); } catch (Exception e) {}
				try { if (ps != null) ps.close(); } catch (Exception e) {}
				try { if (con != null) con.close(); } catch (Exception e) {}
			}
			return userDetails;
		}
		
		// Get admin details
		public static List<Admin> getAdminDetails(String username) {
			ArrayList<Admin> userDetails = new ArrayList<>();
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				con = DBconnector.getConnection();
				String sql = "SELECT * FROM adminEventBloom WHERE username = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, username);
				rs = ps.executeQuery();

				while (rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("username");
					String email = rs.getString("email");
					String address = rs.getString("address");
					String passU = rs.getString("password");

					Admin us = new Admin(id, name, email, address, passU);
					userDetails.add(us);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try { if (rs != null) rs.close(); } catch (Exception e) {}
				try { if (ps != null) ps.close(); } catch (Exception e) {}
				try { if (con != null) con.close(); } catch (Exception e) {}
			}
			return userDetails;
		}
	
	//register Event Moderator
	public static boolean registerModerator(String name, String nic, String phone, String email, String address, String district,
	        String province, String birthday, String gender, String password) {

	    boolean isSuccess = false;

	    try {
	        con = DBconnector.getConnection();
	        String sql = "INSERT INTO eventModerator (name,nic,phone,email,address,district,province,birthday,gender,password) " +
	                     "VALUES (?,?,?,?,?,?,?,?,?,?)";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, name);
	        ps.setString(2, nic);
	        ps.setString(3, phone);
	        ps.setString(4, email);     // was skipped before
	        ps.setString(5, address);
	        ps.setString(6, district);
	        ps.setString(7, province);
	        ps.setDate(8, java.sql.Date.valueOf(birthday));
	        ps.setString(9, gender);
	        ps.setString(10, password);

	        int result = ps.executeUpdate();

	        if(result > 0) {
	            isSuccess = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return isSuccess;
	}
	
	//register Event Planner
	public static boolean registerPlanner(String name, String nic, String phone, String email, String address, String district,
				String province, String birthday, String gender, String password, String specialization) {

		    boolean isSuccess = false;

		    try {
		        con = DBconnector.getConnection();
		        String sql = "INSERT INTO eventPlanner (name,nic,phone,email,address,district,province,birthday,gender,password,specialization) " +
		                     "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		        PreparedStatement ps = con.prepareStatement(sql);
		        ps.setString(1, name);
		        ps.setString(2, nic);
		        ps.setString(3, phone);
		        ps.setString(4, email);     // was skipped before
		        ps.setString(5, address);
		        ps.setString(6, district);
		        ps.setString(7, province);
		        ps.setDate(8, java.sql.Date.valueOf(birthday));
		        ps.setString(9, gender);
		        ps.setString(10, password);
		        ps.setString(11, specialization);
		        

		        int result = ps.executeUpdate();

		        if(result > 0) {
		            isSuccess = true;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return isSuccess;
		}
	

//get planner details by id

public static List<EventPlanner> getPlannerById(String Id){
	   
	   int convertedID=Integer.parseInt(Id);
		
	   ArrayList<EventPlanner> plannerDetails = new ArrayList<>();
	
		
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="select * from eventPlanner where id='"+convertedID+"'";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String nic = rs.getString("nic");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String district = rs.getString("district");
				String province = rs.getString("province");
				Date birthday = rs.getDate("birthday");
				String gender = rs.getString("gender");
				String specialization = rs.getString("specialization");
				String password= rs.getString("password");
			  
			    
				EventPlanner planner =new EventPlanner(id,name,nic,phone,email,address,district,province,birthday,gender,password,specialization);
				plannerDetails.add(planner);
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return plannerDetails;
		
	}
	   
	
//get all planner details

public static List<EventPlanner> getAllPlanner(){
		
	   ArrayList<EventPlanner> allPlanner= new ArrayList<>();
			
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="select * from eventPlanner";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
			    
			    int id = rs.getInt("id");
				String name = rs.getString("name");
				String nic = rs.getString("nic");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String district = rs.getString("district");
				String province = rs.getString("province");
				Date birthday = rs.getDate("birthday");
				String gender = rs.getString("gender");
				String specialization = rs.getString("specialization");
				String password= rs.getString("password");
			  
			    
				EventPlanner planner =new EventPlanner(id,name,nic,phone,email,address,district,province,birthday,gender,password,specialization);
				allPlanner.add(planner);
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return allPlanner;
		
	}	
	

//get Moderator details by id

public static List<EventModerator> getModeratorById(String Id){
	   
	   int convertedID=Integer.parseInt(Id);
		
	   ArrayList<EventModerator> moderatorDetails = new ArrayList<>();
	
		
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="select * from eventModerator where id='"+convertedID+"'";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String nic = rs.getString("nic");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String district = rs.getString("district");
				String province = rs.getString("province");
				Date birthday = rs.getDate("birthday");
				String gender = rs.getString("gender");
				String password= rs.getString("password");
			  
			    
				EventModerator moderator =new EventModerator(id, name, nic,  phone, email, address, district, province, birthday, gender, password);
				moderatorDetails.add(moderator);
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return moderatorDetails;
		
	}


//get all Moderator details

public static List<EventModerator> getAllModerator(){
		
	   ArrayList<EventModerator> allModerator= new ArrayList<>();
			
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="select * from eventModerator";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
			    
			    int id = rs.getInt("id");
				String name = rs.getString("name");
				String nic = rs.getString("nic");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String district = rs.getString("district");
				String province = rs.getString("province");
				Date birthday = rs.getDate("birthday");
				String gender = rs.getString("gender");
				String password= rs.getString("password");
			  
			    
				EventModerator moderator =new EventModerator(id, name, nic,  phone, email, address, district, province, birthday, gender, password);
				allModerator.add(moderator);
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return allModerator;
		
	}	


//update planner details
public static boolean updatePlanner(String id, String name, String nic, String phone, String email, String address, String district,
		String province, String birthday, String gender, String password, String specialization)
{
	
	try 
	{
		con = DBconnector.getConnection();
		stmt = con.createStatement();
		
		String sql="UPDATE eventPlanner SET name='"+name+"', email='"+email+"', address='"+address+"', birthday='"+birthday+"', gender='"+gender+"', nic='"+nic+"', password='"+password+"', phone='"+phone+"', district='"+district+"', province='"+province+"', specialization='"+specialization+"' WHERE id='"+id+"'";
				
		int rs = stmt.executeUpdate(sql);
		
		if(rs > 0) {
            isSuccess = true;
        }
		else
		{
			isSuccess = false;
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	return isSuccess;
}


//update Moderator details
public static boolean updateModerator(String id, String name, String nic, String phone, String email, String address, String district,
		String province, String birthday, String gender, String password)
{
	
	try 
	{
		con = DBconnector.getConnection();
		stmt = con.createStatement();
		
		String sql="UPDATE eventModerator SET name='"+name+"', email='"+email+"', address='"+address+"', birthday='"+birthday+"', gender='"+gender+"', nic='"+nic+"', password='"+password+"', phone='"+phone+"', district='"+district+"', province='"+province+"' WHERE id='"+id+"'";
				
		int rs = stmt.executeUpdate(sql);
		
		if(rs > 0) {
          isSuccess = true;
      }
		else
		{
			isSuccess = false;
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	return isSuccess;
}


//delete event Planner
public static boolean deletePlanner(String Id){
	   
	   int convID=Integer.parseInt(Id);
		
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="delete from eventPlanner where id='"+convID+"'";
			int rs = stmt.executeUpdate(sql);
			if(rs > 0) {
		          isSuccess = true;
		      }
				else
				{
					isSuccess = false;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
			return isSuccess;
	}


//delete event Moderator
public static boolean deleteModerator(String Id){
	   
	   int convID=Integer.parseInt(Id);
		
		try {
			con = DBconnector.getConnection();
			stmt = con.createStatement();
			String sql="delete from eventModerator where id='"+convID+"'";
			int rs = stmt.executeUpdate(sql);
			if(rs > 0) {
		          isSuccess = true;
		      }
				else
				{
					isSuccess = false;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
			return isSuccess;
	}

//Display all staff details (Planners and Moderators)
	public static List<Staff> displayStaffDetails() {
	    ArrayList<Staff> staffDetails = new ArrayList<>();
	    try {
	        con = DBconnector.getConnection();
	        stmt = con.createStatement();
	
	        // Fetch Event Planners
	        String plannerSql = "SELECT * FROM eventPlanner";
	        rs = stmt.executeQuery(plannerSql);
	        while (rs.next()) {
	            int id = rs.getInt("id");
	            String name = rs.getString("name");
	            String nic = rs.getString("nic");
	            String phone = rs.getString("phone");
	            String email = rs.getString("email");
	            String address = rs.getString("address");
	            String district = rs.getString("district");
	            String province = rs.getString("province");
	            Date birthday = rs.getDate("birthday");
	            String gender = rs.getString("gender");
	            String password = rs.getString("password");
	            String specialization = rs.getString("specialization");
	            EventPlanner planner = new EventPlanner(id, name, nic, phone, email, address, district, province, birthday, gender, password, specialization);
	            staffDetails.add(planner);
	        }
	
	        // Fetch Event Moderators
	        String moderatorSql = "SELECT * FROM eventModerator";
	        rs = stmt.executeQuery(moderatorSql);
	        while (rs.next()) {
	            int id = rs.getInt("id");
	            String name = rs.getString("name");
	            String nic = rs.getString("nic");
	            String phone = rs.getString("phone");
	            String email = rs.getString("email");
	            String address = rs.getString("address");
	            String district = rs.getString("district");
	            String province = rs.getString("province");
	            Date birthday = rs.getDate("birthday");
	            String gender = rs.getString("gender");
	            String password = rs.getString("password");
	            EventModerator moderator = new EventModerator(id, name, nic, phone, email, address, district, province, birthday, gender, password);
	            staffDetails.add(moderator);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return staffDetails;
	}


	// Display all user details
    public static List<User> displayUserDetails() {
        ArrayList<User> userDetails = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            stmt = con.createStatement();
            String sql = "SELECT id, username, email, address, dob, gender, membership, password, remember FROM users";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String address = rs.getString("address");
                Date dob = rs.getDate("dob");
                String gender = rs.getString("gender");
                String membership = rs.getString("membership");
                String password = rs.getString("password");
                boolean remember = rs.getBoolean("remember");
                User user = new User(id, username, email, address, dob, gender, membership, password, remember);
                userDetails.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return userDetails;
    }
}