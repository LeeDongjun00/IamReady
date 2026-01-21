<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kakao Map 거리 표시</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82a2d2e3883834b8a2b2cf1015b17f3e"
    ></script>
    <style>
      ul {
        padding: 0px;
        margin: 0px;
      }
      ul li {
        list-style: none;
      }
      .main-section {
        display: flex;
        justify-content: space-between;
        margin: 0 auto;
        padding: 10px 10px;
      }
      .day-con {
        width: 25%;
        padding: 10px 10px;
        flex-direction: columns;
        box-shadow: -1px 5px 18px 0px;
        border-radius: 20px;
      }
      #map {
        width: 70%;
        height: 500px;
        border-radius: 20px;
      }
      .day-num {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 20px;
      }
      .day-item-con {
        padding: 10px 10px;
        border: 1px solid black;
        border-radius: 16px;
        cursor: pointer;
      }
      .day-item-con a {
        color: black;
        text-decoration: none;
      }
      .detail-con {
        display: flex;
        gap: 10px;
        margin: 20px 0;
        justify-content: center;
      }
      .detail-btn button {
        padding: 8px 16px;
        border-radius: 20px;
        border: none;
        background: #007bff;
        color: white;
        cursor: pointer;
        transition: 0.2s;
      }
      .detail-btn button.active {
        background: #0056b3;
      }
      .detail-item-con {
        padding: 16px, 0;
      }
      .item-con {
        margin-bottom: 24px;
        display: flex;
        justify-content: space-evenly;
        flex-direction: row;
      }
      .box {
        border-radius: 18px;
        background-color: lightblue;
        overflow: hidden;
      }
      .box:not(:last-child) {
        margin-right: 24px;
      }
      .item-title {
        font-size: 24px;
        font-weight: 600;
      }
    </style>
  </head>
  <body>
    <div id="app">
      <div class="main-section">
        <div class="day-con">
          <div class="day-list" v-for="(dayList, dayNum) in positionsByDay" :key="dayNum" style="margin-bottom: 20px">
            <div class="day-num">{{ dayNum }}일차</div>
            <ul>
              <li class="day-item-con" v-for="item in dayList" style="margin-bottom: 8px" @click="fnMove(item)">
                {{ item.title }}
                <div style="font-size: 12px; color: gray">{{ item.addr1 }}</div>
              </li>
            </ul>
          </div>
        </div>
        <div id="map"></div>
      </div>
      <div>
        <div class="detail-con">
          <div class="detail-btn" v-for="(dayList, dayNum) in positionsByDay" :key="dayNum">
            <button @click="fnClick(dayNum)" :class="{ active: selectDay === dayNum }">{{ dayNum }}</button>
          </div>
        </div>
        <div class="detail-item-con" v-for="(dayList, dayNum) in positionsByDay">
          <div v-if="selectDay == dayNum">
            <h2>{{ dayNum }}일차</h2>
            <div class="item-con">
              <div class="box" v-for="item in dayList">
                <img
                  :src="item.firstimage || getRandomImage()"
                  alt=""
                  style="width: 100%; height: 192px; object-fit: cover"
                />
                <div class="item-title">{{ item.title }}</div>
                <div>
                  {{ item.addr1 }}
                </div>
                <div>
                  {{ item.overview }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

<script>
  const app = Vue.createApp({
    data() {
      return {
        positions: [],
        positionsByDay: {},
        container: "",
        options: {
          center: new kakao.maps.LatLng(35.1027993255, 128.9678872863),
          level: 8,
        },
        map: "",
        info: [],
        selectDay: "1",
        randomImages: [
          "/img/defaultImg01.jpg",
          "/img/defaultImg02.jpg",
          "/img/defaultImg03.jpg",
          "/img/defaultImg04.jpg",
          "/img/defaultImg05.jpg",
          "/img/defaultImg06.jpg",
          "/img/defaultmg07.jpg",
          "/img/defaultmg08.jpg",
          "/img/defaultmg09.jpg",
          "/img/defaultmg10.jpg",
          "/img/defaultmg11.jpg",
          "/img/defaultmg12.jpg",
          "/img/defaultmg13.jpg",
          "/img/defaultmg14.jpg",
          "/img/defaultmg15.jpg",
          "/img/defaultmg16.jpg",
          "/img/defaultimg17.jpg",
          "/img/defaultimg18.jpg",
          "/img/defaultimg19.jpg",
          "/img/defaultimg20.jpg",
          "/img/defaultimg21.jpg",
          "/img/defaultimg22.jpg",
          "/img/defaultimg23.jpg",
          "/img/defaultimg24.jpg",
          "/img/defaultimg25.jpg",
          "/img/defaultimg26.jpg",
          "/img/defaultimg27.jpg",
          "/img/defaultimg28.jpg",
          "/img/defaultimg29.jpg",
          "/img/defaultimg30.jpg",
          "/img/defaultimg31.jpg",
          "/img/defaultimg32.jpg",
          "/img/defaultimg33.jpg",
          "/img/defaultimg34.jpg",
          "/img/defaultimg35.jpg",
          "/img/defaultimg36.jpg",
          "/img/defaultimg37.jpg",
          "/img/defaultimg38.jpg",
          "/img/defaultimg39.jpg",
          "/img/defaultimg40.jpg",
          "/img/defaultimg41.jpg",
          "/img/defaultimg42.jpg",
          "/img/defaultimg43.jpg",
          "/img/defaultimg44.jpg",
          "/img/defaultimg45.jpg",
          "/img/defaultimg46.jpg",
          "/img/defaultimg47.jpg",
          "/img/defaultimg48.jpg",
          "/img/defaultimg49.jpg",
        ],
      };
    },
    methods: {
      deg2rad(deg) {
        return deg * (Math.PI / 180);
      },
      getDistance(lat1, lng1, lat2, lng2) {
        const R = 6371; // km
        const dLat = this.deg2rad(lat2 - lat1);
        const dLng = this.deg2rad(lng2 - lng1);
        const a =
          Math.sin(dLat / 2) * Math.sin(dLat / 2) +
          Math.cos(this.deg2rad(lat1)) * Math.cos(this.deg2rad(lat2)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
      },
      fnMove(item) {
        let self = this;
        var moveLatLon = new kakao.maps.LatLng(item.lat, item.lng);
        self.map.setCenter(moveLatLon);
      },
      fninfo() {
        let self = this;
        let param = {
          resNum: 40,
        };
        $.ajax({
          url: "/share.dox",
          type: "GET",
          data: param,
          success: function (data) {
            self.info = data; // dayMap 전체
            //console.log(data);

            const days = Object.keys(data)
              .map((k) => parseInt(k))
              .sort((a, b) => a - b);
            for (let i = 0; i < days.length; i++) {
              const day = days[i];
              const dayList = data[day];
              self.positionsByDay[day] = [];

              for (let j = 0; j < dayList.length; j++) {
                const item = dayList[j];
                self.positionsByDay[day].push({
                  title: item.title,
                  lat: parseFloat(item.mapy),
                  lng: parseFloat(item.mapx),
                  overview: item.overview,
                  dayNum: day,
                  reserv_date: item.reserv_date,
                  firstimage: item.firstimage,
                  addr1: item.addr1,
                });
              }
              //console.log(dayList);
            }

            self.addMarkersAndLinesByDay();
          },
        });
      },
      fnClick(dayNum) {
        let self = this;
        self.selectDay = dayNum;
      },

      addMarkersAndLinesByDay() {
        let self = this;
        const colors = ["red", "blue", "green", "orange", "purple"]; // day별 색상

        Object.keys(self.positionsByDay).forEach((day, idx) => {
          const positions = self.positionsByDay[day];
          const color = colors[idx % colors.length];

          // 마커
          positions.forEach((pos) => {
            const marker = new kakao.maps.Marker({
              map: self.map,
              position: new kakao.maps.LatLng(pos.lat, pos.lng),
              title: pos.title,
              // markerImage 옵션으로 색상/이미지도 바꿀 수 있음
            });
          });

          // 선
          const linePath = positions.map((p) => new kakao.maps.LatLng(p.lat, p.lng));
          const polyline = new kakao.maps.Polyline({
            path: linePath,
            strokeWeight: 3,
            strokeColor: color, // 일자별 색상
            strokeOpacity: 1,
            strokeStyle: "solid",
          });
          polyline.setMap(self.map);

          // 거리 표시 (선 중간)
          for (let i = 0; i < positions.length - 1; i++) {
            const p1 = positions[i];
            const p2 = positions[i + 1];

            const midLat = (p1.lat + p2.lat) / 2;
            const midLng = (p1.lng + p2.lng) / 2;

            const distance = self.getDistance(p1.lat, p1.lng, p2.lat, p2.lng);
            const overlay = new kakao.maps.CustomOverlay({
              map: self.map,
              position: new kakao.maps.LatLng(midLat, midLng),
              content:
                '<div style="padding:2px 5px; background:yellow; border:1px solid black; font-size:12px;">' +
                distance.toFixed(2) +
                " km</div>",
            });
          }
        });
      },
      getRandomImage() {
        if (!this.shuffled) {
          this.shuffled = [...this.randomImages].sort(() => Math.random() - 0.5);
        }

        // 하나 꺼내기 (없으면 다시 섞기)
        if (this.shuffled.length === 0) {
          this.shuffled = [...this.randomImages].sort(() => Math.random() - 0.5);
        }

        return this.shuffled.pop();
      },
    },
    mounted() {
      const self = this;
      self.$nextTick(() => {
        self.container = document.getElementById("map");
        self.map = new kakao.maps.Map(self.container, self.options);
        self.fninfo();

        // 혹시 창 크기 변경 시 지도 재정렬
        window.addEventListener("resize", () => {
          self.map.relayout();
        });
      });
    },
  });

  app.mount("#app");
</script>
