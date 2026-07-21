package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.dao.MemoDao;
import db.dto.Memo;

/**
 * Servlet implementation class DetailServlet
 */
@WebServlet("/detail-servlet")
public class DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // URLにくっついてきたIDを受け取る
        int id = Integer.parseInt(request.getParameter("id"));
       
        MemoDao dao = new MemoDao();
        Memo memo = dao.selectById(id);
        System.out.println("受け取ったID: " + id);
        System.out.println("取得したメモのタイトル: " + (memo != null ? memo.getTitle() : "null（取れていません）"));
        
        request.setAttribute("memo", memo);
        request.getRequestDispatcher("/jsp/detail.jsp").forward(request, response);
    }


}
