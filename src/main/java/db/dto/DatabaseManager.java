package db.dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

public class DatabaseManager {
	
	private static final String DRIVER = "org.sqlite.JDBC";

	private static final String URL = "jdbc:sqlite:/Volumes/Macintosh HD/Users/Shared/One.db";
	
	
	
	public static Connection createConnection() throws ClassNotFoundException, SQLException {
        // JDBCドライバクラスをJVMに登録
        Class.forName(DRIVER);
        // データベースに接続
        Connection  conn = DriverManager.getConnection(URL);
        System.out.println("Connected to database.");
        return conn;
    }
	
	public static void destroy(Connection conn) {
		if(Objects.nonNull(conn)) {
			try {
				conn.close();
				
				System.out.println("Disconnected from database.");
			} catch(SQLException ex) {
				ex.printStackTrace();
			} 
		}
	}
	
	public static void destroy(PreparedStatement ps) {
        if (Objects.nonNull(ps)) {
            try {
                ps.close();
                System.out.println("Destroyed prepared statement.");
                
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
	
	public static void destroy(ResultSet rs) {
        if (Objects.nonNull(rs)) {
            try {
                rs.close();
                System.out.println("Destroyed result set.");
                
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

}
