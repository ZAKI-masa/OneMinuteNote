<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="db.dto.Memo" %>
<% 
    // Servletから渡されたリストを受け取る
    List<Memo> memoList = (List<Memo>) request.getAttribute("memoList"); 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メモ一覧 - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; background-color: #f5f7fa; display: flex; flex-direction: column; align-items: center; padding: 40px 20px; margin: 0; }
    .container { width: 100%; max-width: 700px; }
    .memo-card { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; }
    .memo-info { flex: 1; overflow: hidden; margin-right: 20px; }
    .title { font-size: 18px; font-weight: bold; color: #2c3e50; margin-bottom: 5px; }
    .preview { font-size: 14px; color: #7f8c8d; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .btn { padding: 8px 16px; font-size: 14px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; color: white; margin-left: 5px; }
    .btn-detail { background-color: #3498db; }
    .btn-delete { background-color: #e74c3c; }
    .header-link { margin-bottom: 20px; display: inline-block; }
</style>
</head>
<body>

<div class="container">
    <h2>過去のメモ一覧</h2>
    <a href="<%= request.getContextPath() %>/jsp/index.jsp" class="header-link">＋ 新しいメモを書く</a>

    <% if (memoList != null && !memoList.isEmpty()) { %>
        <% for (Memo memo : memoList) { %>
            <div class="memo-card">
                <div class="memo-info">
                    <div class="title"><c:out value="<%=memo.getTitle()%>"></c:out></div>
                    <!-- 本文のプレビュー表示 -->
                    <div class="preview"><c:out value="<%=memo.getContent() %>"></c:out></div>
                </div>
                <div>
                    <a href="<%= request.getContextPath() %>/detail-servlet?id=<%= memo.getId() %>" class="btn btn-detail">詳細</a>
					<a href="<%= request.getContextPath() %>/jsp/deleteConfirm.jsp?id=<%= memo.getId() %>" class="btn btn-delete">削除</a>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <p>保存されたメモはありません。</p>
    <% } %>
</div>

</body>
</html>