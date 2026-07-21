<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ゼロ秒思考メモ</title>
<style>
    /* 画面全体の背景 */
    body {
        font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
        background-color: #e9ecef;
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding-top: 30px;
    }

    /* 操作パネル */
    .controls-bar {
        display: flex;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        background: #fff;
        padding: 10px 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    select {
        padding: 8px 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 6px;
        outline: none;
        cursor: pointer;
    }
    button {
        padding: 8px 20px;
        font-size: 16px;
        background-color: #2c3e50;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
    }
    button:disabled {
        background-color: #bdc3c7;
        cursor: not-allowed;
    }
    
    /* 一覧へ飛ぶボタンの専用スタイル */
    .btn-list {
        background-color: #7f8c8d;
        text-decoration: none;
        padding: 8px 15px;
        font-size: 14px;
        border-radius: 6px;
        color: white;
        font-weight: bold;
    }

    .timer {
        font-size: 24px;
        font-weight: bold;
        color: #e74c3c;
        min-width: 120px;
        text-align: right;
    }

    /* A4用紙のUIデザイン */
    .paper {
        background: #ffffff;
        width: 100%;
        max-width: 800px;
        aspect-ratio: 1.414 / 1; 
        padding: 50px 60px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        box-sizing: border-box;
        position: relative;
    }

    .paper-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 40px;
    }
    .title-input {
        font-size: 22px;
        border: none;
        border-bottom: 1px dotted #999;
        width: 70%;
        outline: none;
        padding: 5px 0;
        background: transparent;
    }
    .title-input:focus {
        border-bottom: 1px solid #333;
    }
    .date-display {
        font-size: 18px;
        color: #555;
    }

    .line-row {
        display: flex;
        align-items: flex-start;
        margin-bottom: 18px;
        font-size: 20px;
    }
    .line-row span {
        margin-right: 8px;
        color: #333;
        user-select: none;
    }
    .line-input {
        flex: 1;
        font-size: 20px;
        border: none;
        outline: none;
        background: transparent;
        padding: 0;
        line-height: 1.5;
    }
    .line-input:focus {
        background-color: #f8f9fa;
    }

    /* 一括入力モード用のテキストエリア */
    .bulk-textarea {
        width: 100%;
        height: 260px;
        font-size: 20px;
        line-height: 1.5;
        border: none;
        outline: none;
        background: transparent;
        resize: none;
        font-family: inherit;
        box-sizing: border-box;
    }
    .bulk-textarea:focus {
        background-color: #f8f9fa;
    }
    .bulk-counter {
        text-align: right;
        font-size: 14px;
        color: #888;
    }
</style>
</head>
<body>

<!-- 操作パネル -->
<div class="controls-bar">
    <!-- ★ここに追加：一覧画面へのリンクボタン -->
    <a href="${pageContext.request.contextPath}/list-servlet" class="btn-list">過去のメモ一覧</a>
    
    <select id="timeSetting">
        <option value="120">2分</option>
        <option value="60" selected>1分</option>
        <option value="40">40秒</option>
    </select>
    <select id="modeSetting">
        <option value="line" selected>1行ずつ(30字で改行)</option>
        <option value="bulk">一括入力(200字)</option>
    </select>
    <button type="button" id="startBtn" onclick="startTimer()">スタート</button>
    <div class="timer">残り <span id="timeDisplay">60</span> 秒</div>
</div>

<!-- A4用紙エリア -->
<div class="paper">

    <form id="memoForm" action="${pageContext.request.contextPath}/save-servlet" method="POST">
        
        <div class="paper-header">
            <input type="text" id="title" name="title" class="title-input" placeholder="テーマを入力" required>
            <div class="date-display" id="todayDate"></div>
        </div>

        <div id="linesContainer">
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
            <div class="line-row">
                <span>ー</span>
                <input type="text" class="line-input" disabled maxlength="30">
            </div>
        </div>

        <div id="bulkContainer" style="display:none;">
            <textarea id="bulkInput" class="bulk-textarea" disabled maxlength="200" placeholder="ここに200字まで一気に書き込めます"></textarea>
            <div class="bulk-counter"><span id="bulkCount">0</span> / 200</div>
        </div>

        <input type="hidden" id="content" name="content">
    </form>
