package db.dto;

public class User {
    private int id;
    private String username;
    private String password;
    // getter/setterはMemoと同じ形
    
    public User() {}
    
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return username;
	}

	public void setUserName(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
}
