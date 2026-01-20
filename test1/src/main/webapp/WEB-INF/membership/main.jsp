<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멤버십</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/main-style.css">
    <link rel="stylesheet" href="/css/common-style.css">
    <link rel="stylesheet" href="/css/header-style.css">
    <link rel="stylesheet" href="/css/main-images.css">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans KR', sans-serif;
        }

        .field {
            width: 100%;
            height: 750px;
        }

        .mainField {
            margin: 15px auto;
            width: 80%;
            height: 700px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .topBar {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            height: 8px;
        }

        .membershipField {
            display: flex;
            height: calc(100% - 8px);
        }

        .sidebar {
            width: 240px;
            background: #f8fafc;
            padding: 30px 0;
            border-right: 1px solid #e2e8f0;
        }

        .btn {
            width: 100%;
            height: 60px;
            border: none;
            background: transparent;
            font-size: 16px;
            text-align: left;
            padding: 0 30px;
            color: #64748b;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn i {
            font-size: 18px;
            width: 20px;
        }

        .btn:hover {
            background: #f1f5f9;
            color: #475569;
        }

        .btn.active {
            background: linear-gradient(90deg, rgba(0, 120, 255, 0.1) 0%, transparent 100%);
            color: #0078FF;
            font-weight: 600;
        }

        .btn.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(180deg, #0078FF 0%, #00C9FF 100%);
        }

        .content {
            flex: 1;
            padding: 60px 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .panel {
            display: none;
            width: 100%;
            max-width: 500px;
        }

        .panel.active {
            display: block;
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .plan-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
        }

        .plan-header {
            margin-bottom: 30px;
        }

        .plan-title {
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .plan-title i {
            color: #0078FF;
            font-size: 24px;
        }

        .badge {
            display: inline-block;
            background: linear-gradient(135deg, #f59e0b, #f97316);
            color: white;
            font-size: 11px;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .price {
            font-size: 48px;
            font-weight: 800;
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 20px 0;
        }

        .price span {
            font-size: 18px;
            font-weight: 500;
            color: #94a3b8;
        }

        .benefits {
            background: #f8fafc;
            border-radius: 16px;
            padding: 30px;
            margin: 30px 0;
            text-align: left;
        }

        .benefits li {
            list-style: none;
            padding: 14px 0;
            font-size: 15px;
            color: #475569;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .benefits li:not(:last-child) {
            border-bottom: 1px solid #e2e8f0;
        }

        .benefits i {
            color: #10b981;
            font-size: 18px;
            width: 20px;
            flex-shrink: 0;
        }

        .subBtn {
            width: 100%;
            height: 56px;
            border-radius: 14px;
            font-size: 17px;
            font-weight: 600;
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px rgba(0, 120, 255, 0.4);
            position: relative;
            overflow: hidden;
        }

        .subBtn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .subBtn:hover::before {
            left: 100%;
        }

        .subBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 120, 255, 0.5);
        }

        .subBtn:active {
            transform: translateY(0);
        }

        .coming-soon {
            text-align: center;
            color: #94a3b8;
            font-size: 18px;
            padding: 60px 20px;
        }

        .coming-soon i {
            font-size: 48px;
            color: #cbd5e1;
            margin-bottom: 20px;
            display: block;
        }

        @media (max-width: 768px) {
            .membershipField {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                border-right: none;
                border-bottom: 1px solid #e2e8f0;
                padding: 20px 0;
            }

            .btn {
                height: 50px;
                padding: 0 20px;
            }

            .content {
                padding: 40px 20px;
            }

            .plan-card {
                padding: 30px 20px;
            }

            .price {
                font-size: 40px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../components/header.jsp" %>
    <div id="app">
        <div class="field">
            <div class="mainField">
                <div class="topBar"></div>
                <div class="membershipField">
                    <div class="sidebar">
                        <button class="btn active" data-target="panel1">
                            <i class="fa-solid fa-calendar"></i>
                            <span>월간 플랜</span>
                        </button>
                        <button class="btn" data-target="panel2">
                            <i class="fa-solid fa-calendar-days"></i>
                            <span>연간 플랜</span>
                        </button>
                        <button class="btn" data-target="panel3">
                            <i class="fa-solid fa-clock"></i>
                            <span>추가 예정</span>
                        </button>
                    </div>
                    <div class="content">
                        <div id="panel1" class="panel active">
                            <div class="plan-card">
                                <div class="plan-header">
                                    <div class="plan-title">
                                        <span>월간 구독</span>
                                        <i class="fa-solid fa-paper-plane"></i>
                                    </div>
                                    <div class="price">₩4,900<span> / 월</span></div>
                                </div>

                                <ul class="benefits">
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>포인트 추가 적립 2%</span>
                                    </li>
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>경로 생성 기능 해제</span>
                                    </li>
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>예산 세부 관리</span>
                                    </li>
                                </ul>

                                <button v-if="status === 'U'" class="subBtn" @click="fnSub('구독(1개월)',4900, 'M')">
                                    구독하기
                                </button>
                                <button v-else-if="status === 'S'" class="subBtn" @click="fnSub('구독(1개월)',4900, 'M')">
                                    연장하기
                                </button>
                            </div>
                        </div>

                        <div id="panel2" class="panel">
                            <div class="plan-card">
                                <div class="plan-header">
                                    <div class="plan-title">
                                        <span>연간 구독</span>
                                        <span class="badge">BEST</span>
                                        <i class="fa-solid fa-paper-plane"></i>
                                    </div>
                                    <div class="price">₩49,000<span> / 년</span></div>
                                </div>

                                <ul class="benefits">
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>포인트 추가 적립 2%</span>
                                    </li>
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>경로 생성 기능 해제</span>
                                    </li>
                                    <li>
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span>예산 세부 관리</span>
                                    </li>
                                </ul>

                                <button v-if="status === 'U'" class="subBtn" @click="fnSub('구독(1년)',49000, 'Y')">
                                    구독하기
                                </button>
                                <button v-else-if="status === 'S'" class="subBtn" @click="fnSub('구독(1년)',49000, 'Y')">
                                    연장하기
                                </button>
                            </div>
                        </div>

                        <div id="panel3" class="panel">
                            <div class="coming-soon">
                                <i class="fa-solid fa-hourglass-half"></i>
                                <div>추가 예정입니다</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../components/footer.jsp" %>
</body>
</html>

<script>
    IMP.init("imp06808578");

    const app = Vue.createApp({
        data() {
            return {
                id : window.sessionData.id,
                status : window.sessionData.status,
                sellItem : "",
                sellPrice : "",
                sellTag : ""
            };
        },
        methods: {
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {

                    }
                });
            },

            fnPanelControl : function () {
                let buttons = document.querySelectorAll('.btn');
                let panels = document.querySelectorAll('.panel');

                buttons.forEach(btn => {
                    btn.addEventListener('click', () => {
                        buttons.forEach(b => b.classList.remove('active'));
                        panels.forEach(p => p.classList.remove('active'));

                        btn.classList.add('active');
                        const target = document.getElementById(btn.dataset.target);
                        target.classList.add('active');
                    });
                });
            },

            fnSub: function (itemName, itemPrice, itemTag) {
                let self = this;
                self.sellItem = itemName;
                self.sellPrice = itemPrice;
                self.sellTag = itemTag;
                
                IMP.request_pay({
                    pg: "html5_inicis",
                    pay_method: "card",
                    merchant_uid: "merchant_" + new Date().getTime(),
                    name: self.sellItem,
                    amount: 1,
                    buyer_tel: "010-0000-0000",
                }, 
                function (rsp) {
                    if (rsp.success) {
                        self.fnStatusUp();
                    } else {
                        alert("오류가 발생했습니다.");
                        return;
                    }
                });
            },

            fnStatusUp : function () {
                let self = this;
                let subsDay = "";
                if(self.sellTag=='Y'){
                    subsDay = 365;
                } else if(self.sellTag=='M'){
                    subsDay = 30;
                }
                let param = {
                    userId : self.id,
                    status : self.status,
                    sellTag : self.sellTag,
                    subsDay : subsDay
                };
                
                $.ajax({
                    url: "/mypage/statusUp.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result=="success"){
                            alert(data.msg);
                            location.reload();
                        } else {
                            alert(data.msg);
                            return;
                        }
                    }
                });
            }
        },
        mounted() {
            let self = this;
            self.fnPanelControl();
        }
    });

    app.mount('#app');
</script>