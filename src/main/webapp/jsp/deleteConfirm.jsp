<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // URLの ?id=◯◯ からIDを受け取る
    int id;
	try{
		id = Integer.parseInt(request.getParameter("id"));
	} catch(NumberFormatException ex){
		response.sendRedirect(request.getContextPath() + "/list-servlet");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除確認 - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; background-color: #f5f7fa; display: flex; flex-direction: column; align-items: center; padding: 40px 20px; }
    .confirm-box { background: #fff; border-radius: 8px; padding: 30px; max-width: 400px; width: 100%; box-shadow: 0 2px 10px rgba(0,0,0,0.05); text-align: center; }
    .btn { padding: 10px 20px; font-size: 14px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin: 0 5px; font-weight: bold; }
    .btn-delete { background-color: #e74c3c; color: white; }
    .btn-cancel { background-color: #7f8c8d; color: white; }
    p { font-size: 16px; color: #2c3e50; margin-bottom: 25px; }
</style>
</head>
<body>

<div class="confirm-box">
    <h2>メモの削除</h2>
    <p>本当にこのメモを削除しますか？<br><small style="color:#95a5a6;">（この操作は取り消せません）</small></p>
    
    <!-- 最終的な削除を実行するフォーム（POST） -->
    <form action="<%= request.getContextPath() %>/delete-servlet" method="POST" style="display: inline;">
        <!-- 受け取ったIDをセットしてServletへ引き渡す -->
       	<input type="hidden" name = "id" value="<%=id%>"/>
        <button type="submit" class="btn btn-delete">削除する</button>
    </form>
    
    <!-- キャンセルして一覧に戻るリンク -->
    <a href="<%= request.getContextPath() %>/list-servlet" class="btn btn-cancel">キャンセル</a>
</div>

</body>
</html>