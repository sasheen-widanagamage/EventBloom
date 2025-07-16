package EventPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private static String url ="jdbc:mysql://localhost:3306/eventbloom";
	private static String user = "root";
	private static String pass= "Chamo@@2003";
	
	private static Connection con;
	
	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pass);
			
		}
		catch(ClassNotFoundException e) {
			throw new SQLException("MySQL JDBC Driver not found: " + e.getMessage(), e);
		}catch(SQLException e) {
			throw new SQLException("Failed to connect to database: " + e.getMessage(), e);
		}
		return con;
	}
	
}
