package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.dto.DatabaseManager;
import db.dto.Memo;

public class MemoDao {

	// データベース接続URLはDatabaseManager側で管理するため、ここからは削除します

	/**
	 * 新規保存
	 */
	public void insert(Memo memo) {
		String sql = "INSERT INTO memo (title, content,user_id, created_at) VALUES (?, ?,?, CURRENT_TIMESTAMP)";

		// DriverManagerではなく、DatabaseManagerから接続(Connection)をもらう
		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, memo.getTitle());
			pstmt.setString(2, memo.getContent());
			pstmt.setInt(3, memo.getUserId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**a
	 * 全件取得（過去のメモ一覧用）
	 * @return 
	 */
	public List<Memo> selectAllByUserId(int userId) {
	    List<Memo> memoList = new ArrayList<>();
	    String sql = "SELECT * FROM memo WHERE user_id = ?";

	    try (Connection conn = DatabaseManager.createConnection();
	            PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, userId);   // ← 先にセット

	        try (ResultSet rs = pstmt.executeQuery()) {   // ← その後に実行
	            while (rs.next()) {
	                Memo memo = new Memo();
	                memo.setId(rs.getInt("id"));
	                memo.setTitle(rs.getString("title"));
	                memo.setContent(rs.getString("content"));
	                memo.setUserId(rs.getInt("user_id"));
	                memoList.add(memo);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return memoList;
	}

	/**
	 * 今日のメモの作成枚数をカウントする
	 */
	public int countTodayMemos() {
		int count = 0;
		// SQLiteの関数 date() を使って、今日の日付と一致するものをカウントします
		String sql = "SELECT COUNT(*) AS cnt FROM memo WHERE date(created_at) = date('now', 'localtime')";

		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public Memo selectById(int id) {
		Memo memo = null;
		String sql = "SELECT * FROM memo WHERE id = ?";

		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					memo = new Memo();
					memo.setId(rs.getInt("id"));
					memo.setTitle(rs.getString("title"));
					memo.setContent(rs.getString("content"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memo;
	}

	/**
	 * IDを指定して削除
	 */
	public void delete(int id) {
		String sql = "DELETE FROM memo WHERE id = ?";

		try (Connection conn = DatabaseManager.createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}