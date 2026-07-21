package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.dao.MemoDao;
import db.dto.Memo;

/**
 * Servlet implementation class SaveServlet
 */
@WebServlet("/save-servlet")
public class SaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Memo memo = new Memo();
        memo.setTitle(title);
        memo.setContent(content);

        MemoDao dao = new MemoDao();
        dao.insert(memo);
        
        int todayCount = dao.countTodayMemos();
        request.setAttribute("todayCount", todayCount);

        request.setAttribute("savedMemo", memo);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/result.jsp");
        dispatcher.forward(request, response);
	}

}
