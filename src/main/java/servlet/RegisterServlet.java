package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.dao.UserDao;
import db.dto.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register-servlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		UserDao userDao = new UserDao();

		User user = (User) userDao.selectByUserName(username);

		User newUser = new User();
		newUser.setUserName(username);
		newUser.setPassword(password);

		if (user == null) {

			userDao.insert(newUser);
			HttpSession session = request.getSession();
			User registeredUser = userDao.selectByUserName(newUser.getUserName());
			session.setAttribute("loginUser", registeredUser);
			response.sendRedirect(request.getContextPath() + "/list-servlet");
		} else {
			request.setAttribute("errorMsg", "すでに存在しています。");
			request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
		}

	}

}
