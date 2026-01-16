  <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <meta charset="UTF-8" />

  <style>
    body {
      font-family: "Pretendard", sans-serif;
      background: #f4f6f8;
    }

    h2 {
      margin-bottom: 20px;
    }

    .user-container {
      background: #fff;
      padding: 24px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .search-con {
      display: flex;
      justify-content: space-between;
    }

    .search-box {
      display: flex;
      gap: 10px;
      margin-bottom: 15px;
    }

    .search-box select,
    .search-box input {
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
    }

    .search-box button {
      padding: 10px 18px;
      background: #2563eb;
      color: #fff;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    .filter-row {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .filter-row select {
    padding: 8px 14px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 14px;
    background-color: #fff;
    cursor: pointer;
  }

  .filter-row select:hover {
    border-color: #2563eb;
  }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    thead {
      background: #f1f5f9;
    }

    th,
    td {
      padding: 14px;
      text-align: center;
      border-bottom: 1px solid black;
    }

    tr:hover {
      background: #f9fafb;
    }

    .status {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 13px;
      font-weight: 600;
    }

    .status.active {
      background: #dcfce7;
      color: #166534;
    }
    .status.admin {
      background: #fee2e2;
      color: #991b1b;
    }
    .status.sub {
      background: #e2effe;
      color: #3730a3;
    }

    .btn-detail {
      padding: 6px 12px;
      border-radius: 6px;
      border: none;
      background: #e0e7ff;
      color: #3730a3;
      cursor: pointer;
    }
    .modal-overlay {
      position: fixed;
      inset: 0;
      background: rgba(0, 0, 0, 0.4);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 999;
    }

    .modal {
      width: 600px;
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      animation: fadeIn 0.2s ease;
    }

    @keyframes fadeIn {
      from {
        transform: translateY(10px);
        opacity: 0;
      }
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      padding: 16px 20px;
      border-bottom: 1px solid #e5e7eb;
    }

    .modal-body {
      padding: 20px;
    }

    .detail-table {
      width: 100%;
      border-collapse: collapse;
    }

    .detail-table th {
      width: 140px;
      text-align: left;
      background: #f8fafc;
      padding: 10px;
    }

    .detail-table td {
      padding: 10px;
    }

    .modal-footer {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      padding: 16px 20px;
      border-top: 1px solid #e5e7eb;
    }

    .close-btn {
      border: none;
      background: none;
      font-size: 18px;
      cursor: pointer;
    }

    .btn-primary {
      background: #2563eb;
      color: #fff;
      padding: 8px 16px;
      border-radius: 6px;
      border: none;
    }

    .btn-danger {
      background: #ef4444;
      color: #fff;
      padding: 8px 16px;
      border-radius: 6px;
      border: none;
    }

    .btn-save {
      background-color: #166534;
      color: #fff;
      padding: 8px 16px;
      border-radius: 6px;
      border: none;
    }
    /* ====== 페이지네이션 ====== */
    .pagination {
      width: 82.5%;
      margin: 16px auto 36px;
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
      border: 1px solid var(--border);
      color: #1f2937;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.15s;
      text-decoration: none;
    }

    .page-num.active {
      background: var(--primary);
      border-color: var(--primary);
      color: #2563eb;
    }
    .page-btn:hover,
    .page-num:hover {
      border-color: var(--primary);
      color: var(--primary);
    }
  </style>

  <h2>👤 회원 관리</h2>

  <div id="userManageApp" class="user-container">
    <!-- 검색 -->
    <div class="search-con">
      <div class="search-box">
        <select v-model="searchOption">
          <option value="USER_ID">아이디</option>
          <option value="EMAIL">이메일</option>
          <option value="NAME">이름</option>
        </select>
        <input type="text" v-model="keyword" placeholder="검색어 입력" />
        <button @click="fnsearch()">검색</button>
      </div>
      <div class="filter-row">
        <select v-model="pageSize" @change="fnChangePageSize()" title="페이지 크기">
          <option value="5">5개씩</option>
          <option value="10">10개씩</option>
          <option value="15">15개씩</option>
        </select>
      </div>
    </div>

      <!-- 유저 목록 -->
      <div>
        <table>
          <thead>
            <tr>
              <th>번호</th>
              <th>아이디</th>
              <th>이름</th>
              <th>닉네임</th>
              <th>이메일</th>
              <th>상태</th>
              <th>가입일</th>
              <th>로그인실패횟수</th>
              <th>상세정보</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item,index) in list" :key="item.USER_ID">
              <td>{{ index + 1 }}</td>
              <td>{{ item.USER_ID }}</td>
              <td>{{ item.NAME }}</td>
              <td>{{ item.NICKNAME }}</td>
              <td>{{ item.EMAIL }}</td>
              <td>
                <span class="status" :class="item.STATUS === 'U' ? 'active' : item.STATUS === 'S' ? 'sub' : 'admin'">
                  {{
                    item.STATUS == "U" ? "유저" : item.STATUS == "S" ? "구독자" : item.STATUS == "B" ? "정지" : "관리자"
                  }}
                </span>
              </td>
              <td>{{ item.CDATE }}</td>
              <td>{{ item.CNT }}</td>
              <td>
                <button class="btn-detail" @click="openModal(item)">상세</button>
              </td>
            </tr>
          </tbody>
        </table>
        <!-- 페이지네이션 -->
        <div class="pagination">
          <a href="javascript:;" class="page-btn" v-if="page > 1" @click="fnMove(-1)">◀</a>

          <a
            href="javascript:;"
            class="page-num"
            v-for="num in (pageGroupEnd - pageGroupStart + 1)"
            :key="'p'+num"
            :class="{ active: page == (pageGroupStart + num - 1) }"
            @click="fnPage(pageGroupStart + num - 1)"
          >
            {{ pageGroupStart + num - 1 }}
          </a>

          <a href="javascript:;" class="page-btn" v-if="page < totalPages" @click="fnMove(1)">▶</a>
        </div>
      </div>

      <!-- 상세 모달 -->
      <div v-if="showModal" class="modal-overlay" @click.self="closeModal">
        <div class="modal">
          <div class="modal-header">
            <h3>회원 상세 정보</h3>
            <button class="close-btn" @click="closeModal">✕</button>
          </div>

          <div class="modal-body">
            <table class="detail-table">
              <tr>
                <th>아이디</th>
                <td>{{ detail.USER_ID }}</td>
              </tr>
              <tr>
                <th>이름</th>
                <td>{{ detail.NAME }}</td>
              </tr>
              <tr>
                <th>닉네임</th>
                <td>{{ detail.NICKNAME }}</td>
              </tr>
              <tr>
                <th>이메일</th>
                <td>{{ detail.EMAIL }}</td>
              </tr>
              <tr>
                <th>전화번호</th>
                <td>{{ detail.PHONE }}</td>
              </tr>
              <tr>
                <th>성별</th>
                <td>
                  {{ detail.GENDER === "M" ? "남성" : detail.GENDER === "F" ? "여성" : "-" }}
                </td>
              </tr>
              <tr>
                <th>회원 상태</th>
                <td>
                  {{
                    detail.STATUS == "U"
                      ? "유저"
                      : detail.STATUS == "S"
                      ? "구독자"
                      : detail.STATUS == "B"
                      ? "정지"
                      : "관리자"
                  }}
                </td>
              </tr>
              <tr v-if="detail.SDATE !=null">
                <th>구독종료일</th>
                <td>{{ detail.SDATE }}</td>
              </tr>
              <tr>
                <th>탈퇴여부</th>
                <td>{{ detail.DELETED_YN === "N" ? "X" : "Y" }}</td>
              </tr>
              <tr v-if="detail.DELETED_YN =='Y'">
                <th>탈퇴신청일</th>
                <td>{{ detail.DTIME }}</td>
              </tr>
              <tr>
                <th>주소</th>
                <td>{{ detail.ADDR }}</td>
              </tr>
            </table>
          </div>

          <div class="modal-footer">
            <button v-if="detail.STATUS !='B'" class="btn-danger" @click="fnStatusUser('B')">정지</button>
            <button v-else @click="fnStatusUser('U')" class="btn-save">정지해제</button>
            <button class="btn-primary" @click="closeModal">닫기</button>
          </div>
        </div>
      </div>
    </div>
  </div>

    <script>
      (function () {
        const app = Vue.createApp({
          data() {
            return {
              list: [],
              memberCnt: 0,
              reportCnt: 0,
              searchOption: "USER_ID",
              keyword: "",

              showModal: false,
              detail: {},

              //페이지
              page: 1,
              pageSize: 5,
              pageGroupSize: 10,
              totalPages: 0,
              pageGroupStart: 1,
              pageGroupEnd: 10,
            };
          },
          methods: {
            fnList() {
              let self = this;
              let param = {
                searchOption: self.searchOption,
                keyword: self.keyword,
                pageSize: self.pageSize,
                page: (self.page - 1) * self.pageSize,
              };
              $.ajax({
                url: "user-list.dox",
                dataType: "json",
                type: "POST",
                data: param,
                success: function (data) {
                  console.log(data);
                  self.list = data.user;
                  self.totalPages = Math.ceil((data.cnt || 0) / self.pageSize);

                  const group = Math.floor((self.page - 1) / self.pageGroupSize);
                  self.pageGroupStart = group * self.pageGroupSize + 1;
                  self.pageGroupEnd = Math.min(self.pageGroupStart + self.pageGroupSize - 1, self.totalPages || 1);
                },
              });
            },
            openModal(item) {
              let self = this;
              self.detail = { ...item }; // 선택한 회원 정보
              self.showModal = true;
            },
            closeModal() {
              let self = this;
              self.showModal = false;
            },
            fnStatusUser(status) {
              let self = this;
              let param = {
                userId: self.detail.USER_ID,
                status: status,
              };
              $.ajax({
                url: "user-status-update.dox",
                dataType: "json",
                type: "POST",
                data: param,
                success: function (data) {
                  console.log(data);
                  self.fnList();
                    self.showModal = false;
                  if (status == "B") {
                    alert("정지되었습니다.");
                  } else {
                    alert("해제되었습니다.");
                  }
                  
                },
              });
            },
            fnPage(num) {
              this.page = num;
              this.fnList();
            },
            fnMove(delta) {
              this.page += delta;
              if (this.page < 1) this.page = 1;
              if (this.page > this.totalPages) this.page = this.totalPages;
              this.fnList();
            },
            fnChangePageSize(){
              let self=this;
              self.page = 1;
              self.fnList();
            },
            fnsearch(){
              let self=this;
              self.page=1;
              self.fnList();
            }
          },
          mounted() {
            let self = this;
            self.fnList();
          },
        });

        window.currentVueApp = app;
        app.mount("#userManageApp");
      })();
    </script>
  </div>
