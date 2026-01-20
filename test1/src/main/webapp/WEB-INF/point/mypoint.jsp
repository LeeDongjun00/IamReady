<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포인트 내역</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="/css/main-style.css">
    <link rel="stylesheet" href="/css/common-style.css">
    <link rel="stylesheet" href="/css/header-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        /* 외부 CSS와의 충돌을 피하기 위해 고유한 클래스명 사용 */
        .point-page-wrapper {
            width: 100%;
            max-width: 1100px;
            margin: 50px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        .point-flex-container {
            display: flex;
            flex-wrap: wrap; /* 화면이 좁아지면 아래로 떨어지게 설정 */
            gap: 30px;
            align-items: flex-start;
        }

        /* 왼쪽 프로필 섹션 */
        .point-side-profile {
            flex: 0 0 280px; /* 너비 고정 */
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .profile-img-container {
            width: 120px;
            height: 120px;
            margin: 0 auto 20px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid #0078FF;
        }

        .profile-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-nickname {
            font-size: 1.2rem;
            font-weight: bold;
            display: block;
        }

        .user-grade {
            display: inline-block;
            margin-top: 5px;
            padding: 3px 10px;
            background: #f0f7ff;
            color: #0078FF;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* 오른쪽 컨텐츠 섹션 */
        .point-main-content {
            flex: 1; /* 남은 공간 모두 차지 */
            min-width: 300px;
        }

        .point-summary-card {
            background: #0078FF;
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .point-summary-card h3 { margin: 0; font-size: 1.1rem; opacity: 0.9; }
        .point-amount { font-size: 2rem; font-weight: 800; }

        /* 테이블 스타일 */
        .point-history-section {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 15px;
            padding: 20px;
        }

        .point-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .point-table th {
            background: #f8f9fa;
            padding: 12px;
            font-size: 0.9rem;
            border-bottom: 2px solid #dee2e6;
            text-align: center;
        }

        .point-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #eee;
            text-align: center;
            font-size: 0.95rem;
        }

        .text-plus { color: #28a745; font-weight: bold; }
        .text-minus { color: #dc3545; font-weight: bold; }

        .btn-more {
            width: 100%;
            padding: 10px;
            background: none;
            border: 1px solid #0078FF;
            color: #0078FF;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-more:hover {
            background: #0078FF;
            color: white;
        }
    </style>
</head>
<body>
<%@ include file="../components/header.jsp" %>

<div id="app" class="point-page-wrapper">
    <div class="point-flex-container">
        
        <aside class="point-side-profile">
            <div class="profile-img-container">
                <img :src="profileImgPath" alt="프로필">
            </div>
            <span class="user-nickname">{{nickname}} 님</span>
            <span class="user-grade">{{gradeLabel}}</span>
            
            <div style="margin-top: 30px; text-align: left; border-top: 1px solid #eee; padding-top: 20px;">
                <a href="/main-myPage.do" style="text-decoration: none; color: #555; display: block; margin-bottom: 15px;">
                    <i class="fa-solid fa-user-gear" style="margin-right: 10px;"></i> 내 정보 관리
                </a>
            </div>
        </aside>

        <main class="point-main-content">
            <div class="point-summary-card">
                <div>
                    <h3><i class="fa-solid fa-coins"></i> 현재 보유 포인트</h3>
                    <div class="point-amount">{{point.toLocaleString()}} P</div>
                </div>
                <!-- <button @click="fnOpenCharge" style="background: white; color: #0078FF; border: none; padding: 10px 20px; border-radius: 8px; font-weight: bold; cursor: pointer;">
                    충전하기
                </button> -->
            </div>

            <div class="point-history-section">
                <h4 style="margin: 0;"><i class="fa-solid fa-list-ul"></i> 포인트 변동 내역</h4>
                
                <table class="point-table" v-if="list.length > 0">
                    <thead>
                        <tr>
                            <th>잔여 포인트</th>
                            <th>증가</th>
                            <th>감소</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in displayedList" :key="item.pDate">
                            <td>{{item.pointTotal.toLocaleString()}}</td>
                            <td class="text-plus">{{item.pointGet > 0 ? '+' + item.pointGet.toLocaleString() : '-'}}</td>
                            <td class="text-minus">{{item.pointOut > 0 ? '-' + item.pointOut.toLocaleString() : '-'}}</td>
                            <td style="color: #999;">{{item.pDate}}</td>
                        </tr>
                    </tbody>
                </table>
                
                <div v-else style="padding: 40px; text-align: center; color: #ccc;">
                    내역이 없습니다.
                </div>

                <button v-if="list.length > 11" @click="fnShowList" class="btn-more">
                    {{ showAll ? '내역 접기 ▲' : '내역 더보기 ▼' }}
                </button>
            </div>
        </main>
        
    </div>
</div>

<%@ include file="../components/footer.jsp" %>

<script>
    const app = Vue.createApp({
        data() {
            return {
                id: window.sessionData.id,
                nickname: window.sessionData.nickname,
                point: window.sessionData.point,
                gradeLabel: window.sessionData.gradeLabel,
                showAll: false,
                list: [],
                profileImgPath: ""
            };
        },
        computed: {
            displayedList() {
                return this.showAll ? this.list : this.list.slice(0, 11);
            }
        },
        methods: {
            fnShowList() { this.showAll = !this.showAll; },
            // fnOpenCharge() { alert('충전 페이지 준비 중입니다.'); },
            fnPointIncdec() {
                let self = this;
                $.ajax({
                    url: "/point/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: { userId: self.id },
                    success: function (data) { self.list = data.list; }
                });
            },
            fnProfilePath() {
                let self = this;
                $.ajax({
                    url: "/member/profilePath.dox",
                    dataType: "json",
                    type: "POST",
                    data: { userId: self.id },
                    success: function (data) {
                        self.profileImgPath = (data.info && data.info.storUrl) ? data.info.storUrl : "/img/profile/default_profile.jpg";
                    }
                });
            }
        },
        mounted() {
            this.fnPointIncdec();
            this.fnProfilePath();
        }
    });
    app.mount('#app');
</script>
</body>
</html>