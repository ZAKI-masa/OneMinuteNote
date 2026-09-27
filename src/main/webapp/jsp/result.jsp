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
    .save-screen { display: block; }
    .save-panel { background: rgba(128,128,128,0.75); border: 2px solid #666; border-radius: 10px; padding: 20px; }
    .save-controls { margin-bottom: 20px; }
    .new-note { display: inline-block; }
    .content { white-space: pre-wrap; font-size: 16px; }
    .title { font-size: 20px; font-weight: bold; border-bottom: 1px solid #aaa; padding-bottom: 5px; }
    .background2-video { position: fixed; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; z-index: -1; }
    
</style>
</head>
<body>
<script>
function startBackgroundAnimation() {

    const saveScreen = document.getElementById("saveScreen");
    const video = document.getElementById("background2Video");

    saveScreen.style.display = "none";

    video.currentTime = 0;
    video.play();

    video.onended = function() {

        setTimeout(function() {

            saveScreen.style.display = "block";

        }, 3000);

    };

}
</script>
<video id="background2Video"
       class="background2-video"
       muted
       
       playsinline>
    <source src="${pageContext.request.contextPath}/videos/background2.mp4"
            type="video/mp4">
</video>

<div id="saveScreen">

    <div class="save-panel">

        <jsp:include page="/jsp/shared/header.jsp"/>

        <h2>保存しました${todayCount}/10ページ完了</h2>

        <div class="memo-box">

            <div class="title">
                <c:out value="${savedMemo.title}"/>
            </div>

            <div class="content">
                <c:out value="${savedMemo.content}"/>
            </div>

        </div>

        <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="new-note">
            <button type="button" style="padding: 10px 20px; font-size: 16px;">新規ノート</button>
        </a>

    </div>

    <div class="save-controls">

        <button type="button" style="padding: 10px 20px;" onclick="startBackgroundAnimation()">
            再生
        </button>

    </div>

</div>

</body>
</html>