<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<script src="https://code.highcharts.com/highcharts.js"></script>
<style>
.dashboard-cards {
  display: flex;
  gap: 20px;
  margin: 20px 0 30px 0;
}

.dashboard-card {
  flex: 1;
  background: #ffffff;
  border-radius: 14px;
  padding: 14px 16px;   /* ⬅ 기존 20px → 줄임 */
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  text-align: center;
}

.card-title {
  font-size: 13px;
  color: #666;
  margin-bottom: 6px;  /* ⬅ 기존 10px */
}

.card-value {
  font-size: 26px;     /* ⬅ 살짝 줄임 */
  font-weight: bold;
  line-height: 1.2;    /* ⬅ 중요 */
  margin: 0;
}

@keyframes ledGlow {
  0% {
    box-shadow:
      0 0 4px rgba(231,76,60,0.5),
      0 0 8px rgba(231,76,60,0.4);
    opacity: 0.6;
  }
  50% {
    box-shadow:
      0 0 10px rgba(231,76,60,1),
      0 0 18px rgba(231,76,60,0.8);
    opacity: 1;
  }
  100% {
    box-shadow:
      0 0 4px rgba(231,76,60,0.5),
      0 0 8px rgba(231,76,60,0.4);
    opacity: 0.6;
  }
}

/* 기본 led-dot */
.led-dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  margin-left: 6px;
  border-radius: 50%;
  background: #e74c3c;
}

/* 발광 단계 */
.led-dot.alert {
  animation: ledGlow 2.6s ease-in-out infinite;
}

.led-dot.danger {
  animation: ledGlow 1.4s ease-in-out infinite;
}

.canClick {
  
}
.canClick:hover {
  cursor: pointer; 
}
</style>

<!-- <h2>대시보드</h2> -->

<div id="dashboardApp">
  <!-- 상단 카드 영역 -->
  <div class="dashboard-cards">

    <div 
      class="dashboard-card canClick"
      @click="goToNav('userManage')"
    >
      <p class="card-title">총 회원수</p>
      <p class="card-value normal">{{ memberCnt }}</p>
    </div>

    <div 
      class="dashboard-card canClick"
      :class="{alert: reportCnt > 0,danger: reportCnt > 10}"
      @click="goToNav('report')"
    >
      <p class="card-title">
        <span class="led-dot"
              :class="{alert: reportCnt > 0,danger: reportCnt > 10}"
              v-if="reportCnt > 0">
        </span>
        미처리 신고 수
      </p>
      <p class="card-value alert">{{ reportCnt }}</p>
    </div>

    <div class="dashboard-card canClick"
      :class="{alert: reportCnt > 0,danger: reportCnt > 10}"
       @click="goToNav('inquiry')"
    >
    <p class="card-title">
        <span class="led-dot"
              :class="{ alert: unansweredCnt > 0,danger: unansweredCnt > 10}"
              v-if="unansweredCnt > 0">
        </span>
        미처리 답변 수
      </p>
      <p class="card-value alert">{{ unansweredCnt }}</p>
    </div>
  </div>

  <!-- 차트 영역 -->
  <div id="topThemeChart" style="margin-top: 30px;"></div>
</div>

