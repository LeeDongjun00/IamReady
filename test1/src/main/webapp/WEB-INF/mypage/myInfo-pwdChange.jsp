<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="/css/main-style.css">
    <link rel="stylesheet" href="/css/common-style.css">
    <link rel="stylesheet" href="/css/header-style.css">
    <link rel="stylesheet" href="/css/main-images.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans KR', sans-serif;
            background: #f8fafc;
        }

        .field {
            margin: 40px auto;
            width: 100%;
            max-width: 500px; /* 비밀번호 폼은 조금 더 슬림하게 */
            padding: 0 20px 100px;
        }

        .infoField {
            background: white;
            border-radius: 16px;
            margin: 20px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .infoBanner {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            padding: 20px 24px;
            color: white;
            font-weight: 700;
            font-size: 18px;
        }

        .infoBanner2 {
            padding: 20px 24px;
            color: #475569;
            font-size: 15px;
            border-bottom: 1px solid #f1f5f9;
        }

        .infoBanner2:last-child {
            border-bottom: none;
        }

        /* 가이드 텍스트 스타일 */
        .guide-box {
            background: #f1f5f9;
            padding: 15px 20px;
            border-bottom: 1px solid #e2e8f0;
        }

        .guideSpan {
            display: block;
            font-size: 13px;
            color: #64748b;
            line-height: 1.6;
        }

        .fontBold {
            color: #0078FF;
            font-weight: bold;
            margin-right: 4px;
        }

        .infoBanner2 label {
            display: block;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 12px;
        }

        .infoBanner2 i {
            color: #0078FF;
            font-size: 16px;
            margin-right: 8px;
        }

        .infoBanner2 input[type="password"] {
            width: 100%;
            box-sizing: border-box;
            padding: 12px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s ease;
            color: #1e293b;
        }

        .infoBanner2 input[type="password"]:focus {
            outline: none;
            border-color: #0078FF;
            box-shadow: 0 0 0 3px rgba(0, 120, 255, 0.1);
        }

        /* 버튼 영역 */
        .btnField {
            display: flex;
            flex-direction: column; /* 세로 배치 유지 (기존 디자인 참고) */
            gap: 12px;
            margin-top: 30px;
        }

        .btnField button {
            width: 100%;
            height: 50px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .changeBtn {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            color: white;
            box-shadow: 0 4px 14px rgba(0, 120, 255, 0.4);
        }

        .changeBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 120, 255, 0.5);
        }

        .cancleBtn {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .cancleBtn:hover {
            background: #e2e8f0;
            color: #475569;
        }

        @media (max-width: 640px) {
            .field {
                padding: 20px 16px 80px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../components/header.jsp" %>
    <div id="app">
        <div class="field">
            <div class="infoField">
                <div class="infoBanner">
                    비밀번호 변경
                </div>

                <div class="guide-box">
                    <span class="guideSpan">
                        <span class="fontBold">·</span> 다른 사이트에서 사용한 적 없는 비밀번호가 안전합니다.
                    </span>
                    <span class="guideSpan">
                        <span class="fontBold">·</span> 이전에 사용한 적 없는 비밀번호를 권장합니다.
                    </span>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-lock-open"></i> 현재 비밀번호
                    </label>
                    <input type="password" placeholder="현재 비밀번호를 입력하세요" v-model="nowPwd">
                </div>
                
                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-key"></i> 새 비밀번호
                    </label>
                    <input type="password" placeholder="새 비밀번호" v-model="newPwd">
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-check-double"></i> 새 비밀번호 확인
                    </label>
                    <input type="password" placeholder="새 비밀번호를 한 번 더 입력하세요" v-model="newPwd2">
                </div>

                <div style="padding: 24px;">
                    <div class="btnField">
                        <button class="changeBtn" @click="fnPwdConfirm">비밀번호 변경 완료</button>
                        <button class="cancleBtn" @click="fnBack">취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../components/footer.jsp" %>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                sessionId : window.sessionData.id,
                nowPwd : "",
                newPwd : "",
                newPwd2 : "",
                // 세션 데이터 (필요시 유지)
                status: window.sessionData.status,
                nickname: window.sessionData.nickname,
                name: window.sessionData.name,
                point: window.sessionData.point
            };
        },
        methods: {
            fnPwdConfirm: function () {
                let self = this;
                if(!self.nowPwd) { alert("현재 비밀번호를 입력해주세요."); return; }
                
                let param = {
                    pwd : self.nowPwd,
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/member/pwdConfirm.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            self.fnConfirm();
                        } else{
                            alert(data.msg);
                        }
                    }
                });
            },

            fnConfirm: function() {
                let self = this;
                if(self.newPwd.length==0 || self.newPwd2.length==0){
                    alert("새 비밀번호를 입력해주세요.");
                    return;
                }

                if(self.newPwd != self.newPwd2){
                    alert("새 비밀번호가 서로 일치하지 않습니다.");
                    return;
                }

                let param = {
                    userId : self.sessionId,
                    pwd : self.newPwd
                };
                $.ajax({
                    url: "/member/pwdChange.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert(data.msg);
                            location.href="/myInfo.do";
                        } else{
                            alert(data.msg);
                        }
                    }
                });
            },

            fnBack : function () {
                location.href="/myInfo.do";
            },

            blockSpaceInput(event) {
                if (event.key === " ") {
                    event.preventDefault();
                }
            }
        },
        mounted() {
            let self = this;
            // 모든 비밀번호 입력창에 공백 입력 방지 리스너 등록
            document.querySelectorAll('input[type="password"]').forEach(input => {
                input.addEventListener('keydown', self.blockSpaceInput);
            });
        }
    });

    app.mount('#app');
</script>