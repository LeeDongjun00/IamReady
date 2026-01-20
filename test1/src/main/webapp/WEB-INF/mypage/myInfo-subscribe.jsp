<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구독 플랜 선택</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* 기본 배경 설정 */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 메인 컨테이너 */
        .field {
            width: 100%;
            max-width: 450px;
            padding: 20px;
        }

        /* 카드 스타일 */
        .subField {
            background-color: white;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            text-align: center;
            padding: 40px 30px;
            transition: transform 0.3s ease;
        }

        /* 상단 아이콘 및 제목 */
        .title-section {
            margin-bottom: 30px;
        }
        
        .icon-circle {
            width: 70px;
            height: 70px;
            background-color: #eef6ff;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 20px;
        }

        .icon-circle i {
            font-size: 30px;
            color: #0078FF;
        }

        .plan-name {
            font-size: 1.4rem;
            color: #333;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .price-tag {
            font-size: 2.2rem;
            color: #0078FF;
            font-weight: 800;
        }

        .price-tag span {
            font-size: 1rem;
            color: #888;
            font-weight: 400;
        }

        /* 혜택 리스트 스타일 */
        .explainField {
            text-align: left;
            margin: 30px 0;
            padding: 20px;
            background-color: #f9fbff;
            border-radius: 16px;
        }

        .benefit-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 0.95rem;
            color: #555;
            font-weight: 500;
        }

        .benefit-item i {
            color: #2ecc71;
            margin-right: 12px;
            font-size: 1rem;
        }

        /* 버튼 스타일 */
        .subBtn {
            width: 100%;
            padding: 16px;
            font-size: 1.1rem;
            border-radius: 14px;
            border: none;
            background: linear-gradient(135deg, #0078FF, #00C6FF);
            color: white;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 120, 255, 0.3);
        }

        .subBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 120, 255, 0.4);
            filter: brightness(1.1);
        }

        .subBtn:active {
            transform: translateY(0);
        }

        /* 취소 버튼(필요시 사용) */
        .cancel-link {
            display: inline-block;
            margin-top: 20px;
            color: #aaa;
            text-decoration: none;
            font-size: 0.9rem;
            cursor: pointer;
        }
        
        .cancel-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="app">
        <div class="field">
            <div class="subField">
                <div class="title-section">
                    <div class="icon-circle">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <div class="plan-name">월간 프리미엄 플랜</div>
                    <div class="price-tag">4,900<span> / 월</span></div>
                </div>

                <div class="explainField">
                    <div class="benefit-item">
                        <i class="fa-solid fa-check"></i>
                        <span>포인트 추가 적립 2%</span>
                    </div>
                    <div class="benefit-item">
                        <i class="fa-solid fa-check"></i>
                        <span>경로 생성 기능 무제한 해제</span>
                    </div>
                    <div class="benefit-item">
                        <i class="fa-solid fa-check"></i>
                        <span>예산 세부 관리 시스템 제공</span>
                    </div>
                    <!-- <div class="benefit-item">
                        <i class="fa-solid fa-check"></i>
                        <span>광고 없는 클린한 인터페이스</span>
                    </div> -->
                </div>

                <div class="btnField">
                    <button class="subBtn" @click="fnSub">지금 구독하기</button>
                </div>
                
                <div class="cancel-link" @click="fnCancel">다음에 할게요</div>
            </div>
        </div>
    </div>

    <script>
        // 기존 스크립트 로직 유지
        IMP.init("imp06808578");

        const app = Vue.createApp({
            data() {
                return {
                    userId : "",
                    status : "",
                    subsDay : 30
                };
            },
            methods: {
                fnSub: function () {
                    let self = this;
                    IMP.request_pay({
                        pg: "html5_inicis",
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: "구독(1개월)",
                        amount: 1, // 테스트를 위해 1원 유지
                        buyer_tel: "010-0000-0000",
                    }, function (rsp) {
                        if (rsp.success) {
                            self.fnStatusUp();
                        } else {
                            alert("결제에 실패했습니다: " + rsp.error_msg);
                        }
                    });
                },
                fnReceiveMessage(event) {
                    if (event.origin !== window.location.origin) return;
                    this.userId = event.data.userId;
                    this.status = event.data.status;
                },
                fnCancel: function () {
                    window.close();
                },
                fnStatusUp: function () {
                    let self = this;
                    let param = {
                        userId : self.userId,
                        status : self.status,
                        subsDay : self.subsDay
                    };
                    $.ajax({
                        url: "/mypage/statusUp.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if(data.result=="success"){
                                alert(data.msg);
                                if (window.opener && !window.opener.closed) {
                                    window.opener.location.reload();
                                }
                                window.close();
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                }
            },
            mounted() {
                window.addEventListener("message", this.fnReceiveMessage);
            }
        });

        app.mount('#app');
    </script>
</body>
</html>