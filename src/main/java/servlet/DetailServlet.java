package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.dao.MemoDao;
import db.dto.Memo;
import db.dto.User;

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
        
        // sessionからログインユーザー情報を受け取る
        HttpSession session = request.getSession(false);
    	User loginUser = (User)session.getAttribute("loginUser");
       
    	//idからmemoを受け取るsqlを実行
        MemoDao dao = new MemoDao();
        Memo memo = dao.selectById(id);
        System.out.println("受け取ったID: " + id);
        System.out.println("取得したメモのタイトル: " + (memo != null ? memo.getTitle() : "null（取れていません）"));
        
     // メモが存在しない、または他人のメモなら一覧へ追い返す
        if(memo == null || loginUser.getId() != memo.getUserId()) {
        	response.sendRedirect(request.getContextPath() + "/list-servlet");
        	return;
        }
        
        request.setAttribute("memo", memo);
        request.getRequestDispatcher("/jsp/detail.jsp").forward(request, response);
    }


}
