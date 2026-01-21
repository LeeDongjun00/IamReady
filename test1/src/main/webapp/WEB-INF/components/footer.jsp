<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    /* 푸터 전체 컨테이너 */
    footer {
        background-color: #f8f9fa; /* 전형적인 연한 회색 */
        border-top: 1px solid #e9ecef; /* 본문과 구분되는 얇은 선 */
        color: #495057; /* 짙은 회색 글자 */
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        padding: 60px 0 30px;
        font-size: 14px;
        line-height: 1.6;
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    /* 상단 링크 섹션 */
    .footer-links {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 40px;
        margin-bottom: 50px;
        border-bottom: 1px solid #dee2e6; /* 회색 구분선 */
        padding-bottom: 40px;
    }

    .footer-section {
        flex: 1;
        min-width: 160px;
    }

    /* 섹션 제목 스타일 */
    .footer-section h4 {
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 20px;
        color: #212529; /* 거의 검은색에 가까운 제목 */
    }
    
    /* 리스트 스타일 */
    .footer-section ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-section ul li {
        margin-bottom: 12px;
    }

    .footer-section ul li a {
        color: #6c757d; /* 차분한 회색 링크 */
        text-decoration: none;
        transition: color 0.2s ease;
    }

    /* 마우스 올렸을 때 효과 */
    .footer-section ul li a:hover {
        color: #ef233c; /* 포인트 컬러 유지 */
        text-decoration: underline;
    }

    /* 뉴스레터/브랜드 섹션 */
    .brand-section p {
        color: #6c757d;
        margin-bottom: 15px;
    }
    
    .newsletter-box {
        display: flex;
        gap: 10px;
    }
    
    .newsletter-input {
        padding: 10px;
        border: 1px solid #ced4da; /* 테두리 추가 */
        border-radius: 4px;
        background-color: #fff;
        width: 100%;
        font-size: 13px;
    }
    
    .btn-subscribe {
        background-color: #495057; /* 버튼도 차분한 색으로 변경 */
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
        white-space: nowrap;
        transition: background-color 0.3s;
    }
    
    .btn-subscribe:hover {
        background-color: #212529;
    }

    /* 하단 정보 섹션 */
    .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        flex-wrap: wrap;
        gap: 20px;
        color: #868e96;
        font-size: 12px;
    }
    
    .company-info span {
        margin-right: 10px;
        padding-right: 10px;
        border-right: 1px solid #dee2e6;
    }
    
    .company-info span:last-child {
        border-right: none;
    }

    .social-icons a {
        color: #adb5bd;
        margin-left: 15px;
        font-size: 18px;
        text-decoration: none;
        transition: color 0.3s;
    }

    .social-icons a:hover {
        color: #495057;
    }
</style>

<footer>
    <div class="footer-content">
        <div class="footer-links">
            <div class="footer-section" style="flex: 1.5;">
                <h4 style="font-size: 20px;">I'm Ready</h4>
                <p class="brand-section">
                    여행 준비의 시작과 끝,<br>
                    가장 설레는 순간을 함께합니다.
                </p>
                <div class="newsletter-box">
                    <input type="text" class="newsletter-input" placeholder="이메일을 입력하세요">
                    <button class="btn-subscribe">구독</button>
                </div>
            </div>

            <div class="footer-section">
                <h4>회사 소개</h4>
                <ul>
                    <li><a href="#">브랜드 스토리</a></li>
                    <li><a href="#">인재 채용</a></li>
                    <li><a href="#">투자자 정보</a></li>
                    <li><a href="#">제휴 문의</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4>고객 지원</h4>
                <ul>
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">자주 묻는 질문</a></li>
                    <li><a href="#">1:1 문의하기</a></li>
                    <li><a href="#">여행자 보험 안내</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4>여행 상품</h4>
                <ul>
                    <li><a href="#">국내 호텔</a></li>
                    <li><a href="#">해외 항공권</a></li>
                    <li><a href="#">투어 & 액티비티</a></li>
                    <li><a href="#">특가 프로모션</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="left-area">
                <div class="company-info" style="margin-bottom: 10px;">
                    <span>(주)팀프로젝트 </span>
                    <span>대표: 이동준 </span>
                    <span>사업자등록번호: 123-45-67890</span>
                </div>
                <div class="company-info">
                    <span>주소: 서울특별시 강남구 테헤란로 123 </span>
                    <span>이메일: help@project.com</span>
                </div>
                <p style="margin-top: 15px;">&copy; 2026 Team Project. All Rights Reserved.</p>
            </div>
            
            <div class="social-icons">
                <a href="#">Instagram </a>
                <a href="#">Youtube </a>
                <a href="#">Facebook</a>
            </div>
        </div>
    </div>
</footer>