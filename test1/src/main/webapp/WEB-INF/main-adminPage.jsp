<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>

    <!-- page change -->
    <script src="/js/page-change.js"></script>

    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

    <!-- css -->
    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />
    <link rel="stylesheet" href="/css/main-images.css" />

    <style>
        table, tr, td, th {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px 10px;
            text-align: center;
        }
        th {
            background-color: beige;
        }
        tr:nth-child(even) {
            background-color: azure;
        }
        .admin-layout {
            display: flex;
            min-height: 100vh;
        }
        .admin-layout nav {
            width: 150px;
            flex-shrink: 0;
        }
        .admin-content {
            margin-left: 20px;
            flex: 1;
        }
    </style>
</head>

<body>
    <!-- 헤더 -->
    <%@ include file="components/header.jsp" %>

    <div class="admin-layout">
        <%@ include file="admin/nav.jsp" %>

        <!-- 콘텐츠 영역 -->
        <div class="admin-content" id="adminContent"></div>
    </div>

    <!-- 푸터 -->
    <%@ include file="components/footer.jsp" %>
</body>
</html>

<script>
    // 페이지 로딩 함수
    function loadPage(type) {
        const urlMap = {
            dashboard: '/admin/dashboard.do',
            report: '/admin/report.do',
            inquiry: '/admin/inquiry.do',
            userManage: '/admin/userManage.do'
        };

        if (!urlMap[type]) {
            console.warn('등록되지 않은 탭:', type);
            return;
        }

        $('#adminContent').load(urlMap[type]);
    }

    // 최초 진입 시 대시보드 로드
    $(document).ready(function () {
        loadPage('dashboard');
    });

    // nav 클릭 이벤트 수신
    window.addEventListener('admin-nav-change', function (e) {
        const type = e.detail.type;
        loadPage(type);
        console.log('현재 탭:', type);
    });
</script>
