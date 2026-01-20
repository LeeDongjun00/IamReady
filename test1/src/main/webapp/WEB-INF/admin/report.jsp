<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<script src="/js/page-change.js"></script>

<style>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal {
  background: #fff;
  padding: 20px 30px;
  border-radius: 8px;
  min-width: 300px;
}

.reportTip {
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.reportContents img {
  max-width: 250px;
  height: auto;
}

.user-deleted {
  /* 탈퇴 */
  color: #9E9E9E;
  text-decoration: line-through;
}
.user-blocked {
  /* 차단 */
  color: #E53935;
  font-weight: bold;
}
.user-normal {
  /* 일반 */
  color: #0080ff;
}
.user-admin {
  /* 관리자 */
  color: #5E35B1;
  font-weight: bold;
}
.report-processed {
  /* 처리된 신고 */
  text-decoration: line-through;
  color: #9E9E9E;
}

.processed {
  /* display: inline-block; */
  margin-left: 20px;
  margin-bottom: 10px;
  margin-right: 2%;
}

.modalCloseAndFeedView {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 15px;
}
.modalCloseAndFeedView span {
  cursor: pointer;
  color: #007BFF;
  font-style: oblique;
}
</style>

<h2>신고 관리</h2>

<div id="reportApp">
  <div style="display:flex; justify-content:flex-end; margin-bottom:10px; padding-right: 2%;">
    <label style="margin-right:6px;">표시 개수</label>
    <select v-model="pageSize" @change="changePageSize">
      <option value="5">5개</option>
      <option value="10">10개</option>
      <option value="15">15개</option>
    </select>
  </div>

  <div class="reportTip">
    ※신고글 번호를 클릭하여 내용 확인※
    <div class="processed">
      <select name="" id="" @change="fnTest" v-model="processedFilter">
        <option value="all">::전체::</option>
        <option value="processed">처리</option>
        <option value="unprocessed">미처리</option>
      </select>
    </div>
  </div>
  <!-- 신고 관리용 테이블 -->
  <table style="width: 98%;">
    <tr>
      <th>신고 번호</th>
      <th>신고 유형</th>
      <th>세부 유형</th>
      <th>신고글 번호</th>
      <!-- <th>신고된 회원 ID</th>
      <th>신고된 회원 닉네임</th> -->
      <th>신고 대상(아이디, 닉네임)</th>
      <th>신고 사유</th>
      <th>신고자</th>
      <th>처리</th>
    </tr>
    <tr 
      v-for="item in list" 
      :key="item.REPORTNUM"
      :class="{ 'report-processed': item.REPORT_PROCESS === 'Y' }"
      :style="{ pointerEvents: item.REPORT_PROCESS === 'Y' ? 'none' : 'auto' }">
        <td>{{ item.REPORTNUM }}</td>
        <td>
            <span v-if="item.BOARDNO1 != null">게시글 신고</span>
            <span v-else>댓글 신고</span>
        </td>
        <td>
            <span v-if="item.REPORT_TYPE === 'E'">오류 제보</span>
            <span v-else-if="item.REPORT_TYPE === 'I'">불편 사항</span>
            <span v-else-if="item.REPORT_TYPE === 'S'">사기 신고</span>
            <span v-else>기타 신고</span>
        </td>
        <td>
          <a href="javascript:;" @click="fnGetInfo(item.REPORTED_USER_ID, item.BOARDNO2, item.COMMENTNO)"><span v-if="item.COMMENTNO != null">{{item.BOARDNO2}}</span></a>
          <a href="javascript:;" @click="fnGetInfo(item.REPORTED_USER_ID, item.BOARDNO1, null)"><span v-else>{{item.BOARDNO1}}</span></a>
        </td>
        <td>
          <a href="javascript:;" @click="fnUserManage(item.REPORTED_USER_ID, item.DELETED_YN, item.STATUS)" :class="getUserStatus(item.STATUS, item.DELETED_YN)">
            <span v-if="item.REPORTED_NICKNAME != null">{{item.REPORTED_USER_ID}} / {{item.REPORTED_NICKNAME}}</span>
            <span v-else>{{item.REPORTED_USER_ID}} / 탈퇴한 사용자</span>
          </a>

          
        </td>
        <td>{{item.CONTENT}}</td>
        <td>{{item.REPORT_USER_ID}}</td>

        <td><button @click="fnReportY(item.REPORTNUM)" :disabled="item.REPORT_PROCESS === 'Y'">확인</button></td>
    </tr>
  </table>

  <!-- 페이징용 -->
  <div style="margin-top:15px; text-align:center;">
    <!-- 이전 -->
    <span
      v-if="page > 1"
      @click="goPage(page - 1)"
      style="margin:0 8px; cursor:pointer;"
    >
      ◀
    </span>

    <!-- 페이지 번호 -->
    <span
      v-for="p in totalPages"
      :key="p"
      @click="goPage(p)"
      :style="{
        margin: '0 6px',
        cursor: 'pointer',
        fontWeight: page === p ? 'bold' : 'normal',
        color: page === p ? '#000' : '#888'
      }"
    >
      {{ p }}
    </span>

    <!-- 다음 -->
    <span
      v-if="page < totalPages"
      @click="goPage(page + 1)"
      style="margin:0 8px; cursor:pointer;"
    >
      ▶
    </span>
  </div>

  <!-- 밴 관리 영역 -->
  <div v-if="showBanBox" style="margin-top:20px; padding:15px; border:1px solid #ccc;">
    <h3>회원 관리</h3>

    <p>
      대상 사용자 :
      <strong>{{ selectedUserId }}</strong>
    </p>

    <p v-if="selectedUserStatus === 'B'" style="color:red;">
      ⚠ 이미 차단된 사용자입니다.
    </p>

    <p v-else>
      해당 사용자를 <strong>차단</strong>하시겠습니까?
    </p>

    <!-- <textarea
      placeholder="차단 사유를 입력하세요"
      style="width:100%; height:80px;"
    ></textarea> -->

    <div style="margin-top:10px;">
      <button @click="fnBanUser">차단</button>
      <button @click="showBanBox = false">취소</button>
    </div>
  </div>

  <!-- 모달 -->
   <div v-if="showModal" class="modal-overlay" @click.self="closeModal">
    <div class="modal">
      <h3>신고 정보</h3>
      <div>
        <p>신고자 : {{ reportInfo.reportUserId }}</p>
        <p>신고 대상 : {{ reportInfo.reportedUserId }}</p>
        <p>신고 사유 : {{ reportInfo.content }}</p>
      </div>
      <h3>신고 사항</h3>
      <div>
        
        <div v-if="!reportInfo.commentNo && !reportInfo.boardNo">
          <p>신고 게시글이 삭제되었습니다.</p>
        </div>

        <div v-else-if="!reportInfo.commentNo">
          <p>신고 게시글 번호 : {{ reportInfo.boardNo }}</p>
          <p>신고 게시글 제목 : {{ reportInfo.title }}</p>
          <p>신고 게시글 내용 : </p>
          <p class="reportContents" v-html="reportInfo.boardContents"></p>
          
        </div>

        <div v-else>
          <p>신고 게시글 번호 : {{ reportInfo.boardNo }}</p>
          <p>신고 댓글 번호 : {{ reportInfo.commentNo }}</p>
          <p>신고 댓글 내용 : {{ reportInfo.commentContents }}</p>
        </div>
      </div>

      <div class="modalCloseAndFeedView">
        <button @click="closeModal">닫기</button>
        <span @click="fnMove(reportInfo.boardNo)">해당 게시글로 이동</span>
      </div>
    </div>
  </div>