<script>
(function() {
  const app = Vue.createApp({
    data() {
      return {
        memberCnt: 0,
        reportCnt: 0,
        unansweredCnt: 0
      };
    },
    methods: {
      fnGetCnt() {
        let self = this;
        let param = {
          
        };
        $.ajax({
          url: "/admin/getCNT.dox",
          dataType: "json",
          type: "POST",
          data: param,
          success: function (data) {
            // console.log(data);
            self.memberCnt = data.userCnt;
            self.reportCnt = data.reportCnt;
            self.unansweredCnt = data.inquiryCnt;
          },
        });
      },

      goToNav(type) {
        // navChild 활성화 처리
        document.querySelectorAll('.navChild').forEach(item => {
          item.classList.remove('active');
        });
        const targetNav = document.querySelector(`.navChild[data-type="${type}"]`);
        if(targetNav) targetNav.classList.add('active');

        // admin-nav-change 이벤트 발생
        window.dispatchEvent(new CustomEvent('admin-nav-change', {
          detail: { type: type }
        }));

        // dashboardApp 숨기기
        document.getElementById('dashboardApp').style.display = 'none';
      },

      getTopTheme() {
        let self = this;
        let param = {};
        
        $.ajax({
          url: "/admin/getTopTheme.dox",
          dataType: "json",
          type: "POST",
          data: param,
          success: function (data) {
            // console.log(data);
            
            if(data.result === "success" && data.topTheme) {
              self.renderTopThemeChart(data.topTheme);
            }
          },
        });
      },

      renderTopThemeChart(themeData) {
        // 월별로 데이터 그룹화
        const monthlyData = {};
        
        themeData.forEach(item => {
          if (!monthlyData[item.MONTH]) {
            monthlyData[item.MONTH] = [];
          }
          monthlyData[item.MONTH].push(item);
        });
        
        // 월 정렬
        const sortedMonths = Object.keys(monthlyData).sort();
        
        // 차트 데이터 준비
        const categories = sortedMonths.map(month => {
          const parts = month.split('-');      // *** 변경: 배열로 받기
          const year = parts[0];                // *** 변경: 인덱스로 접근
          const monthNum = parts[1];            // *** 변경: 인덱스로 접근
          return year + '년 ' + monthNum + '월'; // *** 변경: + 연산자로 문자열 연결
        });

        // console.log(sortedMonths);
        // console.log(categories);
        
        // 각 순위별 시리즈 데이터 준비
        const rank1Data = [];
        const rank2Data = [];
        const rank3Data = [];
        
        sortedMonths.forEach(month => {
          const themes = monthlyData[month];
          
          // RN(순위)에 따라 데이터 분류
          const rank1 = themes.find(t => t.RN === 1);
          const rank2 = themes.find(t => t.RN === 2);
          const rank3 = themes.find(t => t.RN === 3);
          
          rank1Data.push({
            y: rank1 ? rank1.THEMECNT : 0,
            name: rank1 ? rank1.THEME : '',
            amount: rank1 ? rank1.TOTAL_AMOUNT : 0
          });
          
          rank2Data.push({
            y: rank2 ? rank2.THEMECNT : 0,
            name: rank2 ? rank2.THEME : '',
            amount: rank2 ? rank2.TOTAL_AMOUNT : 0
          });
          
          rank3Data.push({
            y: rank3 ? rank3.THEMECNT : 0,
            name: rank3 ? rank3.THEME : '',
            amount: rank3 ? rank3.TOTAL_AMOUNT : 0
          });
        });
        
        // Highcharts 차트 생성
        Highcharts.chart('topThemeChart', {
          chart: {
            type: 'column'
          },
          title: {
            text: '월별 인기 테마 TOP 3',
            style: {
              fontSize: '18px',
              fontWeight: 'bold'
            }
          },
          xAxis: {
            categories: categories,
            title: {
              text: '월 별'
            }
          },
          yAxis: {
            min: 0,
            title: {
              text: '예약 건수'
            }
          },
          tooltip: {
            formatter: function() {
              return '<b>' + this.x + '</b><br/>' +
                    '<b>테마:</b> ' + this.point.name + '<br/>' +
                    '<b>예약 건수:</b> ' + this.y + '건<br/>' 
                    // +'<b>총 매출:</b> ' + this.point.amount.toLocaleString() + '원';
            }
          },
          plotOptions: {
            column: {
              pointPadding: 0.2,
              borderWidth: 0,
              dataLabels: {
                enabled: true,
                formatter: function() {
                  return this.point.name;
                },
                style: {
                  fontSize: '10px',
                  fontWeight: 'bold'
                }
              }
            }
          },
          legend: {
            enabled: true
          },
          series: [{
            name: '1위',
            data: rank1Data,
            color: '#3498db'
          }, {
            name: '2위',
            data: rank2Data,
            color: '#2ecc71'
          }, {
            name: '3위',
            data: rank3Data,
            color: '#f39c12'
          }]
        });
      }
    },
    mounted() {
      let self = this;
      self.fnGetCnt();
      // self.getTopTheme();

      // Highcharts 로드 대기
      const checkHighcharts = setInterval(() => {
        if (typeof Highcharts !== 'undefined') {
          clearInterval(checkHighcharts);
          self.getTopTheme();
        }
      }, 50);
    }
  });
  window.currentVueApp = app;

  app.mount('#dashboardApp');
})();
</script>
