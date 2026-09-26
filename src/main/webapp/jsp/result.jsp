<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>保存完了 - ゼロ秒思考</title>
<style>
    body { font-family: sans-serif; padding: 20px; }
    .memo-box { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; background-color: #f9f9f9; max-width: 300px; }
    
    .content { white-space: pre-wrap; font-size: 16px; }
    .title { font-size: 20px; font-weight: bold; border-bottom: 1px solid #aaa; padding-bottom: 5px; }
    .background2-video { position: fixed; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; z-index: -1; }
    
</style>
</head>
<body>
<script>
function startBackgroundAnimation() {
    const video = document.getElementById("background2Video");

    video.currentTime = 0;
    video.play();
}
</script>
<video id="background2Video"
       class="background2-video"
       muted
       
       playsinline>
    <source src="${pageContext.request.contextPath}/videos/background2.mp4"
            type="video/mp4">
</video>

<jsp:include page="/jsp/shared/header.jsp"/>

<h2 style="">保存しました${todayCount}/10ページ完了</h2>
    <button type="button" padding: 13px 20px;" onclick="startBackgroundAnimation()">
    再生
</button>

<div class="memo-box">
    <div class="title"><c:out value="${savedMemo.title}"/></div>
    <div class="content"><c:out value="${savedMemo.content}"/></div>
</div>

<a href="${pageContext.request.contextPath}/jsp/index.jsp">
    <button type="button" style="padding: 10px 20px; font-size: 16px;">新規ノート</button>
</a>

</body>
</html>