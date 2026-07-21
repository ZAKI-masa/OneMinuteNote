<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メモ詳細 - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; background-color: #f5f7fa; display: flex; flex-direction: column; align-items: center; padding: 40px 20px; }
    .paper { background: #ffffff; width: 100%; max-width: 800px; padding: 50px 60px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); box-sizing: border-box; }
    .title { font-size: 24px; font-weight: bold; border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 30px; }
    .content { font-size: 20px; line-height: 2.0; white-space: pre-wrap; color: #333; }
    .back-link { margin-top: 30px; display: inline-block; padding: 10px 20px; background-color: #7f8c8d; color: white; text-decoration: none; border-radius: 5px; }
</style>
</head>
<body>

<div class="paper">
    <div class="title">${memo.title}</div>
    <div class="content">${memo.content}</div>
    
    <a href="${pageContext.request.contextPath}/list-servlet" class="back-link">一覧へ戻る</a>
</div>

</body>
</html>