</div>

<script>
  
(function() {
  const app = Vue.createApp({
    data() {
      return {
        list:[],
        showModal: false,
        selectedBoardNo: null,
        selectedCommentNo: null,
        reportedUserId: null,

        reportInfo: {},

        selectedUserId: null,
        selectedUserStatus: null,
        selectedDeletedYn: null,

        showBanBox: false,

        page: 1,
        pageSize: 5,
        totalCnt : 0,

        processedFilter: 'all',
      };
    },
    methods: {
      fnTest() {
        // console.log("선택된 처리 상태:", this.processedFilter);
        let self = this;
        self.page = 1; // 필터 변경 시 1페이지로
        self.loadReport();
        self.fnReportCnt();
      },

      async loadReport() {
          let self = this;

        try {
          const response = await fetch(
            "/admin/report.dox"
            + "?page=" + this.page 
            + "&pageSize=" + this.pageSize
            + "&processedFilter=" + this.processedFilter
          );
          if (!response.ok) {
            throw new Error('서버 응답 오류');
          }

          const data = await response.json();

          // console.log(data.reportList);
          
          self.list = data.reportList;

          console.log(self.list);

        } catch (error) {
          console.error('대시보드 데이터 조회 실패', error);
        }
      },

      fnGetInfo(reportedUserId, boardNo, commentNo) {
        this.reportedUserId = reportedUserId;
        this.selectedBoardNo = boardNo;
        this.selectedCommentNo = commentNo;

        this.fnGetBoardComment();

        this.showModal = true;
      },
      closeModal() {
        this.showModal = false;
        this.selectedBoardNo = null;
        this.selectedCommentNo = null;
        this.reportedUserId = null;
      },

      fnGetBoardComment() {
        let self = this;
        let param = {
          boardNo: self.selectedBoardNo,
          commentNo: self.selectedCommentNo
        };
        // if(self.selectedCommentNo){
        //   param.commentNo = self.selectedCommentNo;
        // }
        $.ajax({
            url: "/admin/getrbc.dox",
            dataType: "json",
            type: "POST",
            data: param,
            success: function (data) {
              
              if(data.result == "success"){
                // console.log(data);
                self.reportInfo = data.info[0];
                console.log(self.reportInfo);
              } else {
                console.log("오류 발생")
              }
            }
        });
      },

      fnUserManage(reportedUserId, deletedYn, status){
        let self = this;
        if(deletedYn === 'Y' || !deletedYn) {
          alert("탈퇴한 사용자입니다.");
          return;
        } 

        self.selectedUserId = reportedUserId;
        self.selectedUserStatus = status;
        self.selectedDeletedYn = deletedYn;

        self.showBanBox = true;
      },

      getUserStatus(status, deletedYn) {
        if (deletedYn === 'Y' || !deletedYn) {
          return 'user-deleted';
        } else {
          if(status === 'B') {
            return 'user-blocked';
          }
          else if (status === 'A') {
            return 'user-admin';
          }
          else if (status === 'U'|| status === 'S') {
            return 'user-normal';
          }
        }
      },

      fnReportY(reportNum) {
        // alert("신고 처리 대상: " + reportNum);
        let self = this;
        let param = {
          reportNum: reportNum
        };
        $.ajax({
            url: "/admin/reportY.dox",
            dataType: "json",
            type: "POST",
            data: param,
            success: function (data) {
                console.log(data.result);
              if(data.result == "success"){
                console.log(data);
                self.loadReport();
                
              } else {
                console.log("오류 발생")
              }
            }
        });
      },

      fnBanUser() {
        let self=this;
        // alert("사용자 차단: " + this.selectedUserId);
        let param = {
          userId: self.selectedUserId
        };
        $.ajax({
            url: "/admin/banUser.dox",
            dataType: "json",
            type: "POST",
            data: param,
            success: function (data) {
                console.log(data.result);
              if(data.result == "success"){
                console.log(data);
                self.loadReport();
                self.showBanBox = false;
              } else {
                console.log("오류 발생")
              }
            }
        });
      },

      fnReportCnt() {
        let self = this;
        let param = {
          processedFilter: self.processedFilter
        };
        $.ajax({
            url: "/admin/reportCnt.dox",
            dataType: "json",
            type: "POST",
            data: param,
            success: function (data) {
                // console.log(data.result);
              if(data.result == "success"){
                console.log(data);
                // self.loadReport();
                // self.showBanBox = false;
                self.totalCnt = data.CNT;
                console.log("총 신고 건수: " + self.totalCnt);
              } else {
                console.log("오류 발생")
              }
            }
        });
      },

      goPage(p) {
        if (this.page === p) return;
        this.page = p;
        this.loadReport();
      },

      changePageSize() {
        this.page = 1;          // 페이지 사이즈 변경 시 1페이지로
        this.loadReport();
        this.fnReportCnt();
      },

      fnMove(boardNo) {
        // alert("이동할 게시글 번호: " + boardNo);
        pageChange("board-view.do", { boardNo: boardNo });
      }
    },
    mounted() {
      let self = this;
      self.loadReport();
      self.fnReportCnt();
    },
    computed:{
      totalPages() {
        return Math.ceil(this.totalCnt / this.pageSize);
      }
    }
  });

  window.currentVueApp = app;
  app.mount('#reportApp');
})();
// window.reportApp = reportApp;

// app.mount('#reportApp');
</script>
