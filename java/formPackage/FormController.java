package formPackage;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class FormController {
	       //DB connect
	
			private static boolean isSuccess; 
			private static Connection con = null;
			private static Statement stmt = null;
			private static ResultSet cs = null;
			private static ResultSet rs;
			
			
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
		    
		    
			//data insert
			
			  public static boolean insertdata(String name, String email, String phone, String ePackage, String ePlanner, String eDate,String eLocation, int numberOfGuests, String specialRequirements) {
						
						boolean isSuccess = false;
						
						try {
							
							con = DBConnection.getConnection();
							stmt =con.createStatement();
							String sql = "insert into booking values(0,'"+name+"','"+email+"','"+phone+"','"+ePackage+"','"+ePlanner+"','"+eDate+"','"+eLocation+"','"+numberOfGuests+"','"+specialRequirements+"')";
							int rs=stmt.executeUpdate(sql);
							if(rs > 0) {
								isSuccess = true;
								
							}else{
								
								isSuccess =  false;
							}
							
						}catch(Exception e){
							
							e.printStackTrace();
							
						}
						
						return isSuccess;
						
					}
			  
			  
			//Get by id
				public static List<FormModel>getById(String Id){
					
					int convertedID = Integer.parseInt(Id);
					ArrayList<FormModel>form = new ArrayList<>(); 
					
					try {
						//DB connect
						con = DBConnection.getConnection();
						stmt =con.createStatement();
						
						//Query
						String sql = "select * from booking where id = '"+convertedID+"'";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							
							 int id = rs.getInt(1);
						     String name = rs.getString(2);
						     String email = rs.getString(3);
						     String phone = rs.getString(4);
						     String ePackage = rs.getString(5);
						     String ePlanner = rs.getString(6);
						     String eDate = rs.getString(7);
						     String eLocation = rs.getString(8);
						     int numberOfGuests = rs.getInt(9);
						     String specialRequirements = rs.getString(10);
							
							 FormModel mk = new FormModel(id,name, email, phone, ePackage, ePlanner, eDate, eLocation, numberOfGuests, specialRequirements);
							 form.add(mk);
						}
						
						
					}catch(Exception e) {
						
						e.printStackTrace();
					}
					return form;
					
				}
			
			//GetALL data
				
				
				public static List<FormModel>getAllForm(){
					
					
					ArrayList<FormModel>forms = new ArrayList<>();
					try {
						//DB connect
						con = DBConnection.getConnection();
						stmt =con.createStatement();
						
						//Query
						String sql = "select * from booking";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							
							 int id = rs.getInt(1);
						     String name = rs.getString(2);
						     String email = rs.getString(3);
						     String phone = rs.getString(4);
						     String ePackage = rs.getString(5);
						     String ePlanner = rs.getString(6);
						     String eDate = rs.getString(7);
						     String eLocation = rs.getString(8);
						     int numberOfGuests = rs.getInt(9);
						     String specialRequirements = rs.getString(10);
							
							 FormModel mk = new FormModel(id,name, email, phone, ePackage, ePlanner, eDate, eLocation, numberOfGuests, specialRequirements);
							 forms.add(mk);
						}
						
						
					}catch(Exception e) {
						
						e.printStackTrace();
					}
					return forms;
					
					
				}
				
				//Update data
				
				public static boolean updatedataForm(String id,String name, String email, String phone, String ePackage, String ePlanner, String eDate,String eLocation, int numberOfGuests, String specialRequirements) {
					try {
						//DB connect
						con = DBConnection.getConnection();
						stmt =con.createStatement();
						
						//Query
						String sql = "update booking set name='" + name + "', email='" + email + "', phone='" + phone + "', ePackage='" + ePackage + "', ePlanner='" + ePlanner + "', eDate='" + eDate + "', eLocation='" + eLocation + "', numberOfGuests='" + numberOfGuests + "', specialRequirements='" + specialRequirements + "' where id='" + id + "'";
					
						int rs=stmt.executeUpdate(sql);
						if(rs > 0) {
							isSuccess = true;
							
						}else{
							
							isSuccess =  false;
						}
						
						
					}catch(Exception e) {
						
						e.printStackTrace();
					}
					return isSuccess;
					
				}
			
				//Delete data
				
				
				public static boolean deletedataform(String id) {
					
					int convID = Integer.parseInt(id);
					try {
						
						con = DBConnection.getConnection();
						stmt =con.createStatement();
						
						
						String sql = "delete from booking where id = '"+convID+"'";
						
						int rs=stmt.executeUpdate(sql);
						if(rs > 0) {
							isSuccess = true;
							
						}else{
							
							isSuccess =  false;
						}
					
					}catch(Exception e) {
						
						e.printStackTrace();
					}
					return isSuccess;
					
				}

			
}
