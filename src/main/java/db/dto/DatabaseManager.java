package db.dto;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import java.util.Properties;

public class DatabaseManager {

	private static final String DRIVER = "org.sqlite.JDBC";

	// URLはコードに直接書かず、db.propertiesから読み込む
	private static final String URL;

	// クラスが最初に使われるタイミングで、一度だけdb.propertiesを読み込む
	static {
		Properties props = new Properties();
		try (InputStream input = DatabaseManager.class.getClassLoader()
				.getResourceAsStream("db.properties")) {

			if (input == null) {
				throw new RuntimeException("db.propertiesが見つかりません。src/main/resourcesに配置してください。");
			}
			props.load(input);

		} catch (IOException e) {
			throw new RuntimeException("db.propertiesの読み込みに失敗しました。", e);
		}

		URL = props.getProperty("db.url");
	}

	public static Connection createConnection() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        Connection conn = DriverManager.getConnection(URL);
        System.out.println("Connected to database.");
        return conn;
    }

	public static void destroy(Connection conn) {
		if (Objects.nonNull(conn)) {
			try {
				conn.close();
				System.out.println("Disconnected from database.");
			} catch (SQLException ex) {
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