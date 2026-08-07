<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; background-color: #f5f7fa; display: flex; flex-direction: column; align-items: center; padding: 40px 20px; }
    .login-box { background: #fff; border-radius: 8px; padding: 30px; max-width: 400px; width: 100%; box-shadow: 0 2px 10px rgba(0,0,0,0.05); text-align: center; }
    .login-box label { display: block; text-align: left; margin: 15px 0 5px; font-size: 14px; color: #2c3e50; }
    .login-box input[type="text"], .login-box input[type="password"] {
        width: 100%; padding: 10px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;
    }
    .btn { padding: 10px 20px; font-size: 14px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin-top: 20px; font-weight: bold; width: 100%; }
    .btn-login { background-color: #3498db; color: white; }
    .error-msg { color: #e74c3c; font-size: 14px; margin-top: 10px; }
    p { font-size: 16px; color: #2c3e50; }
</style>
</head>
<body>

<jsp:include page="/jsp/shared/header.jsp"/>
<div class="login-box">
    <h2>ログイン</h2>

    <!-- ログイン失敗時にServletからセットされたエラーメッセージを表示 -->
    <c:if test="${not empty errorMsg}">
        <p class="error-msg"><c:out value="${errorMsg}"/></p>
    </c:if>

    <!-- ログインフォーム（POST） -->
    <form action="<%= request.getContextPath() %>/login-servlet" method="post">
        <label for="username">ユーザー名：</label>
        <input type="text" id="username" name="username" required>

        <label for="password">パスワード：</label>
        <input type="password" id="password" name="password" required>

        <button type="submit" class="btn btn-login">ログイン</button>
    </form>
</div>

</body>
</html>
