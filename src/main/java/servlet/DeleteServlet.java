package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.dao.MemoDao;

@WebServlet("/delete-servlet")
public class DeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 削除するIDを受け取る
        int id = Integer.parseInt(request.getParameter("id"));
        
        MemoDao dao = new MemoDao();
        dao.delete(id);
        
        // 削除が終わったら、ListServlet（一覧画面）へ強制リダイレクト
        response.sendRedirect(request.getContextPath() + "/list-servlet");
    }
}