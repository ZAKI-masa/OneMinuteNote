package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.dao.MemoDao;
import db.dto.Memo;

@WebServlet("/list-servlet")
public class ListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MemoDao dao = new MemoDao();
        // 全件取得
        List<Memo> memoList = dao.selectAll();
        
        // JSPにリストを渡してフォワード
        request.setAttribute("memoList", memoList);
        request.getRequestDispatcher("/jsp/list.jsp").forward(request, response);
    }
}