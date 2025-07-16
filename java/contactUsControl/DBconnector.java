package contactUsControl;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnector{
	
	private static String url ="jdbc:mysql://localhost:3306/eventbloom";
	private static String user = "root";
	private static String pass= "Chamo@@2003";
	private static Connection con;
	
	public static Connection getConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			con = DriverManager.getConnection(url, user, pass);
		}
		catch(Exception e)
		{
			System.out.println("Database connection is not success!");
		}
		
		return con;
	}

}
