<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
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
            max-width: 600px;
            padding: 0 20px 100px;
        }

        .infoField {
            background: white;
            border-radius: 16px;
            margin: 20px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .infoField:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .infoBanner {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            padding: 20px 24px;
            color: white;
            font-weight: 700;
            font-size: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .infoBanner2 {
            padding: 16px 24px;
            color: #475569;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.2s ease;
        }

        .infoBanner2:last-child {
            border-bottom: none;
        }

        .infoBanner2:hover {
            background: #f8fafc;
        }

        .infoBanner2 i {
            width: 20px;
            color: #0078FF;
            font-size: 16px;
        }

        .info {
            position: relative;
        }

        .editBtn {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            padding: 0;
        }

        .editBtn i {
            font-size: 20px;
            transition: transform 0.2s ease;
        }

        .editBtn:hover i {
            transform: scale(1.1);
        }

        .info-dropdown {
            position: absolute;
            top: 35px;
            right: 0;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
            padding: 8px;
            list-style: none;
            margin: 0;
            z-index: 100;
            animation: fadeIn 0.2s ease;
            min-width: 100px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .info-dropdown li {
            font-size: 14px;
            color: #0078FF;
            padding: 10px 16px;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .info-dropdown li:hover {
            background: #f0f9ff;
            color: #0056b3;
        }

        .info-dropdown li[style*="red"] {
            color: #ef4444 !important;
        }

        .info-dropdown li[style*="red"]:hover {
            background: #fef2f2 !important;
            color: #dc2626 !important;
        }

        .buyBtn {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .buyBtn button {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 120, 255, 0.3);
        }

        .buyBtn button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 120, 255, 0.4);
        }

        .infoBanner2 button {
            margin-left: auto;
            background: #f1f5f9;
            color: #0078FF;
            border: 1px solid #e2e8f0;
            padding: 6px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .infoBanner2 button:hover {
            background: #0078FF;
            color: white;
            border-color: #0078FF;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-user {
            background: #f1f5f9;
            color: #64748b;
        }

        .status-subscriber {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
        }

        .status-admin {
            background: linear-gradient(135deg, #ddd6fe, #c4b5fd);
            color: #5b21b6;
        }

        .time-left {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: #f0f9ff;
            color: #0078FF;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
        }

        @media (max-width: 640px) {
            .field {
                padding: 20px 16px 80px;
            }

            .infoBanner {
                padding: 16px 20px;
                font-size: 16px;
            }

            .infoBanner2 {
                padding: 14px 20px;
                font-size: 14px;
            }

            .buyBtn {
                flex-direction: column;
                align-items: flex-end;
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
                    내 정보
                    <span class="editBtn info">
                        <a href="javascript:;">
                            <i class="fa-solid fa-ellipsis-vertical" @click="toggleMenu"></i>
                            <ul v-if="infoFlg" class="info-dropdown">
                                <li @click="fnEdit">수정</li>
                                <li style="color: red;" @click="fnRelease">탈퇴</li>
                            </ul>
                        </a>
                    </span>
                </div>
                
                <div class="infoBanner2">
                    <i class="fa-solid fa-user"></i>
                    <span>{{info.name}}</span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-phone"></i>
                    <span>{{info.phone}}</span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-envelope"></i>
                    <span>{{info.email}}</span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-pen-clip"></i>
                    <span>{{info.userId}}</span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-regular fa-face-smile"></i>
                    <span>{{info.nickname}}</span>
                </div>
                <div class="infoBanner2">
                    <span v-if="info.status === 'U'" class="status-badge status-user">
                        <i class="fa-solid fa-circle-user"></i>
                        일반 사용자
                    </span>
                    <span v-else-if="info.status === 'S'" class="status-badge status-subscriber">
                        <i class="fa-solid fa-star"></i>
                        구독자
                    </span>
                    <span v-else-if="info.status === 'A'" class="status-badge status-admin">
                        <i class="fa-solid fa-user-secret"></i>
                        관리자
                    </span>
                    <span class="buyBtn" v-if="info.status === 'U'">
                        <button @click="fnSub">구독하기</button>
                    </span>
                    <span class="buyBtn" v-else-if="info.status === 'S'">
                        <span class="time-left">
                            <i class="fa-regular fa-clock"></i>
                            남은 기간: {{leftTime}}
                        </span>
                    </span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-gift"></i>
                    <span>
                        {{info.bdate}} (
                        <span v-if="info.gender === 'M'">남</span>
                        <span v-else-if="info.gender === 'F'">여</span>
                        <span v-else>미공개</span>
                        )
                    </span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-house"></i>
                    <span>{{info.addr}}</span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-calendar"></i>
                    <span>{{info.cdate}}</span>
                    <span class="buyBtn">
                        <span class="time-left">
                            <i class="fa-solid fa-cake-candles"></i>
                            가입 {{info.cdate2}}일 째
                        </span>
                    </span>
                </div>
                <div class="infoBanner2">
                    <i class="fa-regular fa-calendar"></i>
                    <span>{{info.udate}}</span>
                </div>
            </div>
            
            <div class="infoField">
                <div class="infoBanner">
                    보안설정
                </div>
                <div class="infoBanner2">
                    <i class="fa-solid fa-key"></i>
                    <span>비밀번호</span>
                    <button @click="fnPwdCert">수정</button>
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
                sessionId : "${sessionId}",
                info : {},
                endSub : "",
                leftTime : "",
                infoFlg : false,
                id: window.sessionData.id,
                status: window.sessionData.status,
                nickname: window.sessionData.nickname,
                name: window.sessionData.name,
                point: window.sessionData.point,
                gradeLabel: window.sessionData.gradeLabel
            };
        },
        
        methods: {
            fnMyInfo: function () {
                let self = this;
                let param = {
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/mypage/myInfo.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.info = data.info;
                        self.endSub = data.info.subsleft
                        self.fnSubTimeLeft();
                    }
                });
            },

            fnEdit: function() {
                location.href="/myInfo/edit.do";
            },

            fnRelease : function () {
                let self = this;
                let userId = self.sessionId;

                let popup = window.open(
                    "/myInfo/release.do",
                    "회원탈퇴",
                    "width=500,height=500,top=100,left=200,location=no"
                );

                if(!popup){
                    alert("팝업이 차단되었습니다. 브라우저 설정을 확인해주세요.");
                    return;
                }

                setTimeout(function () {
                    popup.postMessage({ userId: userId }, window.location.origin);
                }, 500);
            },

            fnSub : function () {
                let self = this;
                let userId = self.sessionId;
                let status = self.status;

                let popup = window.open(
                    "/myInfo/subscribe.do",
                    "구독하기",
                    "width=1000,height=700,top=100,left=200,location=no"
                );
                
                if(!popup){
                    alert("팝업이 차단되었습니다. 브라우저 설정을 확인해주세요.");
                    return;
                }

                setTimeout(function () {
                    popup.postMessage({ userId: userId, status : status}, 
                    window.location.origin);
                }, 500);
            },

            fnSubTimeLeft : function () {
                let self = this;
                if (!self.endSub) return;

                let day = Math.floor(self.endSub);
                let hour = Math.floor((self.endSub - day)*24);
                let min = Math.floor(((self.endSub - day) * 24 - hour) * 60);

                if(day<=0){
                    if(hour<=0){
                        self.leftTime= Math.max(min,0) + "분";
                    } else {
                        self.leftTime=hour + "시간";
                    }
                } else {
                    self.leftTime=day + "일";
                }
            },

            toggleMenu() {
                this.infoFlg = !this.infoFlg;
            },

            toggleLogoutMenu() {
                this.showLogoutMenu = !this.showLogoutMenu;
            },

            goToWithdraw() {
                location.href = "/member/withdraw.do";
            },

            fnPwdCert () { 
                location.href = "/myInfo/pwdChange.do";
            }
        },
        mounted() {
            let self = this;
            self.fnMyInfo();
            self.infoFlg = false;
        }
    });

    app.mount('#app');
</script>