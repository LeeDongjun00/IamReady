<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{{ detail.title || "숙소 상세" }}</title>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>

    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />

    <style>
      :root {
        --primary-color: #ff385c;
        --text-main: #222222;
        --text-sub: #717171;
        --bg-gray: #f7f7f7;
        --border-color: #dddddd;
      }

      body {
        background-color: #fff;
        color: var(--text-main);
        font-family: "Pretendard", sans-serif;
        margin: 0;
        padding: 0;
      }
      .container {
        display: flex;
        gap: 50px;
        max-width: 1100px;
        margin: 40px auto;
        padding: 0 20px;
      }
      .left {
        flex: 2;
      }
      .right {
        flex: 1;
      }

      .section-title {
        font-size: 26px;
        font-weight: 700;
        margin-bottom: 8px;
      }
      .location-info {
        display: flex;
        align-items: center;
        color: var(--text-sub);
        font-size: 15px;
        margin-bottom: 20px;
        text-decoration: underline;
      }
      .main-image-wrapper img {
        width: 100%;
        height: 450px;
        object-fit: cover;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      }

      .info-card {
        padding: 30px 0;
        border-bottom: 1px solid var(--border-color);
      }
      .info-card h3 {
        font-size: 20px;
        margin-bottom: 20px;
      }

      /* 객실 리스트 아이템 스타일 수정 */
      .room-list-item {
        border: 2px solid var(--border-color);
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        cursor: pointer;
        transition: all 0.2s ease;
      }
      .room-list-item:hover {
        border-color: #aaa;
      }
      /* 선택되었을 때 스타일 */
      .room-list-item.selected {
        border-color: var(--primary-color);
        background-color: #fff0f3;
      }

      .room-images {
        gap: 12px;
        margin: 20px 0;
      }

      .room-images img {
        width: 220px;
        height: 150px;
        border-radius: 12px;
        object-fit: cover;
        flex-shrink: 0;
      }
      .room-price {
        font-size: 18px;
        font-weight: 700;
        color: var(--primary-color);
        text-align: right;
      }

      /* 오른쪽 예약 박스 */
      .reservation-box {
        position: sticky;
        top: 100px;
        border: 1px solid var(--border-color);
        border-radius: 24px;
        padding: 24px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        background: white;
      }
      .res-price {
        font-size: 24px;
        font-weight: 800;
        margin-bottom: 10px;
      }
      .res-price span {
        font-size: 16px;
        font-weight: 400;
        color: var(--text-sub);
      }
      .selected-room-name {
        font-size: 14px;
        color: var(--primary-color);
        font-weight: bold;
        margin-bottom: 15px;
      }

      .res-inputs {
        border: 1px solid #b0b0b0;
        border-radius: 8px;
        margin-bottom: 15px;
        overflow: hidden;
      }
      .res-date {
        display: flex;
        border-bottom: 1px solid #b0b0b0;
      }
      .date-item {
        flex: 1;
        padding: 10px;
      }
      .date-item:first-child {
        border-right: 1px solid #b0b0b0;
      }
      .res-label {
        font-size: 10px;
        font-weight: 800;
        text-transform: uppercase;
      }
      .res-inputs input {
        border: none;
        width: 100%;
        font-size: 14px;
        outline: none;
        padding-top: 4px;
      }
      .res-people {
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .count-btn {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #b0b0b0;
        background: white;
        cursor: pointer;
      }
      .reserve-btn {
        width: 100%;
        background: linear-gradient(to right, #e61e4d 0%, #e31c5f 50%, #d70466 100%);
        color: white;
        border: none;
        border-radius: 8px;
        padding: 14px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
      }
      .reserve-btn:disabled {
        background: #ccc;
        cursor: not-allowed;
      }
      /*슬라이드*/
      .room-slider {
        position: relative;
        width: 420px;
        height: 280px;
        margin: 20px auto;
        overflow: hidden;
        border-radius: 16px;
      }

      .room-slider img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

      .slide-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0, 0, 0, 0.6);
        color: white;
        border: none;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        cursor: pointer;
      }

      .slide-btn.left {
        left: 10px;
      }
      .slide-btn.right {
        right: 10px;
      }
    </style>
  </head>

  <body>
    <%@ include file="components/header.jsp" %>

    <div id="app" class="container" v-cloak>
      <div class="left">
        <div class="title-section">
          <h2 class="section-title">{{ info.title }}</h2>
          <div class="location-info">
            <span class="material-symbols-outlined" style="font-size: 18px">location_on</span>
            {{ info.addr1 }}
          </div>
        </div>

        <div class="main-image-wrapper">
          <img :src="info.firstimage || 'https://placehold.co/800x450'" />
        </div>

        <div class="info-card">
          <h3>편의시설</h3>

          <div class="amenity-grid">
            <div v-if="detail.parking && detail.parking !== '0'">🚗 주차 가능</div>
            <div v-if="subFacility.includes('피트니스')">🏋️ 피트니스</div>
            <div v-if="subFacility.includes('사우나')">🧖 사우나</div>
            <div v-if="subFacility.includes('수영장')">🏊 수영장</div>
            <div v-if="detail.barbecue === '1'">🔥 바비큐</div>
            <div v-if="detail.karaoke === '1'">🎤 노래방</div>
          </div>
        </div>

        <div class="info-card">
          <h3>이용 정보</h3>
          <p>🕒 체크인 : {{ detail.checkin }}</p>
          <p>🕚 체크아웃 : {{ detail.checkout }}</p>
          <p v-if="detail.roomcount">🛏 객실 수 : {{ detail.roomcount }}</p>
          <p v-if="detail.roomtype">🏨 객실 타입 : {{ detail.roomtype }}</p>
        </div>

        <div class="info-card" v-if="detail.subfacility">
          <h3>부대시설</h3>
          <p>{{ detail.subfacility }}</p>
        </div>

        <div class="info-card" v-if="detail.foodplace">
          <h3>식음 시설</h3>
          <p>{{ detail.foodplace }}</p>
        </div>

        <div class="info-card" style="border-bottom: none">
          <h3>
            객실 선택
            <span style="font-size: 14px; color: #888; font-weight: normal">(예약을 위해 객실을 선택해주세요)</span>
          </h3>

          <div
            v-for="(room, idx) in rooms"
            :key="room.roomtitle"
            class="room-list-item"
            :class="{ selected: selectedRoom && selectedRoom.roomtitle === room.roomtitle }"
            @click="fnSelectRoom(room)"
          >
            <h4>{{ room.roomtitle }}</h4>

            <!-- 슬라이더 -->
            <div class="room-slider">
              <img :src="getRoomImages(room)[room.currentIndex]" />

              <button class="slide-btn left" @click.stop="prevImage(room)" v-if="getRoomImages(room).length > 1">
                ‹
              </button>

              <button class="slide-btn right" @click.stop="nextImage(room)" v-if="getRoomImages(room).length > 1">
                ›
              </button>
            </div>

            <div class="room-price">₩{{ Number(room.price).toLocaleString() }} / 1박</div>
          </div>
        </div>
      </div>

      <div class="right">
        <div class="reservation-box">
          <div class="res-price">
            <template v-if="selectedRoom">
              ₩{{ Number(selectedRoom.price).toLocaleString() }} <span>/ 박</span>
            </template>
            <template v-else> ₩{{ minPrice }} <span>(최저가)</span> </template>
          </div>

          <div class="selected-room-name" v-if="selectedRoom">선택됨: {{ selectedRoom.roomtitle }}</div>
          <div class="selected-room-name" v-else style="color: #888">객실을 선택해 주세요</div>

          <div class="res-inputs">
            <div class="res-date">
              <div class="date-item">
                <div class="res-label">체크인</div>
                <input type="date" v-model="checkIn" :min="today" />
              </div>
              <div class="date-item">
                <div class="res-label">체크아웃</div>
                <input type="date" v-model="checkOut" :min="checkOutMin" />
              </div>
            </div>
            <div class="res-people">
              <div>
                <div class="res-label">인원</div>
                <div style="font-size: 14px; margin-top: 4px">게스트 {{ people }}명</div>
              </div>
              <div>
                <button class="count-btn" @click="people--" :disabled="people <= 1">-</button>
                <button class="count-btn" @click="people++" style="margin-left: 10px">+</button>
              </div>
            </div>
          </div>

          <button class="reserve-btn" :disabled="!selectedRoom" @click="fnReserve">
            {{ selectedRoom ? "지금 예약하기" : "객실을 선택해주세요" }}
          </button>
        </div>
      </div>
    </div>

    <%@ include file="components/footer.jsp" %>

    <script>
      const app = Vue.createApp({
        data() {
          return {
            resNum: 218,
            contentId: 142766,
            people: 1,
            info: {},
            rooms: [],
            detail: {},
            selectedRoom: null,
            checkIn: "",
            checkOut: "",
            today: "",
            checkOutMin: "",
          };
        },
        computed: {
          minPrice() {
            let self = this;
            if (!self.rooms.length) return "-";
            const prices = self.rooms.map((r) => Number(r.price));
            return Math.min(...prices).toLocaleString();
          },
          subFacility() {
            return this.info.subfacility || "";
          },
        },
        watch: {
          checkIn() {
            let self = this;
            self.updateCheckOutMin();
          },
        },
        methods: {
          setToday() {
            let self = this;
            const today = new Date();
            self.today = today.toISOString().split("T")[0];
          },

          updateCheckOutMin() {
            let self = this;
            if (!self.checkIn) {
              self.checkOutMin = "";
              return;
            }

            const nextDay = new Date(self.checkIn);
            nextDay.setDate(nextDay.getDate() + 1);
            self.checkOutMin = nextDay.toISOString().split("T")[0];

            // 체크아웃이 체크인 이전이면 초기화
            if (self.checkOut && self.checkOut < self.checkOutMin) {
              self.checkOut = "";
            }
          },
          fnSelectRoom(room) {
            let self = this;
            self.selectedRoom = room;
          },

          getRoomImages(room) {
            return [room.roomimg1, room.roomimg2, room.roomimg3, room.roomimg4, room.roomimg5].filter((i) => i);
          },

          nextImage(room) {
            const imgs = this.getRoomImages(room);
            room.currentIndex = (room.currentIndex + 1) % imgs.length;
          },

          prevImage(room) {
            const imgs = this.getRoomImages(room);
            room.currentIndex = (room.currentIndex - 1 + imgs.length) % imgs.length;
          },
          fnDetail() {
            let self = this;
            $.ajax({
              url: "/lodge-detail.dox",
              type: "GET",
              data: { contentId: this.contentId },
              success: (data) => {
                self.detail = data[0] || {};
                console.log(data);
              },
            });
          },
          fnRoom() {
            let self = this;
            $.ajax({
              url: "/lodge-detailImg.dox",
              type: "GET",
              data: { contentId: this.contentId },
              success: (data) => {
                self.rooms = (data || []).map((r) => ({
                  ...r,
                  currentIndex: 0,
                }));
                console.log(data);
              },
            });
          },
          fnInfo() {
            let self = this;
            $.ajax({
              url: "/lodge-info.dox",
              type: "GET",
              data: { contentId: this.contentId },
              success: (data) => {
                self.info = data[0] || {};
                console.log(data);
              },
            });
          },
          fnReserve() {
            let self = this;
            pageChange("payment.do", {
              resNum: self.resNum,
              contentId: self.contentId,
              title: self.info.title,
              roomTitle: self.selectedRoom.roomtitle,
              checkInDate: self.checkIn,
              checkOutDate: self.checkOut,
              adults: self.people,
              roomPrice: self.selectedRoom.price,
            });
          },
        },
        mounted() {
          let self = this;
          self.setToday();
          self.fnInfo();
          self.fnRoom();
          self.fnDetail();
        },
      });

      app.mount("#app");
    </script>
  </body>
</html>
