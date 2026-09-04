package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.dao.MemoDao;
import db.dto.Memo;
import db.dto.User;

@WebServlet("/list-servlet")
public class ListServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//sessionからuserIdを取得
		HttpSession session = request.getSession(false);
		User loginUser = (User)session.getAttribute("loginUser");
		int userId = loginUser.getId();
		MemoDao memodao = new MemoDao();
		// userの全件レコード取得
		List<Memo> memoList = memodao.selectAllByUserId(userId);

		// JSPにリストを渡してフォワード
		request.setAttribute("memoList", memoList);
		request.getRequestDispatcher("/jsp/list.jsp").forward(request, response);
	}
}