</div>

<script>
    const dateObj = new Date();
    const yyyy = dateObj.getFullYear();
    const mm = dateObj.getMonth() + 1;
    const dd = dateObj.getDate();
    document.getElementById('todayDate').textContent = yyyy + '-' + mm + '-' + dd;

    let timeLeft = 60;
    let timerId;
    let isComposing = false;

    const timeSetting = document.getElementById('timeSetting');
    const timeDisplay = document.getElementById('timeDisplay');
    const lineInputs = document.querySelectorAll('.line-input');

    const modeSetting = document.getElementById('modeSetting');
    const linesContainer = document.getElementById('linesContainer');
    const bulkContainer = document.getElementById('bulkContainer');
    const bulkInput = document.getElementById('bulkInput');
    const bulkCount = document.getElementById('bulkCount');

    timeSetting.addEventListener('change', function() {
        timeDisplay.textContent = this.value;
    });

    modeSetting.addEventListener('change', function() {
        if (this.value === 'bulk') {
            linesContainer.style.display = 'none';
            bulkContainer.style.display = 'block';
        } else {
            linesContainer.style.display = 'block';
            bulkContainer.style.display = 'none';
        }
    });

    bulkInput.addEventListener('input', function() {
        bulkCount.textContent = this.value.length;
    });

    lineInputs.forEach((input, index) => {
        input.addEventListener('compositionstart', () => { isComposing = true; });
        input.addEventListener('compositionend', function() {
            isComposing = false;
            checkAndMove(this, index);
        });
        input.addEventListener('input', function() {
            if (!isComposing) {
                checkAndMove(this, index);
            }
        });
    });

    function checkAndMove(element, index) {
        if (element.value.length >= 30) {
            const nextInput = lineInputs[index + 1];
            if (nextInput) {
                nextInput.focus();
            }
        }
    }

    function startTimer() {
        const titleInput = document.getElementById('title');
        const startBtn = document.getElementById('startBtn');
        const form = document.getElementById('memoForm');

        if (titleInput.value.trim() === "") {
            alert("タイトルを入力してください。");
            titleInput.focus();
            return;
        }

        timeLeft = parseInt(timeSetting.value, 10);
        timeDisplay.textContent = timeLeft;

        titleInput.readOnly = true;
        timeSetting.disabled = true;
        modeSetting.disabled = true;
        startBtn.disabled = true;

        const mode = modeSetting.value;

        if (mode === 'bulk') {
            bulkInput.disabled = false;
            bulkInput.focus();
        } else {
            lineInputs.forEach(input => input.disabled = false);
            lineInputs[0].focus();
        }

        timerId = setInterval(function() {
            timeLeft--; 
            timeDisplay.textContent = timeLeft; 

            if (timeLeft <= 0) {
                clearInterval(timerId); 
                if (mode === 'bulk') {
                    bulkInput.readOnly = true;
                } else {
                    lineInputs.forEach(input => input.readOnly = true);
                }
                
                combineContent(mode); 
                form.submit(); 
            }
        }, 1000);
    }

    function combineContent(mode) {
        const hiddenContent = document.getElementById('content');

        if (mode === 'bulk') {
            hiddenContent.value = bulkInput.value.trim();
            return;
        }

        let combinedText = "";
        
        lineInputs.forEach((input, index) => {
            if (input.value.trim() !== "") {
                combinedText += input.value;
                if (index < lineInputs.length - 1) {
                    combinedText += "\n";
                }
            }
        });
        
        hiddenContent.value = combinedText.replace(/\n+$/, "");
    }
</script>

</body>
</html>