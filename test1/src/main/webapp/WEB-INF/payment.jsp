<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>예약 및 결제</title>

    <script
      src="https://code.jquery.com/jquery-3.7.1.js"
      integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
      crossorigin="anonymous"
    ></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
      rel="stylesheet"
    />
    <style>
      body {
        margin: 0;
        font-family: Pretendard, sans-serif;
        background: #f5f5f5;
      }
      .container {
        max-width: 480px;
        margin: 0 auto;
        background: #fff;
        min-height: 100vh;
        padding: 20px;
      }
      h2 {
        margin-bottom: 20px;
      }
      .card {
        border: 1px solid #ddd;
        border-radius: 12px;
        padding: 16px;
        margin-bottom: 16px;
      }
      .label {
        font-size: 12px;
        color: #888;
        margin-bottom: 4px;
      }
      .value {
        font-size: 15px;
        font-weight: 600;
      }
      .price {
        font-size: 20px;
        font-weight: 800;
        color: #e61e4d;
        text-align: right;
      }
      .pay-btn {
        width: 100%;
        background: linear-gradient(to right, #e61e4d, #d70466);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 14px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 20px;
      }
      .back {
        background: none;
        border: none;
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
      }
    </style>
  </head>

  <body>
    <div id="app" class="container">
      <div class="back-btn">
        <button class="back" @click="fnbck">
          <span class="material-symbols-outlined">arrow_back</span>
          뒤로가기
        </button>
      </div>
      <h2>예약 정보 확인</h2>

      <div class="card">
        <div class="label">숙소 이름</div>
        <div class="value">{{ title }}</div>
      </div>

      <div class="card">
        <div class="label">방 이름</div>
        <div class="value">{{ roomTitle }}</div>
      </div>

      <div class="card">
        <div class="label">예약자</div>
        <div class="value">{{ res }}</div>
      </div>

      <div class="card">
        <div class="label">숙박 일정</div>
        <div class="value">{{ checkIn }} ~ {{ checkOut }}</div>
      </div>

      <div class="card">
        <div class="label">인원</div>
        <div class="value">{{ people }}명</div>
      </div>

      <div class="card">
        <div class="label">결제 금액</div>
        <div class="price">₩{{ totalPrice.toLocaleString() }}</div>
      </div>

      <button class="pay-btn" @click="fnPayment">결제하기</button>
    </div>

    <script>
      IMP.init("imp06808578");

      const app = Vue.createApp({
        data() {
          return {
            resNum: "${resNum}",
            title: "${title}",
            roomTitle: "${roomTitle}",
            res: "${sessionNickname}",
            checkIn: "${checkIn}",
            checkOut: "${checkOut}",
            people: Number("${people}"),
            price: "${price}",
            contentId: "${contentId}",
            totalPrice: 0,
            stayDays: 0,
            paymentUid: "",
          };
        },
        methods: {
          fnPayment: function () {
            let self = this;
            IMP.request_pay(
              {
                pg: "html5_inicis.INIpayTest",
                pay_method: "card",
                merchant_uid: "merchant_" + new Date().getTime(),
                name: "${roomTitle}",
                amount: 1,
                buyer_tel: "010-0000-0000",
              },
              function (rsp) {
                // callback
                console.log(rsp);

                if (rsp.success) {
                  // 결제 성공 시
                  // alert("성공");
                  console.log(rsp);
                  self.paymentUid = rsp.imp_uid;
                  self.fnAdd();
                } else {
                  // 결제 실패 시
                  alert("오류가 발생했습니다.");
                  return;
                }
              }
            );
          },
          fnAdd() {
            let self = this;
            let param = {
              resNum: self.resNum,
              roomName: self.roomTitle,
              checkIn: self.checkIn,
              checkOut: self.checkOut,
              stayDays: self.stayDays,
              peopleCnt: self.people,
              totalPrice: self.totalPrice,
              paymentUid: self.paymentUid,
            };
            $.ajax({
              url: "/payment.dox",
              dataType: "json",
              type: "POST",
              data: param,
              success: function (data) {
                alert(data.msg);
              },
            });
          },

          calcPrice() {
            let self = this;
            const days = self.calcDays();
            self.stayDays = days;
            self.totalPrice = days * self.price * self.people;

            console.log(days);
            console.log(self.price);
            console.log(self.people);
          },
          calcDays() {
            const start = new Date(this.checkIn);
            const end = new Date(this.checkOut);
            return Math.max((end - start) / (1000 * 60 * 60 * 24), 1);
          },
          fnbck() {
            history.back();
          },
        },
        mounted() {
          this.calcPrice();
        },
      });

      app.mount("#app");
    </script>
  </body>
</html>
