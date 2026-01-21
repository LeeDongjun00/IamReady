<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String userId = (String) session.getAttribute("sessionId");
    String userStatus = (String) session.getAttribute("sessionStatus");
    String userNickname = (String) session.getAttribute("sessionNickname");
    String userName = (String) session.getAttribute("sessionName");
    Integer userPoint = (Integer) session.getAttribute("sessionPoint");
%>

<style>
    /* 헤더 레이아웃 */
    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        height: 80px;
        background-color: #fff;
        border-bottom: 1px solid #eee;
        box-sizing: border-box;
    }

    .logo img {
        height: 50px;
        width: auto;
        display: block;
    }

    nav ul {
        display: flex;
        gap: 30px;
        list-style: none;
        padding: 0;
        margin: 0;
    }

    nav a {
        text-decoration: none;
        color: #333;
        font-weight: 600;
        font-size: 16px;
        transition: color 0.2s;
        padding: 5px 0; /* 클릭 영역 확보 */
    }

    nav a:hover {
        color: #2c3e50;
    }

    /* 선택된 카테고리 강조 스타일 */
    nav a.active {
        color: #0ea5e9 !important; /* 예쁜 파란색 (Sky Blue) */
        font-weight: 800;          /* 글자 두껍게 */
    }

    /* ========================================= */
    /* 로그인 버튼 (알약 모양 + 텍스트 유지) */
    /* ========================================= */
    .login-btn button {
        background-color: #2c3e50; /* 브랜드 컬러 */
        color: #fff;
        border: none;
        padding: 10px 28px;        /* 넉넉한 여백 */
        border-radius: 50px;       /* 둥근 알약 모양 */
        font-size: 15px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        letter-spacing: -0.5px;
    }

    .login-btn button:hover {
        background-color: #1a252f;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }

    /* ========================================= */
    /* ✅ 유저 프로필 배지 (로그인 후) */
    /* ========================================= */
    .user-profile-badge {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 6px 16px 6px 8px; 
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.2s;
        position: relative;
    }

    .user-profile-badge:hover {
        background-color: #e9ecef;
        border-color: #ced4da;
    }

    .user-text-group {
        display: flex;
        flex-direction: column;
        line-height: 1.2;
    }

    .user-nickname {
        font-size: 14px;
        font-weight: 700;
        color: #343a40;
    }

    .user-welcome {
        font-size: 11px;
        color: #868e96;
        font-weight: 400;
    }

    .grade-icon-area {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* 드롭다운 메뉴 */
    .logout-dropdown {
        position: absolute;
        top: 55px;
        right: 0;
        width: 200px;
        background: #fff;
        border: 1px solid #eee;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        list-style: none;
        padding: 8px 0;
        z-index: 2000;
        overflow: hidden;
        animation: fadeInDown 0.2s ease-out;
    }

    .logout-dropdown li {
        padding: 12px 20px;
        font-size: 14px;
        color: #333;
        cursor: pointer;
        border-bottom: 1px solid #f8f9fa;
        transition: background 0.1s;
    }
    
    .logout-dropdown li:last-child {
        border-bottom: none;
    }

    .logout-dropdown li:hover {
        background-color: #f1f3f5;
        color: #2c3e50;
        font-weight: 600;
    }

    .logout-dropdown a {
        display: block;
        width: 100%;
        color: inherit;
        text-decoration: none;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div id="app-header">
    <header>
        <div class="logo">
            <a href="/main-list.do">
                <img src="/img/logo/projectLogo.jpg" alt="">
            </a>
        </div>
        <nav>
            <ul>
                <li class="main-menu"><a href="/reservation.do">여행하기</a></li>
                <li class="main-menu"><a href="/board-list.do">커뮤니티</a></li>
                <li class="main-menu"><a href="/review-list.do">후기 게시판</a></li>
                <li class="main-menu"><a href="/main-Notice.do">공지사항</a></li>
                <% if("A".equals(userStatus)) { %>
                    <li class="main-menu">
                        <a href="/admin-page.do">관리자 페이지</a>
                    </li>
                <% } %>
            </ul>
        </nav>

        <div style="display: flex; align-items: center; gap: 15px;">
            <% if(userId == null) { %>
                <div class="login-btn">
                    <button onclick="goToLogin()">로그인 / 회원가입</button>
                </div>
            <% } else { %>
                <div style="position: relative;">
                    <div class="user-profile-badge" onclick="toggleLogoutMenu()">
                        <div class="grade-icon-area">
                            {{ gradeLabel }} 
                        </div>
                        
                        <div class="user-text-group">
                            <span class="user-nickname"><%= userNickname %>님</span>
                            <span class="user-welcome">환영합니다!</span>
                        </div>
                        
                        <i class="fa-solid fa-chevron-down" style="font-size: 12px; color: #adb5bd; margin-left: 4px;"></i>
                    </div>

                    <ul id="logoutMenu" class="logout-dropdown" style="display: none;">
                        <li onclick="goToMyPage()">마이페이지</li>
                        <li>
                            <a href="/point/myPoint.do">
                                내 포인트 : <strong style="color: #2c3e50;"><%= userPoint %> P</strong>
                            </a>
                        </li>
                        <li onclick="logout()">로그아웃</li>
                    </ul>
                </div>
            <% } %>
        </div>
    </header>
</div>

<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

<script>
    window.sessionData = {
        id: "<%= userId %>",
        status: "<%= userStatus %>",
        nickname: "<%= userNickname %>",
        name: "<%= userName %>",
        point: "<%= userPoint != null ? userPoint : 0 %>",
    };
    
    if(window.sessionData.id) {
        window.sessionStorage.setItem("id", window.sessionData.id);
    }

    let showLogoutMenu = false;
    
    function toggleLogoutMenu() {
        showLogoutMenu = !showLogoutMenu;
        const menu = document.getElementById('logoutMenu');
        if(menu) menu.style.display = showLogoutMenu ? 'block' : 'none';
    }

    document.addEventListener('click', function(e) {
        const badge = document.querySelector('.user-profile-badge');
        const menu = document.getElementById('logoutMenu');
        
        if (badge && !badge.contains(e.target) && menu && !menu.contains(e.target)) {
            showLogoutMenu = false;
            menu.style.display = 'none';
        }
    });

    // ✅ [NEW] 현재 페이지 메뉴 강조 (Active 상태 자동 적용)
    document.addEventListener("DOMContentLoaded", function() {
        const currentPath = window.location.pathname; // 현재 주소 (예: /reservation.do)
        const menuLinks = document.querySelectorAll('.main-menu a');

        menuLinks.forEach(link => {
            const href = link.getAttribute('href');
            // 현재 주소가 링크 주소를 포함하고 있으면 active 클래스 추가
            if (href && currentPath.includes(href)) {
                link.classList.add('active');
            }
        });
    });
</script>

<script src="/js/header.js"></script>
<script src="/js/kakao.js"></script>