<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .app-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #2c3e50;
        color: #fff;
        padding: 10px 20px;
        font-family: sans-serif;
        margin-bottom: 20px;
    }
    .app-header a { color: #fff; text-decoration: none; }
    .app-header .app-title { font-weight: bold; font-size: 16px; }
    .app-header .user-area { display: flex; align-items: center; gap: 12px; font-size: 14px; }
    .app-header .logout-btn {
        background: #e74c3c; border: none; color: #fff; padding: 6px 14px;
        border-radius: 4px; cursor: pointer; font-size: 13px;
    }
    .app-header .login-link {
        background: #3498db; padding: 6px 14px; border-radius: 4px; font-size: 13px;
    }
</style>

<div class="app-header">
    <a href="${pageContext.request.contextPath}/list-servlet" class="app-title">ゼロ秒思考メモ</a>

    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <div class="user-area">
                <span>ようこそ、<c:out value="${sessionScope.loginUser.userName}"/>さん</span>
                <form action="${pageContext.request.contextPath}/logout-servlet" method="post" style="margin:0;">
                    <button type="submit" class="logout-btn">ログアウト</button>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login-servlet" class="login-link">ログイン</a>
        </c:otherwise>
    </c:choose>
</div>
