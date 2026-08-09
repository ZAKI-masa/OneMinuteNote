package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.dto.DatabaseManager;
import db.dto.User;

public class UserDao {

	//id検索はsessionでidを使用することで、usernameの変更があってもシステム内部で安全にユーザー情報を保存できる。
	//ログイン処理後のシステム内部で扱う
	public User selectById(int id) {
		User user = null;
		String sql = "SELECT * FROM users WHERE id = ?";

		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					user = new User();
					user.setId(rs.getInt("id"));
					user.setUserName(rs.getString("username"));
					user.setPassword(rs.getString("password"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	//ログイン
	public User selectByUserName(String username) {
		
		User user = null;
		
		String sql = "SELECT * FROM users WHERE username = ?";
		
		try(Connection conn = DatabaseManager.createConnection();
				PreparedStatement ps = conn.prepareStatement(sql)){
			ps.setString(1, username);
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					user = new User();
					user.setId(rs.getInt("id"));
					user.setUserName(rs.getString("username"));
					user.setPassword(rs.getString("password"));
				}
			} 
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return user;
	}

	public void insert(User user) {

		String sql = "INSERT INTO users(username,password) values(?,?)";

		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, user.getUserName());
			ps.setString(2, user.getPassword());
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
