<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<% 
    // request에서 resNum 가져오기
    String resNum = String.valueOf(request.getAttribute("resNum")); 
%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>Reservation</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />

    <script
      src="https://code.jquery.com/jquery-3.7.1.js"
      integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
      crossorigin="anonymous"
    ></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a777d1f63779cfdaa66c4a1d36cc578d&libraries=services"></script>

    <script>
      const ctx = "<%= request.getContextPath() %>";
    </script>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/reservation.css" />
    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />
    <link rel="stylesheet" href="/css/main-images.css" />

    <style>
      /* CSS는 분리된 .css 파일을 사용 */
      body {
        background-color: #ffffff;
      }

      .page-title2 {
        font-size: 2.25rem;
        font-weight: 700;
        color: #2c3e50;
        border-bottom: 3px solid var(--brand);
        padding-bottom: 10px;
        margin-bottom: 20px;
      }
      .fixed-bottom-bar {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background: #fff;
        border-top: 1px solid #ddd;
        padding: 15px;
        text-align: center;
        box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.05);
        z-index: 1000;
      }

      .fixed-bottom-bar button {
        padding: 12px 30px;
        font-size: 1.1em;
      }

      .btn-generate {
        width: 100%;
        height: 56px;
        margin-top: 20px;
        font-size: 1.2rem;
        font-weight: 700;
        background: #2c3e50;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      }
      .btn-generate:hover {
        background: #1a252f;
        transform: translateY(-2px);
      }

      /* ========================================= */
      /* ✅ [복구 및 디자인 강화] 탭 버튼 스타일 */
      /* 클래스명을 custom-tabs로 변경하여 충돌 방지 */
      /* ========================================= */
      .custom-tabs {
          display: flex;
          flex-wrap: wrap;
          gap: 10px; /* 버튼 사이 간격 */
          margin-bottom: 15px;
          margin-top: 10px;
      }
      
      .custom-tab-btn {
          padding: 8px 18px;
          background-color: #ffffff;
          border: 1px solid #e2e8f0;
          border-radius: 50px; /* 둥근 알약 모양 */
          cursor: pointer;
          font-weight: 600;
          font-size: 14px;
          color: #64748b;
          display: inline-flex;
          align-items: center;
          gap: 6px;
          transition: all 0.2s ease-in-out;
          box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      }

      .custom-tab-btn:hover {
          background-color: #f1f5f9;
          transform: translateY(-1px);
      }

      .custom-tab-btn.active {
          background-color: #2c3e50; /* 선택 시 진한 남색 */
          color: #ffffff;
          border-color: #2c3e50;
          box-shadow: 0 4px 6px -1px rgba(44, 62, 80, 0.3);
      }

      .custom-tab-btn i {
          font-size: 1.1em;
      }

      /* 프리미엄 잠금 효과 */
      .premium-lock-wrapper {
        position: relative;
        overflow: hidden;
      }

      .premium-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
        z-index: 50;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: #374151;
        text-align: center;
        border-radius: 12px;
      }

      .lock-icon-circle {
        width: 60px;
        height: 60px;
        background: #fff;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        margin-bottom: 12px;
      }

      .lock-icon-circle i {
        font-size: 24px;
        color: #1e3a8a;
      }

      .premium-msg {
        font-weight: 700;
        font-size: 1.1rem;
        margin-bottom: 4px;
      }

      .premium-sub {
        font-size: 0.85rem;
        color: #6b7280;
      }

      /* 팝업 오버레이 */
      .popup-overlay{
        position: fixed;
        top:0; left:0; right:0; bottom:0;
        background: rgba(0,0,0,0.6);
        z-index: 999;
        display:none;
      }

      /* [수정됨] 이미지 전용 팝업 스타일 */
      .img-popup-modal {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%); /* 정중앙 정렬 */
        width: 750px; /* 요청하신 너비 */
        max-width: 90vw; /* 모바일 대응 */
        background: #fff;
        z-index: 2000; /* 오버레이(999)보다 높게 설정 */
        border-radius: 0; /* 이미지라 라운드 제거해도 무방 */
        box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        overflow: hidden;
        display: none; /* 초기 상태 숨김 */
      }
      
      .popup-body {
        width: 100%;
        line-height: 0; /* 이미지 하단 여백 제거 */
        background: #000;
      }
      
      .popup-body img {
        width: 100%;
        height: auto;
        display: block;
      }

      .popup-footer {
        height: 50px;
        background-color: #1a1a1a; /* 어두운 하단 바 */
        color: #fff;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        font-size: 14px;
      }

      .check-label {
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        color: #ddd;
      }

      .close-btn {
        background: transparent;
        border: none;
        color: #fff;
        font-weight: bold;
        cursor: pointer;
        font-size: 14px;
      }
      .close-btn:hover {
        color: #ffeb3b; 
      }
    </style>
  </head>

  <body>
    <%@ include file="components/header.jsp" %>
    <div id="app">
      <div class="wrap" style="padding-bottom: 80px">
        <div class="grid two-col">
          <section class="panel">
            <h3>테마 선택 <span class="desc">복수 선택 가능</span></h3>
            <div class="desc">선택된 테마는 아래에 간단히 표시됩니다.</div>
            <div class="theme-grid">
              <button
                v-for="item in themeOptions"
                :key="item.code"
                type="button"
                :class="['theme-btn', { active: selectedThemes.includes(item.code) }]"
                @click="toggleTheme(item.code)"
              >
                {{ item.label }}
              </button>
            </div>
            <div class="chips" v-if="selectedThemes.length">
              <span class="chip" v-for="t in selectedThemes" :key="t">{{ labelOf(t) }}</span>
            </div>
            <div class="desc" v-else>선택: 없음</div>

            <h3 style="margin-top: 14px">지역 선택</h3>
            <div class="region-select-wrap">
              <div class="field">
                <label>시/도</label>
                <select v-model="currentSido" @change="onChangeSido" :disabled="loadingSido">
                  <option value="">선택</option>
                  <option v-for="s in sidoList" :key="s.code" :value="s.code">{{ s.name }}</option>
                </select>
              </div>
              <div class="field">
                <label>시/군/구</label>
                <select v-model="currentSigungu" :disabled="!sigunguList.length || loadingSigungu">
                  <option value="">전체</option>
                  <option v-for="g in sigunguList" :key="g.code" :value="g.code">{{ g.name }}</option>
                </select>
              </div>
              <button class="btn-add-region" @click="addRegion" :disabled="!currentSido" title="지역 추가">+</button>
            </div>

            <div class="chips" v-if="selectedRegions.length > 0">
              <span class="chip" v-for="(region, index) in selectedRegions" :key="index">
                {{ region.name }}
                <button @click="removeRegion(index)" title="삭제">&times;</button>
              </span>
            </div>
            <div class="desc" v-else>방문할 지역을 선택한 후 '+' 버튼을 눌러 목록에 추가해주세요. (복수 선택 가능)</div>

            <br />
            <h3>인원 / 예산</h3>
            <div class="field">
              <label>총원</label>
              <input type="number" min="1" v-model.number="headCount" placeholder="총 인원수를 입력하세요." />
            </div>
            <div class="field">
              <label>예산(원)</label>
              <input type="number" min="0" step="1000" v-model.number="budget" @input="onBudgetChange" placeholder="예산을 입력하세요." />
            </div>
            <div class="inline" style="margin-top: 2px">
              입력값: 인원 <strong>{{ headCount || 0 }}</strong
              >명 / 예산 <strong>{{ (budget || 0).toLocaleString() }}</strong
              >원
            </div>
          </section>

          <section class="panel">
            <h3>일정 선택</h3>
            <div class="field-row">
              <div class="field">
                <label>시작일</label>
                <input type="text" :value="startDate || ''" readonly placeholder="달력에서 선택" />
              </div>
              <div class="field">
                <label>종료일</label>
                <input type="text" :value="endDate || ''" readonly placeholder="달력에서 선택" />
              </div>
            </div>
            <div class="inline" style="margin-top: 2px; margin-bottom: 8px">
              선택된 일정: <strong>{{ displayDateRange }}</strong>
            </div>
            
            <div class="calendar">
              <div class="cal-header">
                <button @click.prevent="prevMonth" type="button">&lt;</button>
                <strong>{{ currentYear }}년 {{ monthName }}</strong>
                <button @click.prevent="nextMonth" type="button">&gt;</button>
              </div>
              <div class="cal-grid week-days">
                <div class="cal-day-label">일</div>
                <div class="cal-day-label">월</div>
                <div class="cal-day-label">화</div>
                <div class="cal-day-label">수</div>
                <div class="cal-day-label">목</div>
                <div class="cal-day-label">금</div>
                <div class="cal-day-label">토</div>
              </div>
              <div class="cal-grid days">
                <div v-for="(day, i) in calendarGrid" :key="i" :class="['cal-day', getDayClasses(day)]" @click="selectDate(day)">
                  {{ day.dayNum }}
                </div>
              </div>
            </div>

            <button class="btn-generate" @click="fnCreate">
              <i class="fa-solid fa-wand-magic-sparkles"></i> 추천 목록 생성
            </button>
          </section>
        </div>

        <section class="panel premium-lock-wrapper" style="margin-top: 10px">
          <h3>예산 배분</h3>
          
          <div class="premium-overlay" v-if="!isPremium">
            <div class="lock-icon-circle">
              <i class="fa-solid fa-lock"></i>
            </div>
            <div class="premium-msg">구독 전용 기능입니다</div>
            <div class="premium-sub">예산 비중을 직접 상세하게 설정해보세요</div>
          </div>

          <div class="desc">
            원형 차트의 분기점을 <b>드래그</b>하거나, 오른쪽 슬라이더로 가중치를 조정하세요. (총합 100%) 체크박스를 켜면 해당 항목이
            <b>잠금</b>됩니다.
          </div>
          <div class="pie-wrap">
            <div>
              <canvas
                id="budgetPie"
                width="640"
                height="480"
                @mousedown="onPieDown"
                @mousemove="onPieMove"
                @mouseup="onPieUp"
                @mouseleave="onPieUp"
                @touchstart.prevent="onPieDownTouch"
                @touchmove.prevent="onPieMoveTouch"
                @touchend.prevent="onPieUp"
              ></canvas>
              <div class="help">*도넛 두께 영역을 잡고 <strong>분기점</strong>을 회전시키세요. (잠금된 항목은 비율 고정)</div>
            </div>
            <div class="legend">
              <div class="legend-row" v-for="(c,idx) in categories" :key="c.key">
                <label style="display: flex; align-items: center; gap: 6px; min-width: 22px">
                  <input type="checkbox" v-model="locks[idx]" @change="normalizeWeights(); drawPie()" :disabled="!isPremium" />
                </label>
                <span class="swatch" :style="{ background:c.color }"></span>
                <div style="flex: 1">
                  <div style="display: flex; justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 4px">
                    <strong>
                      {{ c.label }}
                      <span v-if="locks[idx]" style="font-weight: 600; color: #2563eb; margin-left: 6px"></span>
                    </strong>
                    <span class="pct">{{ weights[idx] }}%</span>
                    <span class="amount">{{ amountFor(idx).toLocaleString() }}원</span>
                  </div>
                  <input type="range" min="5" max="90" :value="weights[idx]" @input="onSlider(idx, $event.target.value)" :disabled="locks[idx] || !isPremium" />
                </div>
              </div>
              <div class="inline" style="margin-top: 4px">
                합계: <strong>{{ weights.reduce((a,b)=>a+Number(b),0) }}</strong
                >%
              </div>
            </div>
          </div>
        </section>

        <section class="panel" style="margin-top: 10px">
          <h3>추천 코스 (지도)</h3>
          <div class="desc">*연관도가 높을수록 마커가 <strong>크게</strong> 표시됩니다.</div>

          <div class="custom-tabs" v-if="dateTabs.length > 0">
            <button
              type="button"
              v-for="tab in dateTabs"
              :key="tab.date"
              :class="['custom-tab-btn', { active: activeDate === tab.date }]"
              @click="setActiveDate(tab.date)"
            >
              {{ tab.label }}
            </button>
          </div>
          <div class="desc" v-else>먼저 캘린더에서 여행 <strong>시작일</strong>과 <strong>종료일</strong>을 선택해주세요.</div>

          <div class="region-filter-wrap" v-if="selectedRegions.length > 0">
            <label for="region-filter">지역 필터:</label>
            <select id="region-filter" v-model="activeRegion" @change="onRegionChange">
              <option value="all">전체 보기</option>
              <option v-for="(region, index) in selectedRegions" :key="index" :value="index">
                {{ region.name }}
              </option>
            </select>
          </div>

          <div class="custom-tabs" v-if="activeDate">
            <button type="button" :class="['custom-tab-btn', { active: activeTab === 12 }]" @click="setActiveTab(12)">
              <i class="fa-solid fa-camera"></i> 관광지 ({{ countForTab(12) }})
            </button>
            <button type="button" :class="['custom-tab-btn', { active: activeTab === 32 }]" @click="setActiveTab(32)">
              <i class="fa-solid fa-hotel"></i> 숙박 ({{ countForTab(32) }})
            </button>
            <button type="button" :class="['custom-tab-btn', { active: activeTab === 39 }]" @click="setActiveTab(39)">
              <i class="fa-solid fa-utensils"></i> 식당 ({{ countForTab(39) }})
            </button>
          </div>

          <div id="map-recommend" class="map-recommend-area"></div>
          <div id="debugOut" style="display: none"></div>

          <div class="poi-add-panel" v-if="selectedPoi && activeDate">
            <strong>{{ selectedPoi.title || "이름 없음" }}</strong>
            <button class="btn-primary" @click="addPoiToItinerary">[ {{ activeDateLabel }} ] 일정에 추가하기</button>
            <button class="btn-secondary" @click="selectedPoi = null; infowindow.close();">취소</button>
          </div>
        </section>

        <section class="panel" style="margin-top: 10px">
          <h3>나의 최종 일정 (순서 변경 가능)</h3>

          <div class="budget-status-wrap" v-if="isPremium && budget > 0">
            <div class="budget-status-item">
              <span class="label">숙박 예산</span>
              <span :class="['amount', { over: spentAccom > accomBudgetLimit }]">
                <span class="current">{{ spentAccom.toLocaleString() }}원</span> /
                <span class="total">{{ accomBudgetLimit.toLocaleString() }}원</span>
              </span>
            </div>
            <div class="budget-status-item">
              <span class="label">식당 예산</span>
              <span :class="['amount', { over: spentFood > foodBudgetLimit }]">
                <span class="current">{{ spentFood.toLocaleString() }}원</span> /
                <span class="total">{{ foodBudgetLimit.toLocaleString() }}원</span>
              </span>
            </div>
            <div class="budget-status-item">
              <span class="label">체험/관광 예산</span>
              <span :class="['amount', { over: spentActivity > activityBudgetLimit }]">
                <span class="current">-</span> /
                <span class="total">{{ activityBudgetLimit.toLocaleString() }}원</span>
              </span>
            </div>
          </div>

          <div class="budget-status-wrap" v-else-if="!isPremium" style="justify-content: flex-end; background: #f8fafc;">
             <div class="budget-status-item" style="font-size: 1.1rem;">
                <span class="label">현재 담은 코스 총 비용:</span>
                <span class="amount" style="color: #2c3e50; font-weight:bold; margin-left: 10px;">
                    {{ (spentAccom + spentFood + spentActivity).toLocaleString() }}원
                </span>
             </div>
          </div>
          <div class="desc" v-if="dateTabs.length > 0">일정 항목을 마우스로 잡고 위아래로 끌어서 순서를 변경할 수 있습니다.</div>

          <div v-if="dateTabs.length > 0">
            <div v-for="tab in dateTabs" :key="tab.date" class="itinerary-day-block">
              <h4>[ {{ tab.label }} ] 일정 목록</h4>

              <div class="itinerary-list" v-if="itinerary[tab.date] && itinerary[tab.date].length > 0">
                <ul>
                  <li
                    v-for="(poi, index) in itinerary[tab.date]"
                    :key="poi.contentId + '-' + index"
                    :draggable="true"
                    :class="{ 
                        dragging: isDragging(tab.date, index),
                        'drag-over': isDragOver(tab.date, index) 
                      }"
                    @dragstart="onDragStart(tab.date, index)"
                    @dragover.prevent="onDragOver(tab.date, index)"
                    @dragleave="onDragLeave"
                    @drop="onDrop(tab.date, index)"
                    @dragend="onDragEnd"
                  >
                    <span>
                      {{ poi.title || "이름 없음" }}
                      ({{ poi.typeId === 12 ? "관광" : poi.typeId === 32 ? "숙박" : "식당" }})
                      <span v-if="poi.price > 0" style="color: #64748b; font-size: 0.9em; margin-left: 5px">
                        - {{ poi.price.toLocaleString() }}원
                      </span>
                    </span>
                    <button @click.stop="removePoiFromItinerary(tab.date, index)">삭제</button>
                  </li>
                </ul>
              </div>
              <div class="desc" v-else>- 일정이 비어있습니다 -</div>
            </div>
          </div>
          <div class="desc" v-else>먼저 캘린더에서 여행 <strong>시작일</strong>과 <strong>종료일</strong>을 선택해주세요.</div>
        </section>

        <div class="fixed-bottom-bar">
          <button class="btn-primary" @click="fnSaveTrip" :disabled="Object.values(itinerary).flat().length === 0">
            코스 생성 완료 및 예약 내역 확인하기
          </button>
        </div>

        <button class="fab" @click="openBoardModal" aria-label="커뮤니티 열기" title="커뮤니티">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15a4 4 0 0 1-4 4H7l-4 4V7a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4z" />
          </svg>
        </button>

        <div class="modal-backdrop" :class="{ show: showBoardModal }" @click="closeBoardModal"></div>
        <div class="modal-card" :class="{ show: showBoardModal }">
          <div class="card">
            <div class="modal-header">
              <h4>커뮤니티</h4>
              <button class="modal-close" @click="closeBoardModal" aria-label="닫기">✕</button>
            </div>
            <div class="modal-body">
              <iframe :src="boardUrl"></iframe>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="<%= request.getContextPath() %>/js/reservation-pie.js"></script>
    <script src="<%= request.getContextPath() %>/js/reservation-calendar.js"></script>

    <div id="popup-overlay" class="popup-overlay" style="display:none;"></div>

    <div id="ad-popup" class="img-popup-modal" style="display:none;">
      <div class="popup-body">
        <img src="/images/ad_img.png" alt="광고 팝업" />
      </div>
      <div class="popup-footer">
        <label class="check-label">
          <input type="checkbox" id="today-check" />
          7일 동안 보지 않기
        </label>
        <button type="button" class="close-btn" onclick="closePopup()">닫기 [X]</button>
      </div>
    </div>

    <%@ include file="components/footer.jsp" %>

    <script>
      const app = Vue.createApp({
        data() {
          return {
            themeOptions: [
              { code: "FAMILY", label: "가족" },
              { code: "FRIEND", label: "친구" },
              { code: "COUPLE", label: "연인" },
              { code: "LUXURY", label: "호화스러운" },
              { code: "BUDGET", label: "가성비" },
              { code: "HEALING", label: "힐링" },
              { code: "UNIQUE", label: "이색적인" },
              { code: "ADVENTURE", label: "모험" },
              { code: "QUIET", label: "조용한" },
            ],
            selectedThemes: [],
            sidoList: [],
            sigunguList: [],
            loadingSido: false,
            loadingSigungu: false,
            currentSido: "",
            currentSigungu: "",
            selectedRegions: [],

            /* ✅ Controller에서 넘겨준 값들 */
            budget: <%= request.getAttribute("budget") != null ? request.getAttribute("budget") : 0 %>,
            headCount: <%= request.getAttribute("headCount") != null ? request.getAttribute("headCount") : 0 %>,
            
            /* ✅ [중요] 구독 여부 (기본값 false) */
            isPremium: <%= request.getAttribute("isPremium") != null ? request.getAttribute("isPremium") : false %>,

            spentAccom: 0,
            spentFood: 0,
            spentActivity: 0,
            startDate: null,
            endDate: null,
            selectionState: "start",
            showBoardModal: false,
            boardUrl: ctx + "/modalBoardList.do",
            mapInstance: null,
            geocoder: null,
            markers: [],
            fullPoiList: [],
            activeTab: 12,
            infowindow: null,
            baseMarkerImageSrc: null,
            itinerary: {}, 
            activeDate: null,
            selectedPoi: null,
            activeRegion: "all",
            draggedDate: null,
            draggedIndex: null,
            dragOverDate: null,
            dragOverIndex: null,

            //활용하기
            resNum: "<%= resNum %>",
            list: {},
            detail: {},
            positionsByDay: {},
            selectedDay: 1,
            themes: "",
            
            sessionId: "<%= session.getAttribute("sessionId") != null ? session.getAttribute("sessionId") : "" %>",
          };
        },

        computed: {
          isFormValid() {
            return this.selectedThemes.length > 0 && this.headCount > 0 && this.budget >= 0;
          },
          displayRegion() {
            if (!this.currentSido) return "미선택";
            const s = this.sidoList.find((x) => x.code === this.currentSido)?.name || "";
            const g = this.sigunguList.find((x) => x.code === this.currentSigungu)?.name || "";
            return s + (g ? " " + g : " (전체)");
          },
          regionFilteredList() {
            let list = this.fullPoiList;
            if (this.activeRegion === "all") {
              return list;
            }
            const selected = this.selectedRegions[this.activeRegion];
            if (!selected) {
              return [];
            }
            list = list.filter((poi) => {
              const poiArea = String(poi.areaCode);
              const poiSigungu = String(poi.sigunguCode);
              const selectedArea = String(selected.sidoCode);
              const selectedSigungu = String(selected.sigunguCode);
              if (selected.sigunguCode === null || selected.sigunguCode === "null") {
                return poiArea === selectedArea;
              }
              return poiArea === selectedArea && poiSigungu === selectedSigungu;
            });
            return list;
          },
          filteredPoiList() {
            return this.regionFilteredList.filter((poi) => poi.typeId === this.activeTab);
          },
          dateTabs() {
            if (!this.startDate || !this.endDate) return [];
            let tabs = [];
            let currentDate = new Date(this.startDate);
            let stopDate = new Date(this.endDate);
            let dayCount = 1;
            while (currentDate <= stopDate) {
              const dateStr = currentDate.toISOString().split("T")[0];
              const month = currentDate.getMonth() + 1;
              const day = currentDate.getDate();
              tabs.push({
                date: dateStr,
                label: `${month}월 ${day}일 (${dayCount}일차)`,
              });
              currentDate.setDate(currentDate.getDate() + 1);
              dayCount++;
            }

            return tabs;
          },
          activeDateLabel() {
            if (!this.activeDate || !this.dateTabs.length) return "";
            const activeTab = this.dateTabs.find((d) => d.date === this.activeDate);
            return activeTab ? activeTab.label : "";
          },
          activeItinerary() {
            return this.itinerary[this.activeDate] || [];
          },
          accomBudgetLimit() {
            return Math.floor((this.budget || 0) * (this.weights[1] / 100.0));
          },
          foodBudgetLimit() {
            return Math.floor((this.budget || 0) * (this.weights[2] / 100.0));
          },
          activityBudgetLimit() {
            return Math.floor((this.budget || 0) * (this.weights[3] / 100.0));
          },
        },

        watch: {
          filteredPoiList: function (newList, oldList) {
            this.drawMarkers();
          },
          dateTabs: function (newTabs, oldTabs) {
            if (newTabs.length > 0 && newTabs.length !== oldTabs.length) {
              this.activeDate = newTabs[0].date;
              this.itinerary = {};
              this.selectedPoi = null;
            } else if (newTabs.length === 0 && oldTabs.length > 0) {
              this.activeDate = null;
              this.itinerary = {};
              this.selectedPoi = null;
            }
          },
        },

        methods: {
          async loadSido() {
            const self = this; 
            self.loadingSido = true;
            self.sidoList = [];
            try {
              const data = await $.get(ctx + "/api/areas/sido");
              self.sidoList = Array.isArray(data) ? data : [];
            } catch (e) {
            } finally {
              self.loadingSido = false;
            }
          },

          async loadSigungu() {
            const self = this; 
            self.loadingSigungu = true;
            self.sigunguList = [];
            try {
              if (!self.currentSido) return;
              const data = await $.get(ctx + "/api/areas/sigungu", { areaCode: self.currentSido });
              self.sigunguList = Array.isArray(data) ? data : [];
            } catch (e) {
            } finally {
              self.loadingSigungu = false;
            }
          },

          onChangeSido() {
            this.currentSigungu = "";
            this.sigunguList = [];
            this.loadSigungu();
          },

          toggleTheme(code) {
            const i = this.selectedThemes.indexOf(code);
            if (i === -1) this.selectedThemes.push(code);
            else this.selectedThemes.splice(i, 1);
          },

          labelOf(code) {
            return this.themeOptions.find((t) => t.code === code)?.label || code;
          },
          openBoardModal() {
            this.showBoardModal = true;
          },
          closeBoardModal() {
            this.showBoardModal = false;
          },

          addRegion() {
            if (!this.currentSido) return;
            const sidoName = this.sidoList.find((s) => s.code == this.currentSido)?.name || "";
            
            const sigunguName = this.sigunguList.find((g) => g.code === this.currentSigungu)?.name || "";
            const regionName = sidoName + (sigunguName ? " " + sigunguName : " (전체)");
            const sigunguCodeVal = this.currentSigungu || null;
            const isDuplicate = this.selectedRegions.some((r) => r.sidoCode === this.currentSido && r.sigunguCode === sigunguCodeVal);

            if (!isDuplicate) {
              this.selectedRegions.push({
                sidoCode: this.currentSido,
                sigunguCode: sigunguCodeVal,
                name: regionName,
              });
            } else {
              alert("이미 추가된 지역입니다.");
            }

            this.currentSido = "";
            this.currentSigungu = "";
            this.sigunguList = [];
          },

          removeRegion(index) {
            this.selectedRegions.splice(index, 1);
            if (this.activeRegion == index) {
              this.activeRegion = "all";
            }
          },

          onRegionChange() {
            this.selectedPoi = null;
            if (this.infowindow) {
              this.infowindow.close();
            }
            if (this.activeRegion === "all") {
              if (this.fullPoiList.length > 0) {
                this.panToFirstPoi(this.fullPoiList);
              }
            } else {
              const region = this.selectedRegions[this.activeRegion];
              if (region && this.geocoder && this.mapInstance) {
                const address = region.name;
                this.geocoder.addressSearch(address, (result, status) => {
                  if (status === kakao.maps.services.Status.OK) {
                    const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    this.mapInstance.panTo(coords);
                    const level = region.sigunguCode ? 7 : 9;
                    this.mapInstance.setLevel(level);
                  }
                });
              }
            }
          },

          setActiveTab(typeId) {
            this.activeTab = typeId;
            this.selectedPoi = null;
            if (this.infowindow) {
              this.infowindow.close();
            }
          },

          countForTab(typeId) {
            return this.regionFilteredList.filter((p) => p.typeId === typeId).length;
          },

          async fnCreate() {
            const self = this; 

            if (self.selectedRegions.length === 0) {
              if (self.currentSido) {
                alert("지역을 선택한 후 '+' 버튼을 눌러 목록에 추가해주세요.");
              } else {
                alert("방문할 지역을 1개 이상 선택해주세요.");
              }
              return;
            }

            try {
                const limitCheck = await $.ajax({
                    url: "/api/recommend/check-limit",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ userId: self.sessionId })
                });

                if (limitCheck.status === "limit_exceeded") {
                    document.getElementById("ad-popup").style.display = "block";
                    document.getElementById("popup-overlay").style.display = "block";
                    return; 
                }
                
                if (!limitCheck.isPremium && limitCheck.status === "success") {
                    alert(`무료 횟수가 차감되었습니다. (남은 횟수: ${limitCheck.remain}회)`);
                }
            } catch (e) {
                console.error("횟수 체크 실패", e);
            }

            const el = document.getElementById("debugOut");
            const generateParam = {
              themes: self.selectedThemes,
              regions: self.selectedRegions,
              headCount: self.headCount,
              budget: self.budget,
              startDate: self.startDate,
              endDate: self.endDate,
              budgetWeights: {
                etc: self.weights[0],
                accom: self.weights[1],
                food: self.weights[2],
                act: self.weights[3],
              },
            };

            if (el) el.textContent = "===== POI 조회 중... =====";
            self.fullPoiList = [];
            self.clearMarkers(); 
            self.activeRegion = "all";

            try {
              const response = await $.ajax({
                url: ctx + "/api/recommend/generate",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(generateParam),
              });
              self.fullPoiList = response;
              if (el) el.textContent = "POI 로드 완료. (총 " + response.length + "개)";

              if (response.length > 0) {
                self.panToFirstPoi(response); 
              }
            } catch (e) {
              if (el) el.textContent = "API 호출 실패: " + (e.responseJSON?.message || e.responseText || e.statusText);
              return;
            }
          },

          async fnSaveTrip() {
            const self = this; 

            const totalItems = Object.values(self.itinerary).flat().length;
            if (totalItems === 0) {
              alert("일정에 추가된 항목이 없습니다. 코스를 먼저 지도에서 선택해주세요.");
              return;
            }

            if (self.selectedRegions.length === 0 || !self.startDate || !self.endDate || self.headCount <= 0) {
              alert("여행 정보 (지역, 일정, 인원)를 먼저 입력해주세요.");
              return;
            }

            if (!confirm("현재 작성된 일정으로 최종 코스를 확정하고 예약 내역을 보시겠습니까?")) {
              return;
            }

            const saveParam = {
              themes: self.selectedThemes,
              regions: self.selectedRegions,
              headCount: self.headCount,
              budget: self.budget,
              startDate: self.startDate,
              endDate: self.endDate,
              budgetWeights: {
                etc: self.weights[0],
                accom: self.weights[1],
                food: self.weights[2],
                act: self.weights[3],
              },
              itinerary: self.itinerary,
            };

            try {
              const saveResponse = await $.ajax({
                url: ctx + "/api/reservation/save", 
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(saveParam),
              });

              const resNum = saveResponse.resNum;

              if (resNum) {
                alert("코스가 성공적으로 저장되었습니다. 예약 내역 페이지로 이동합니다.");
                window.location.href = ctx + "/reservation-view.do?resNum=" + resNum;
              } else {
                alert("코스 저장에 실패했습니다. (여행 ID 누락 - 서버 응답 확인 필요)");
              }
            } catch (e) {
              alert("최종 일정 저장 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            }
          },

          initMap() {
            if (!window.kakao || !window.kakao.maps) {
              const mapEl = document.getElementById("map-recommend");
              if (mapEl)
                mapEl.innerHTML = "<h4 style='text-align:center; padding-top: 20px;'>카카오맵 SDK 로딩 실패. API 키(appkey)를 확인하세요.</h4>";
              return;
            }
            const mapContainer = document.getElementById("map-recommend");
            if (!mapContainer) {
              return;
            }
            const mapOption = {
              center: new kakao.maps.LatLng(36.2, 127.6),
              level: 12,
            };
            this.mapInstance = new kakao.maps.Map(mapContainer, mapOption);
            this.geocoder = new kakao.maps.services.Geocoder();
            this.infowindow = new kakao.maps.InfoWindow({
              content: "",
              removable: true,
            });

            const cacheBuster = "?v=" + new Date().getTime();
            this.baseMarkerImageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png" + cacheBuster;
          },

          clearMarkers() {
            if (this.infowindow) {
              this.infowindow.close();
            }
            for (let marker of this.markers) {
              marker.setMap(null);
            }
            this.markers = [];
            this.selectedPoi = null;
          },

          drawMarkers() {
            if (!this.mapInstance) return;
            this.clearMarkers();

            const listToDraw = [...this.filteredPoiList].sort((a, b) => {
              const scoreA = a.score || 0;
              const scoreB = b.score || 0;
              return scoreB - scoreA;
            });

            if (listToDraw.length === 0) return;

            const totalCount = listToDraw.length;
            const top10Cutoff = Math.floor(totalCount * 0.1);
            const top30Cutoff = Math.floor(totalCount * 0.3);
            const top50Cutoff = Math.floor(totalCount * 0.5);

            for (const [index, poi] of listToDraw.entries()) {
              const mapy_num = parseFloat(poi.mapy);
              const mapx_num = parseFloat(poi.mapx);
              if (isNaN(mapy_num) || isNaN(mapx_num)) {
                continue;
              }

              let imgSize;
              if (index < top10Cutoff) {
                imgSize = 45;
              } else if (index < top30Cutoff) {
                imgSize = 30;
              } else if (index < top50Cutoff) {
                imgSize = 20;
              } else {
                imgSize = 10;
              }

              const markerImage = new kakao.maps.MarkerImage(this.baseMarkerImageSrc, new kakao.maps.Size(imgSize, imgSize), {
                offset: new kakao.maps.Point(imgSize / 2, imgSize / 2),
              });

              const marker = new kakao.maps.Marker({
                map: this.mapInstance,
                position: new kakao.maps.LatLng(mapy_num, mapx_num),
                title: poi.title + " (점수: " + (poi.score || 0).toFixed(2) + ")",
                image: markerImage,
              });

              kakao.maps.event.addListener(marker, "click", () => {
                this.selectedPoi = poi;
                if (poi.price === undefined) {
                  this.fetchPoiPrice(poi);
                } else {
                  this.updateInfowindowContent(poi, poi.price);
                }
              });

              this.markers.push(marker);
            }
          },

          async fetchPoiPrice(poi) {
            this.updateInfowindowContent(poi, null);
            try {
              const response = await $.get(ctx + "/api/recommend/getPrice", {
                contentId: poi.contentId,
                typeId: poi.typeId,
                startDate: this.startDate,
              });
              poi.price = response.price;
              if (this.selectedPoi && this.selectedPoi.contentId === poi.contentId) {
                this.selectedPoi.price = response.price;
              }
              this.updateInfowindowContent(poi, response.price);
            } catch (e) {
              poi.price = 0;
              if (this.selectedPoi && this.selectedPoi.contentId === poi.contentId) {
                this.selectedPoi.price = 0;
              }
              this.updateInfowindowContent(poi, 0);
            }
          },

          updateInfowindowContent(poi, price) {
            const title = poi.title || "이름 없음";
            let imageUrl = poi.firstimage2 || poi.firstimage;
            let isValidImage = imageUrl && imageUrl !== "false" && imageUrl.trim() !== "";
            if (isValidImage && imageUrl.startsWith("http://")) imageUrl = imageUrl.replace("http://", "https://");

            const searchUrl = `https://search.naver.com/search.naver?query=${encodeURIComponent(title)}`;
            let priceText = "";

            if (price === null) {
              priceText = `<span style="font-size: 12px; color: #888;">(가격 조회 중...)</span>`;
            } else if (price > 0) {
              priceText = `<span style="font-size: 13px; color: #d9480f; font-weight: bold;">${price.toLocaleString()}원~</span>`;
            } else {
              priceText = `<span style="font-size: 12px; color: #888;">(가격 미제공/문의)</span>`;
            }

            if (poi.typeId === 12) priceText = "";

            const imageHtml = isValidImage
              ? `<img src="${imageUrl}" width="180" height="120" style="object-fit: cover; border: 1px solid #ccc; border-radius: 4px; max-width: 100%;">`
              : `<div style="width: 180px; height: 120px; background: #f0f0f0; border: 1px solid #ccc; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: #888; font-size: 12px;">(이미지 없음)</div>`;

            const content = `
                  <div style="padding:7px; width: 200px; text-align: center; box-sizing: border-box;">
                    ${imageHtml}
                    <div style="font-weight: bold; margin-top: 5px; font-size: 13px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                        <a href="${searchUrl}" target="_blank" title="네이버 검색" style="color: inherit; text-decoration: none;">
                          ${title} <i class="fa-solid fa-arrow-up-right-from-square" style="font-size: 11px; color: #888;"></i>
                        </a>
                    </div>
                    <div style="margin-top: 4px;">${priceText}</div>
                  </div>
                `;

            this.infowindow.setContent(content);
            const position = new kakao.maps.LatLng(parseFloat(poi.mapy), parseFloat(poi.mapx));
            this.infowindow.open(this.mapInstance, new kakao.maps.Marker({ position: position }));
          },

          panToFirstPoi(poiList) {
            if (!this.mapInstance || !poiList || poiList.length === 0) return;
            const firstPoi = poiList[0];
            const firstMapy = parseFloat(firstPoi.mapy);
            const firstMapx = parseFloat(firstPoi.mapx);
            if (isNaN(firstMapy) || isNaN(firstMapx)) return;
            const coords = new kakao.maps.LatLng(firstMapy, firstMapx);
            this.mapInstance.panTo(coords);
            this.mapInstance.setLevel(7);
          },

         addPoiToItinerary() {
              if (!this.activeDate || !this.selectedPoi) return;

              if (this.selectedPoi.price === undefined) {
                alert("가격 정보를 로드 중입니다. 잠시 후 다시 시도해주세요.");
                return;
              }
              const poiPrice = this.selectedPoi.price || 0;
              const poiType = this.selectedPoi.typeId;

              // ✅ [요청 반영] 구독자(Premium)만 예산 초과 체크
              // 무료 회원은 예산 초과 여부 상관없이 추가 가능
              if (this.isPremium) {
                  if (poiType === 32) { // 숙박
                       if (this.spentAccom + poiPrice > this.accomBudgetLimit) {
                           alert("숙박 예산을 초과했습니다.\n(설정된 예산 범위를 조절하거나 다른 장소를 선택하세요)");
                           return; // 추가 차단
                       }
                  } else if (poiType === 39) { // 식당
                       if (this.spentFood + poiPrice > this.foodBudgetLimit) {
                           alert("식당 예산을 초과했습니다.\n(설정된 예산 범위를 조절하거나 다른 장소를 선택하세요)");
                           return; // 추가 차단
                       }
                  } else if (poiType === 12) { // 체험/관광
                       // 체험/관광은 가격이 있더라도 예산 체크를 느슨하게 하거나 제외할 수 있습니다.
                       if (this.spentActivity + poiPrice > this.activityBudgetLimit) {
                            alert("체험/관광 예산을 초과했습니다.");
                            return; 
                       }
                  }
              }
              
              if (poiType === 32) this.spentAccom += poiPrice;
              else if (poiType === 39) this.spentFood += poiPrice;
              else if (poiType === 12) this.spentActivity += poiPrice;
              
              if (!this.itinerary[this.activeDate]) {
                this.itinerary[this.activeDate] = [];
              }
              this.itinerary[this.activeDate].push({ ...this.selectedPoi, price: poiPrice });
               this.selectedPoi = null;
              if (this.infowindow) this.infowindow.close();
          },

          removePoiFromItinerary(date, index) {
            if (this.itinerary[date] && this.itinerary[date].length > index) {
              const removedPoi = this.itinerary[date].splice(index, 1)[0];
              const poiPrice = removedPoi.price || 0;
              
              if (poiPrice > 0) {
                if (removedPoi.typeId === 32) this.spentAccom -= poiPrice;
                else if (removedPoi.typeId === 39) this.spentFood -= poiPrice;
                else if (removedPoi.typeId === 12) this.spentActivity -= poiPrice;
              }
            }
          },

          onDragStart(date, index) {
            this.draggedDate = date;
            this.draggedIndex = index;
            this.selectedPoi = null;
            if (this.infowindow) {
              this.infowindow.close();
            }
          },
          onDragOver(date, index) {
            if (date !== this.draggedDate) {
              this.dragOverDate = null;
              this.dragOverIndex = null;
              return;
            }
            if (index !== this.draggedIndex && index !== this.dragOverIndex) {
              this.dragOverDate = date;
              this.dragOverIndex = index;
            }
          },
          onDragLeave() {
            this.dragOverDate = null;
            this.dragOverIndex = null;
          },
          onDrop(date, droppedIndex) {
            if (date !== this.draggedDate || this.draggedIndex === null || this.draggedIndex === droppedIndex) {
              this.onDragEnd();
              return;
            }
            const list = this.itinerary[date];
            const draggedItem = list.splice(this.draggedIndex, 1)[0];
            list.splice(droppedIndex, 0, draggedItem);
            this.onDragEnd();
          },
          onDragEnd() {
            this.draggedDate = null;
            this.draggedIndex = null;
            this.dragOverDate = null;
            this.dragOverIndex = null;
          },

          isDragging(date, index) {
            return this.draggedDate === date && this.draggedIndex === index;
          },
          isDragOver(date, index) {
            return this.dragOverDate === date && this.dragOverIndex === index;
          },
          
          fninfo() {
            let self = this;
            $.ajax({
              url: "/active.dox",
              type: "GET",
              data: { resNum: self.resNum },
              success(data) {
                self.list = data.list[0];
                self.detail = data.detail;
                self.themes = data.list[0].themnum || "";
                self.selectedThemes = self.themes.split(/[,/]/);
                self.currentSido = data.list[0].areaNum;
                self.onChangeSido();
                self.startDate = data.list[0].sdate;
                self.endDate = data.list[0].edate;
                self.budget = data.list[0].price;
                self.itinerary = {};
                
                self.$nextTick(() => {
                  for (let dayKey in self.detail) {
                    self.detail[dayKey].forEach((item) => {
                      self.selectedPoi = {
                        title: item.title,
                        mapy: parseFloat(item.mapy),
                        mapx: parseFloat(item.mapx),
                        dayNum: item.dayNum,
                        reserv_date: item.reserv_date,
                        addr1: item.addr1,
                        contentId: item.contentid,
                        day: item.day,
                        overview: item.overview,
                        firstimage: item.firstimage || null,
                        price: item.price || 0,
                        typeId: parseInt( item.typeId),
                      };
                      
                      self.activeDate = item.day;
                      self.addPoiToItinerary();
                    });
                  }
                  self.fullPoiList = Object.values(self.itinerary).flat();
                  if (self.dateTabs && self.dateTabs.length > 0) {
                    self.selectedDay = self.dateTabs[0].date;
                  }
                  self.drawMarkers();
                });
              },
              error(err) {
              },
            });
          },
        },

        async mounted() {
          let self = this;
          if (self.sessionId == "" || self.sessionId == "null") {
            alert("로그인 후 이용해주세요.");
            location.href = "/member/login.do";
            return;
          }
          await this.loadSido();
          this.initMap();
          if (self.resNum && self.resNum !== "null" && self.resNum !== "") {
            self.fninfo();
          }

          if (!this.isPremium) {
              this.locks = [true, true, true, true]; 
              this.$nextTick(() => {
                  if(typeof this.drawPie === 'function') this.drawPie();
              });
          }
        },
      });

      app.mixin(window.ReservationPieMixin);
      app.mixin(window.ReservationCalendarMixin);

      app.mount("#app");

      /* [수정됨] 팝업 제어 로직 */
      document.addEventListener("DOMContentLoaded", function () {
        const popup = document.getElementById("ad-popup");
        const overlay = document.getElementById("popup-overlay");
        
        if (!popup || !overlay) return;

        const expiry = localStorage.getItem("ad-expiry");
        const now = new Date().getTime();

        if (!expiry || now > parseInt(expiry)) {
          popup.style.display = "block";
          overlay.style.display = "block";
        } else {
          popup.style.display = "none";
          overlay.style.display = "none";
        }
      });

      function closePopup() {
        const popup = document.getElementById("ad-popup");
        const overlay = document.getElementById("popup-overlay");
        const isChecked = document.getElementById("today-check")?.checked;

        if (isChecked) {
          const expiryDate = new Date().getTime() + (7 * 24 * 60 * 60 * 1000);
          localStorage.setItem("ad-expiry", expiryDate);
        }

        if(popup) popup.style.display = "none";
        if(overlay) overlay.style.display = "none";
      }
    </script>
  </body>
</html>