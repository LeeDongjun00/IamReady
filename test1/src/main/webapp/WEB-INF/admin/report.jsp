<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">

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
</style>

<h2>신고 관리</h2>

<div id="reportApp">
  <div class="reportTip">※신고글 번호를 클릭하여 내용 확인※</div>
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
    </tr>
    <tr v-for="item in list" :key="item.REPORTNUM">
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
          <a href="javascript:;" @click="fnUserManage(item.REPORTED_USER_ID, item.DELETED_YN)" :class="getUserStatus(item.STATUS, item.DELETED_YN)">
            <span v-if="item.REPORTED_NICKNAME != null">{{item.REPORTED_USER_ID}} / {{item.REPORTED_NICKNAME}}</span>
            <span v-else>{{item.REPORTED_USER_ID}} / 탈퇴한 사용자</span>
          </a>

          
        </td>
        <td>{{item.CONTENT}}</td>
        <td>{{item.REPORT_USER_ID}}</td>

        <!-- <td>{{ item.STATUS }} / {{ item.DELETED_YN }}</td> -->
    </tr>
  </table>

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

      <button @click="closeModal">닫기</button>
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
      };
    },
    methods: {
      async loadReport() {
          let self = this;

        try {
          const response = await fetch('/admin/report.dox');

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

      fnUserManage(reportedUserId, deletedYn){
        // alert("신고 대상 사용자 ID: " + reportedUserId);
        if(deletedYn === 'Y' || !deletedYn) {
          alert("탈퇴한 사용자입니다.");
        } else {
          
        }
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
      }
    },
    mounted() {
      let self = this;
      self.loadReport();
    }
  });

  window.currentVueApp = app;
  app.mount('#reportApp');
})();
// window.reportApp = reportApp;

// app.mount('#reportApp');
</script>
