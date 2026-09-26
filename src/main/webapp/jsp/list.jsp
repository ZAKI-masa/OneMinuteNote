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
    .memo-card { background: #fffdf7; border-radius: 3px; padding: 20px 20px 20px 40px; margin-bottom: 20px; box-shadow: 0 3px 8px rgba(0,0,0,0.08); display: flex; justify-content: space-between; align-items: center; position: relative; }
    .memo-card::before { content: ""; position: absolute; left: -20px; top: 12px; width: 45px; height: 80px; background: #e67e22; clip-path: polygon(0 0, 100% 0, 100% 100%, 50% 80%, 0 100%); }
    .memo-card::after { content: ""; position: absolute; left: -10px; top: 12px; width: 30px; height: 80px; border-left: 1px solid rgba(0,0,0,0.08); border-right: 1px solid rgba(0,0,0,0.08); pointer-events: none; }    
    .memo-info { flex: 1; overflow: hidden; margin-right: 20px; }

.book-container { position: relative; width: 100%; perspective: 1500px; min-height: 737px; border: 10px solid #5a0f18; box-shadow: inset 0 0 0 2px #8b2a35; }
.book-page { display: none; position: absolute; top: 0; left: 0; width: 100%; background: #fffdf7; padding: 0px 0 40px 0; transform-origin: left center; }
.book-page.active { display: block; }
.book-page.flipping { animation: pageFlip 0.9s ease-in-out forwards; z-index: 2; margin-left: 5px; }
.book-page.flipping-prev { animation: pageFlipPrev 0.8s ease-in-out forwards; transform-origin: right center; z-index: 2; margin-left: 0.3px; }
@keyframes pageFlipPrev { 0% { transform: rotateY(0deg); } 100% { transform: rotateY(180deg); } }
@keyframes pageFlip { 0% { transform: rotateY(0deg); } 100% { transform: rotateY(-180deg); } }
.page-corner { position: absolute; right: 0; bottom: 0; width: 80px; height: 80px; cursor: pointer; z-index: 10; background: linear-gradient(135deg, transparent 0%, transparent 49%, #d8d0c0 50%, #eee8dc 100%); transition: transform 0.2s ease; }
.page-corner::before { position: absolute; right: 0; bottom: 0; width: 80px; height: 80px; background: #fffdf7; clip-path: polygon(0 0, 100% 100%, 100% 0); box-shadow: -3px -3px 8px rgba(0,0,0,0.08); }
.page-corner::after { content: ""; position: absolute; right: 0; bottom: 0; width: 80px; height: 80px; border-right: 1px solid rgba(120,110,95,0.25); border-bottom: 1px solid rgba(120,110,95,0.25); }
.page-corner:hover { transform: scale(1.05); }
/* 左下のページめくり */
.page-corner-left{ position: absolute; bottom: 0; width: 80px; height: 80px; cursor: pointer; z-index: 10; background: linear-gradient(-135deg, transparent 0%, transparent 49%, #d8d0c0 50%, #eee8dc 100%); transition: transform 0.2s ease; }
.page-corner-left::after { content: ""; position: absolute; left: 0; bottom: 0; width: 80px; height: 80px; border-left: 1px solid rgba(120,110,95,0.25); border-bottom: 1px solid rgba(120,110,95,0.25); clip-path: polygon(0 100%, 100% 0, 0 0); }
.page-corner-left:hover { transform: scale(1.05); }
/* ページ番号 */
.page-number { text-align: center; color: #999; font-size: 13px; margin-top: 10px; }
/* ページめくりアニメーション */
.page-flip-next {
    animation: pageFlipNext 0.8s ease-in-out forwards;
}

.page-flip-prev {
    animation: pageFlipPrev 0.8s ease-in-out forwards;
}


@keyframes pageFlipNext {

    0% {
        transform: rotateY(180deg);
    }

    100% {
        transform: rotateY(0deg);
    }

}
    .title { font-size: 18px; font-weight: bold; color: #2c3e50; margin-bottom: 5px; }
    .preview { font-size: 14px; color: #7f8c8d; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .btn { padding: 8px 16px; font-size: 14px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; color: white; margin-left: 5px; }
    .btn-detail { background-color: #3498db; }
    .btn-delete { background-color: #e74c3c; }
    .header-link { display: inline-block; }
    .header-row { display: flex; justify-content: space-between; align-items: center; width: 100%; }
</style>
</head>
<body>
<script>

let currentPage = 0;
let isTurning = false;

function turnPage(direction) {

    const pages = document.querySelectorAll(".book-page");

    // アニメーション中は操作しない
    if (isTurning) {
        return;
    }

    // 1ページ目から戻ろうとした場合
    if (direction === -1 && currentPage <= 0) {
        return;
    }

    // 最終ページから進もうとした場合
    if (direction === 1 && currentPage >= pages.length - 1) {
        return;
    }

    isTurning = true;

    const current = pages[currentPage];
    const targetPage = currentPage + direction;
    const target = pages[targetPage];

    // =========================
    // 次のページへ
    // =========================
    if (direction === 1) {

    target.style.display = "block";
    target.classList.add("active");

    current.classList.add("flipping");

    setTimeout(function() {

        current.classList.remove("active");
        current.classList.remove("flipping");
        current.style.display = "none";

        currentPage = targetPage;
        isTurning = false;

    }, 900);
}

    // =========================
    // 前のページへ
    // =========================
else if (direction === -1) {

    target.style.display = "block";
    target.classList.add("active");

    current.classList.add("flipping-prev");

    setTimeout(function() {

        current.classList.remove("active");
        current.classList.remove("flipping-prev");
        current.style.display = "none";

        currentPage = targetPage;
        isTurning = false;

    }, 800);

}
}

</script>
<jsp:include page="/jsp/shared/header.jsp"/>
<div class="container">
    <div class="header-row">
    <h2>過去のメモ一覧</h2>
       <a href="<%= request.getContextPath() %>/jsp/index.jsp" class="header-link">＋ 新しいメモを書く</a>
    </div>

<% if (memoList != null && !memoList.isEmpty()) { %>

    <div class="book-container">

        <%
            int pageCount = (int) Math.ceil(memoList.size() / 6.0);
            int currentIndex = 0;

            for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
        %>

            <div class="book-page <%= pageIndex == 0 ? "active" : "" %>" data-page="<%= pageIndex %>">

                <%
                    for (int i = 0; i < 6 && currentIndex < memoList.size(); i++) {

                        Memo memo = memoList.get(currentIndex);
                        currentIndex++;
                %>

                    <div class="memo-card">
                    
                        <div class="memo-info">

                            <div class="title">
                                <c:out value="<%=memo.getTitle()%>"></c:out>
                            </div>

                            <div class="preview">
                                <c:out value="<%=memo.getContent()%>"></c:out>
                            </div>

                        </div>

                        <div>

                            <a href="<%= request.getContextPath() %>/detail-servlet?id=<%= memo.getId() %>"
                               class="btn btn-detail">詳細</a>

                            <a href="<%= request.getContextPath() %>/jsp/deleteConfirm.jsp?id=<%= memo.getId() %>"
                               class="btn btn-delete">削除</a>

                        </div>

                    </div>

                <% } %>


<% if (pageIndex > 0) { %>
    <div class="page-corner-left" onclick="turnPage(-1)"></div>
<% } %>

<% if (pageIndex < pageCount - 1) { %>
    <div class="page-corner" onclick="turnPage(1)"></div>
<% } %>


                <div class="page-number">
                    <%= pageIndex + 1 %> / <%= pageCount %>
                </div>

            </div>

        <% } %>

    </div>

<% } else { %>

    <p>保存されたメモはありません。</p>

<% } %>
</div>

</body>
</html>