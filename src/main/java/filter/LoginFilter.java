package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * ログインしていないアクセスをlogin-servletへリダイレクトするFilter
 * すべてのリクエストを対象にし、ログイン関連だけを除外する（ホワイトリスト方式）
 */
@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // contextPathを除いた、実際のパス部分だけを取り出す（例: /OneMinuteNote/login-servlet → /login-servlet）
        String path = request.getRequestURI().substring(request.getContextPath().length());

        // ログイン関連はチェック対象外（ここに含めないと無限リダイレクトループになる）
        boolean isExcluded = path.equals("/login-servlet")
                || path.equals("/logout-servlet")
                || path.equals("/jsp/login.jsp");

        if (isExcluded) {
            chain.doFilter(req, res);
            return;
        }

        // ログイン済みかどうかを確認
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("loginUser") != null);

        if (loggedIn) {
            // ログイン済みなら、そのまま本来のServlet/JSPへ処理を渡す
            chain.doFilter(req, res);
        } else {
            // 未ログインならログイン画面へ強制的に送る
            response.sendRedirect(request.getContextPath() + "/login-servlet");
        }
    }
}