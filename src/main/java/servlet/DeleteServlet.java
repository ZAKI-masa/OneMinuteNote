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

@WebServlet("/delete-servlet")
public class DeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 削除するIDを受け取る
        int id = Integer.parseInt(request.getParameter("id"));
        
        //ログインユーザー情報受け取る
        HttpSession session = request.getSession(false);
        User loginUser = (User)session.getAttribute("loginUser");
        

        MemoDao dao = new MemoDao();
        Memo memo = dao.selectById(id);
        
        
        
        //メモが存在しないまたは、userIdが異なればlist-servletにリダイレクト
        if(memo == null || loginUser.getId() != memo.getUserId()) {
        	response.sendRedirect(request.getContextPath() + "/list-servlet");
            return;
        }
        	
        	
        dao.delete(id);
        
        // 削除が終わったら、ListServlet（一覧画面）へ強制リダイレクト
        response.sendRedirect(request.getContextPath() + "/list-servlet");
    }
}