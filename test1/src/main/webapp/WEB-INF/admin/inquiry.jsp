<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>문의 | READY</title>

    <!-- LIB -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

    <!-- COMMON CSS -->
    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />

    <!-- PAGE CSS -->
    <style>
      body {
        background: #f7f8fa;
        font-family: "Pretendard", sans-serif;
        color: #1e293b;
        margin: 0;
        padding: 0;
      }

      /* 타이틀 */
      .inquiry-title {
        width: 82.5%;
        margin: 32px auto 6px;
        font-size: 22px;
        font-weight: 800;
      }
      .inquiry-desc {
        width: 82.5%;
        margin: 0 auto 20px;
        font-size: 14px;
        color: #64748b;
      }

      /* 필터 */
      .board-filter {
        width: 82.5%;
        margin: 20px auto;
        padding: 18px;
        background: #fff;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
        display: flex;
        justify-content: space-between;
        gap: 10px;
      }
      .board-filter select,
      .board-filter input {
        padding: 10px 14px;
        border-radius: 10px;
        border: 1px solid #e5e7eb;
        font-size: 14px;
      }
      .board-filter button {
        padding: 10px 14px;
        border-radius: 10px;
        border: none;
        background: #6366f1;
        color: #fff;
        font-weight: 700;
        cursor: pointer;
      }

      /* 테이블 */
      table {
        width: 82.5%;
        margin: 0 auto;
        border-collapse: collapse;
        background: #fff;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
      }
      thead th {
        background: #f1f5f9;
        padding: 14px;
        font-size: 14px;
        font-weight: 700;
        border-bottom: 1px solid #e5e7eb;
      }
      tbody td {
        padding: 14px;
        font-size: 15px;
        border-bottom: 1px solid #e5e7eb;
      }
      tbody tr:hover {
        background: #f5f3ff;
        cursor: pointer;
      }
      .col-num {
        width: 80px;
        text-align: center;
      }
      .col-author {
        width: 160px;
        text-align: center;
      }
      .col-date {
        width: 140px;
        text-align: center;
      }

      /* 버튼 */
      .reply-btn {
        padding: 6px 12px;
        border-radius: 8px;
        border: none;
        background: #6366f1;
        color: #fff;
        font-size: 13px;
        font-weight: 700;
        cursor: pointer;
      }
      .reply-btn:disabled {
        background: #e5e7eb;
        color: #94a3b8;
        cursor: not-allowed;
      }

      /* 타입 / 댓글 표시 */
      .type-SQ {
        background: #ede9fe;
        color: #5b21b6;
        font-size: 11px;
        padding: 3px 8px;
        border-radius: 8px;
        font-weight: 700;
        margin-right: 6px;
      }
      .comment-pill {
        background: #fee2e2;
        color: #991b1b;
        font-size: 11px;
        padding: 2px 8px;
        border-radius: 999px;
        margin-left: 6px;
        font-weight: 700;
      }

      /* 페이지네이션 */
      .pagination {
        width: 82.5%;
        margin: 18px auto 40px;
        display: flex;
        justify-content: center;
        gap: 6px;
      }
      .page-btn,
      .page-num {
        min-width: 36px;
        height: 36px;
        border-radius: 10px;
        background: #fff;
        border: 1px solid #e5e7eb;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        cursor: pointer;
        transition: 0.15s;
      }
      .page-num.active {
        background: #6366f1;
        color: #fff;
        border-color: #6366f1;
      }
      .page-btn:hover,
      .page-num:hover {
        border-color: #6366f1;
        color: #6366f1;
      }

      /* 팝업 */
      .popup-dim {
        position: fixed;
        inset: 0;
        background: rgba(15, 23, 42, 0.6);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
      }
      .popup-box {
        width: 520px;
        max-width: 92%;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
        animation: fadeUp 0.2s ease;
        max-height: 80vh;
        overflow-y: auto;
      }
      @keyframes fadeUp {
        from {
          transform: translateY(10px);
          opacity: 0;
        }
        to {
          transform: translateY(0);
          opacity: 1;
        }
      }
      .popup-header {
        padding: 18px 22px;
        border-bottom: 1px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .popup-header h3 {
        margin: 0;
        font-size: 18px;
      }
      .popup-close {
        cursor: pointer;
        font-size: 20px;
        color: #64748b;
      }
      .popup-body {
        padding: 22px;
        font-size: 15px;
      }

      /* 문의 내용 */
      .popup-info {
        font-size: 13px;
        color: #64748b;
        margin-bottom: 14px;
      }
      .popup-content {
        line-height: 1.7;
        color: #334155;
      }

      /* 답변 박스 */
      .answer-box {
        background: #f8fafc;
        border-radius: 12px;
        padding: 14px;
        margin-bottom: 12px;
      }
      .answer-header {
        display: flex;
        gap: 10px;
        align-items: center;
        margin-bottom: 8px;
      }
      .answer-profile {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        object-fit: cover;
      }
      .answer-date {
        font-size: 12px;
        color: #64748b;
      }
    </style>
  </head>

  <body>
    <div id="inquiryApp">
      <h2 class="inquiry-title">문의 게시판</h2>
      <p class="inquiry-desc">서비스 이용 중 궁금한 사항을 문의해주세요.</p>

      <!-- SEARCH -->
      <div class="board-filter">
        <div class="filter-con">
          <select v-model="searchOption">
            <option value="all">전체</option>
            <option value="title">제목</option>
            <option value="id">작성자</option>
          </select>
          <input v-model="keyword" placeholder="검색어 입력" @keyup.enter="page=1; fnList()" />
          <button @click="page=1; fnList()">검색</button>
        </div>
        <div class="filter-row">
          <select v-model="pageSize" @change="fnChangePageSize()" title="페이지 크기">
            <option value="5">5개씩</option>
            <option value="10">10개씩</option>
            <option value="15">15개씩</option>
          </select>
        </div>
        <!-- <div class="processedFilter">
          <select v-model="processedFilter" @change="fnChangeProcessedFilter()" title="처리 상태">
            <option value="all">전체</option>
            <option value="processed">답변완료</option>
            <option value="unprocessed">미답변</option>
          </select>
        </div> -->
      </div>

      <!-- TABLE -->
      <table>
        <thead>
          <tr>
            <th class="col-num">번호</th>
            <th class="col-author">작성자</th>
            <th>제목</th>
            <th class="col-date">작성일</th>
            <th>답변상태</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in list" :key="item.boardNo" @click="openPopup(item.boardNo)">
            <td class="col-num">{{ item.boardNo }}</td>
            <td class="col-author">{{ item.userId }}</td>
            <td>
              <span class="type-SQ">문의</span>
              {{ item.title }}
              <span v-if="item.commentCnt" class="comment-pill">+{{ item.commentCnt }}</span>
            </td>
            <td class="col-date">{{ item.cdateTime }}</td>
            <td>
              <button class="reply-btn" :disabled="item.commentCnt>0" @click.stop="goReply(item.boardNo)">
                {{ item.commentCnt > 0 ? "답변완료" : "미답변" }}
              </button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- PAGINATION -->
      <div class="pagination">
        <a class="page-btn" v-if="page>1" @click="fnMove(-1)">◀</a>
        <a
          class="page-num"
          v-for="num in (pageGroupEnd-pageGroupStart+1)"
          :key="num"
          :class="{active: page===(pageGroupStart+num-1)}"
          @click="fnPage(pageGroupStart+num-1)"
        >
          {{ pageGroupStart + num - 1 }}
        </a>
        <a class="page-btn" v-if="page<totalPages" @click="fnMove(1)">▶</a>
      </div>

      <!-- POPUP -->
      <div v-if="popupOpen" class="popup-dim" @click.self="popupOpen=false">
        <div class="popup-box">
          <div class="popup-header">
            <h3>{{ detail.title }}</h3>
            <span class="popup-close" @click="popupOpen=false">✕</span>
          </div>

          <div class="popup-body">
            <!-- 문의 내용 -->
            <div class="popup-info">{{ detail.userId }} · {{ detail.cdateTime }} · 조회 {{ detail.cnt }}</div>
            <div class="popup-content" v-html="detail.contents"></div>

            <hr style="margin: 24px 0" />

            <!-- 관리자 답변 영역 -->
            <h4>관리자 답변</h4>

            <div v-if="commentList.length===0" style="color: #64748b; margin-bottom: 12px">
              아직 답변이 등록되지 않았습니다.
            </div>

            <div v-for="c in commentList" :key="c.commentNo" class="answer-box">
              <div class="answer-header">
                <img :src="c.storUrl" class="answer-profile" />
                <div>
                  <strong>{{ c.userNick }}</strong>
                  <div class="answer-date">{{ c.cdateTime }}</div>
                </div>
              </div>
              <div>{{ c.contents }}</div>
            </div>

            <!-- 답변 작성 폼 -->
            <div v-if="userId==='admin01'" style="margin-top: 20px">
              <textarea
                v-model="newComment"
                placeholder="답변을 입력하세요."
                style="
                  width: 95%;
                  height: 80px;
                  padding: 10px;
                  border-radius: 8px;
                  border: 1px solid #e5e7eb;
                  resize: none;
                "
              ></textarea>
              <button
                @click="submitComment()"
                style="
                  margin-top: 8px;
                  padding: 8px 16px;
                  border: none;
                  border-radius: 8px;
                  background: #6366f1;
                  color: #fff;
                  font-weight: 700;
                  cursor: pointer;
                "
              >
                답변 등록
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script>
      // 뒤로가기 캐시 대응
      window.addEventListener("pageshow", function (e) {
        if (e.persisted) location.reload();
      });

      // Vue 중복 mount 방지
      if (window.inquiryVueApp) window.inquiryVueApp.unmount();

      window.inquiryVueApp = Vue.createApp({
        data() {
          return {
            userId: "${sessionId}",
            list: [],
            keyword: "",
            searchOption: "all",
            type: "SQ",
            page: 1,
            pageSize: 10,
            pageGroupSize: 5,
            totalPages: 0,
            pageGroupStart: 1,
            pageGroupEnd: 1,
            popupOpen: false,
            detail: {},
            commentList: [],
            newComment: "",

            // processedFilter: "all",
          };
        },
        methods: {
          fnList() {
            const self = this;
            $.ajax({
              url: "board-list.dox",
              type: "POST",
              dataType: "json",
              data: {
                type: self.type,
                keyword: self.keyword,
                searchOption: self.searchOption,
                page: (self.page - 1) * self.pageSize,
                pageSize: self.pageSize,
                pageType: "adminInquiry",
                processedFilter: self.processedFilter,
              },
              success(res) {
                self.list = res.list || [];
                self.list.sort((a, b) => {
                  if (a.commentCnt === 0 && b.commentCnt > 0) return -1;
                  if (a.commentCnt > 0 && b.commentCnt === 0) return 1;
                  return b.boardNo - a.boardNo;
                });
                const total = res.cnt || 0;
                self.totalPages = Math.ceil(total / self.pageSize);
                const g = Math.floor((self.page - 1) / self.pageGroupSize);
                self.pageGroupStart = g * self.pageGroupSize + 1;
                self.pageGroupEnd = Math.min(self.pageGroupStart + self.pageGroupSize - 1, self.totalPages);
              },
            });
          },
          fnPage(n) {
            this.page = n;
            this.fnList();
          },
          fnMove(d) {
            this.page += d;
            this.fnList();
          },
          openPopup(boardNo) {
            const self = this;
            self.popupOpen = true;
            $.ajax({
              url: "board-view.dox",
              type: "POST",
              dataType: "json",
              data: { boardNo, userId: self.userId },
              success(res) {
                self.detail = res.info || {};
                self.commentList = res.commentList || [];
              },
            });
          },
          submitComment() {
            const self = this;
            if (!self.newComment.trim()) {
              alert("답변 내용을 입력해주세요.");
              return;
            }
            $.ajax({
              url: "comment/add.dox",
              type: "POST",
              dataType: "json",
              data: {
                boardNo: self.detail.boardNo,
                userId: self.userId,
                contents: self.newComment,
              },
              success(res) {
                if (res.result == "success") {
                  alert(res.msg);
                  self.newComment = "";
                  self.popupOpen = false;
                  self.fnList();
                } else {
                  alert(res.msg);
                }
              },
              error() {
                alert("서버 오류가 발생했습니다.");
              },
            });
          },
          goReply(boardNo) {
            this.openPopup(boardNo);
          },
          fnChangePageSize() {
            let self = this;
            self.page = 1;
            self.fnList();
          },
          // fnChangeProcessedFilter() {
          //   let self = this;
          //   this.page = 1;
          //   this.fnList();
          // }
        },
        mounted() {
          this.fnList();
        },
      });

      window.inquiryVueApp.mount("#inquiryApp");
    </script>
  </body>
</html>
