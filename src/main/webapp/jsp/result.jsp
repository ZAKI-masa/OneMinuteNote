<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>保存完了 - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; padding: 20px; }
    .memo-box { 
        border: 1px solid #ccc; 
        padding: 15px; 
        margin-bottom: 20px; 
        background-color: #f9f9f9; 
        max-width: 600px;
    }
    .content { white-space: pre-wrap; font-size: 16px; }
    .title { font-size: 20px; font-weight: bold; border-bottom: 1px solid #aaa; padding-bottom: 5px; }
</style>
</head>
<body>

<h2>保存しました（${todayCount}/10ページ完了）</h2>

<div class="memo-box">
    <div class="title">${savedMemo.title}</div>
    <div class="content">${savedMemo.content}</div>
</div>

<a href="${pageContext.request.contextPath}/jsp/index.jsp">
    <button type="button" style="padding: 10px 20px; font-size: 16px;">次のメモを書く</button>
</a>

</body>
</html>