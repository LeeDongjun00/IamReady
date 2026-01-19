<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Team Project</title>

    <!-- Vendor -->
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a777d1f63779cfdaa66c4a1d36cc578d&libraries=services"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
      crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
      rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.js"></script>

    <!-- Global CSS -->
    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />
    <link rel="stylesheet" href="/css/main-images.css" />
    <script src="/js/page-change.js"></script>

    <style>
      :root {
        --sky-500: #0ea5e9;
        --sky-600: #0284c7;
        --indigo-500: #6366f1;

        --text: #111827;
        --muted: #6b7280;
        --bg: #ffffff;
        --card: #ffffff;

        --shadow: 0 10px 30px rgba(0, 0, 0, .08);

        --main-panels-height: 520px;
        --left-panel-width: 360px;

        --top-banner-height: 220px;
        --top-banner-height-mobile: 140px;
      }

      * {
        box-sizing: border-box
      }

      body {
        margin: 0;
        background: var(--bg);
        font-family: "Noto Sans KR", system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
        color: var(--text);
      }

      .content-wrapper {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0px 20px 40px;
      }

      /* ================================
         최상단 광고 배너 (Swiper)
      ================================ */
      .top-banner-wrap {
        width: 100%;
        border-radius: 18px;
        overflow: hidden;
        background: #fff;
        box-shadow: var(--shadow);
        margin: 18px 0 18px;
        position: relative;
      }

      .top-banner-slider {
        width: 100%;
        height: var(--top-banner-height);
        position: relative;
      }

      @media (max-width: 820px) {
        .top-banner-slider {
          height: var(--top-banner-height-mobile);
        }
      }

      .top-banner-slider .swiper-slide img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: transform .25s ease, filter .25s ease;
        filter: saturate(.95) contrast(1.02);
      }

      .top-banner-wrap:hover .swiper-slide img {
        transform: scale(1.02);
        filter: saturate(1.05) contrast(1.08);
      }

      .top-banner-prev,
      .top-banner-next {
        opacity: 0;
        pointer-events: none;
        transition: opacity .18s ease, transform .18s ease;
      }

      .top-banner-wrap:hover .top-banner-prev,
      .top-banner-wrap:hover .top-banner-next {
        opacity: 1;
        pointer-events: auto;
      }

      .top-banner-wrap:hover .top-banner-prev {
        transform: translateX(2px);
      }

      .top-banner-wrap:hover .top-banner-next {
        transform: translateX(-2px);
      }

      .top-banner-prev {
        left: 10px;
      }

      .top-banner-next {
        right: 10px;
      }

      .top-banner-prev::after,
      .top-banner-next::after {
        font-size: 22px;
        font-weight: 900;
        color: #fff;
        text-shadow: 0 6px 16px rgba(0, 0, 0, .35);
      }

      .top-banner-pagination {
        position: absolute;
        left: 0;
        right: 0;
        bottom: 10px;
        z-index: 5;
      }

      .top-banner-pagination .swiper-pagination-bullet {
        opacity: .45;
      }

      .top-banner-pagination .swiper-pagination-bullet-active {
        opacity: 1;
      }

      /* ================================
         배너 아래 2컬럼
      ================================ */
      .main-panels {
        display: grid;
        grid-template-columns: var(--left-panel-width) 1fr;
        gap: 18px;
        align-items: stretch;
      }

      @media (max-width: 980px) {
        :root {
          --left-panel-width: 320px;
        }
      }

      @media (max-width: 820px) {
        .main-panels {
          grid-template-columns: 1fr;
        }
      }

      /* ================================
         좌측: 지역 탭 + 대표 이미지(빈칸)
      ================================ */
      .left-card {
        background: var(--card);
        border-radius: 16px;
        box-shadow: var(--shadow);
        padding: 14px;
        height: var(--main-panels-height);
        display: flex;
        flex-direction: column;
        gap: 12px;
      }

      @media (max-width: 820px) {
        .left-card {
          height: auto;
        }
      }

      .region-top {
        display: flex;
        flex-direction: column;
        gap: 10px;
      }

      .region-title {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 10px;
      }

      .region-title .left {
        display: flex;
        align-items: flex-start;
        gap: 10px;
      }

      .badge {
        width: 34px;
        height: 34px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        background: linear-gradient(180deg, rgba(14, 165, 233, .15) 0%, rgba(2, 132, 199, .10) 100%);
        border: 1px solid rgba(2, 132, 199, .18);
        color: var(--sky-600);
        flex: 0 0 auto;
        margin-top: 2px;
      }

      .region-title h3 {
        margin: 0;
        font-size: 1.05rem;
        letter-spacing: -0.2px;
      }

      .region-title p {
        margin: 2px 0 0;
        font-size: .82rem;
        color: var(--muted);
        line-height: 1.35;
      }

      .selected-pill {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 10px;
        border-radius: 999px;
        background: #f8fafc;
        border: 1px solid rgba(0, 0, 0, .06);
        color: #111;
        font-weight: 900;
        font-size: .85rem;
        white-space: nowrap;
        max-width: 160px;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .selected-pill .dot {
        width: 10px;
        height: 10px;
        border-radius: 999px;
        background: linear-gradient(180deg, var(--sky-500), var(--sky-600));
        box-shadow: 0 8px 18px rgba(2, 132, 199, .25);
      }

      .region-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 8px;
      }

      .region-btn {
        appearance: none;
        border: 1px solid rgba(0, 0, 0, .08);
        background: #fff;
        color: #111827;
        height: 38px;
        border-radius: 12px;
        font-weight: 900;
        font-size: .88rem;
        cursor: pointer;
        transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease, background .12s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        user-select: none;
      }

      .region-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 10px 22px rgba(2, 132, 199, .10);
        border-color: rgba(2, 132, 199, .25);
      }

      .region-btn.is-active {
        background: linear-gradient(180deg, var(--sky-500) 0%, var(--sky-600) 100%);
        color: #fff;
        border-color: transparent;
        box-shadow: 0 12px 26px rgba(2, 132, 199, .22);
      }

      .region-btn .mini-ico {
        font-size: 14px;
        opacity: .9;
      }

      .left-actions {
        display: flex;
        gap: 8px;
      }

      .btn-soft {
        flex: 1;
        height: 40px;
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, .08);
        background: #fff;
        font-weight: 900;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease;
      }

      .btn-soft:hover {
        transform: translateY(-1px);
        box-shadow: 0 10px 22px rgba(99, 102, 241, .10);
        border-color: rgba(99, 102, 241, .25);
      }

      .btn-soft:disabled {
        opacity: .55;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
      }

      .btn-primary {
        background: linear-gradient(180deg, var(--indigo-500) 0%, #4f46e5 100%);
        border-color: transparent;
        color: #fff;
        box-shadow: 0 12px 26px rgba(79, 70, 229, .22);
      }

      .btn-primary:hover {
        box-shadow: 0 14px 28px rgba(79, 70, 229, .26);
      }

      .spot-card {
        flex: 1;
        min-height: 0;
        border-radius: 14px;
        overflow: hidden;
        border: 1px solid rgba(0, 0, 0, .08);
        background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%);
        position: relative;
      }

      .spot-card .img-placeholder {
        width: 100%;
        height: 100%;
        background:
          radial-gradient(900px 200px at 20% 20%, rgba(14, 165, 233, .18), transparent 60%),
          radial-gradient(700px 220px at 70% 35%, rgba(99, 102, 241, .16), transparent 60%),
          linear-gradient(180deg, rgba(255, 255, 255, .6), rgba(255, 255, 255, .2));
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        padding: 14px;
      }

      .spot-card .spot-meta {
        background: rgba(255, 255, 255, .70);
        border: 1px solid rgba(0, 0, 0, .06);
        border-radius: 12px;
        padding: 10px 12px;
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        box-shadow: 0 10px 26px rgba(0, 0, 0, .08);
      }

      .spot-card .spot-meta .name {
        font-weight: 1000;
        letter-spacing: -0.2px;
        font-size: 1rem;
        margin: 0 0 2px;
      }

      .spot-card .spot-meta .desc {
        margin: 0;
        color: var(--muted);
        font-size: .82rem;
        line-height: 1.35;
      }

      /* ================================
         ✅ 우측: 카카오 지도 (여백/붕뜸 제거 최종)
         핵심:
         1) .right-card는 position:relative + padding 0 강제
         2) .map_wrap, #map을 absolute + inset:0 으로 강제
         3) #map에 border-radius 주고 싶으면 "wrapper"에만 주기 (중복 radius로 틈 생길 수 있어 wrapper에만)
      ================================ */
      .right-card {
        background: var(--card);
        border-radius: 16px;
        box-shadow: var(--shadow);
        overflow: hidden;
        height: var(--main-panels-height);
        position: relative;
        padding: 0 !important;
      }

      @media (max-width: 820px) {
        .right-card {
          height: 420px;
        }
      }

      .map_wrap {
        position: absolute !important;
        inset: 0 !important;
        width: 100% !important;
        height: 100% !important;
        padding: 0 !important;
        margin: 0 !important;

        /* ✅ 혹시 global flex 정렬 걸려있을 때 방어 */
        display: block !important;
        align-items: stretch !important;
        justify-content: stretch !important;

        background: linear-gradient(180deg, #eaf4ff 0%, #f6f9ff 100%);
        overflow: hidden;
        /* ✅ radius는 여기서 처리 */
        border-radius: 16px;
        /* ✅ radius는 wrapper에만 */
      }

      #map {
        position: absolute !important;
        inset: 0 !important;
        width: 100% !important;
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;

        /* ✅ #map에는 radius 주지 마세요(가끔 타일 렌더링과 겹치며 '틈'처럼 보임) */
        border-radius: 0 !important;
      }

      .map-top-overlay {
        position: absolute;
        top: 16px;
        left: 16px;
        right: 16px;
        z-index: 10;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
        pointer-events: none;
      }

      .map-top-overlay .chip {
        pointer-events: auto;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 12px;
        border-radius: 999px;
        background: rgba(255, 255, 255, .82);
        border: 1px solid rgba(0, 0, 0, .06);
        box-shadow: 0 10px 24px rgba(0, 0, 0, .08);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        font-weight: 1000;
        font-size: .9rem;
      }

      .map-top-overlay .chip .dot {
        width: 10px;
        height: 10px;
        border-radius: 999px;
        background: linear-gradient(180deg, var(--sky-500), var(--sky-600));
      }

      .map-top-overlay .ghost-btn {
        pointer-events: auto;
        height: 40px;
        padding: 0 14px;
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, .06);
        background: rgba(255, 255, 255, .82);
        cursor: pointer;
        font-weight: 1000;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 10px 24px rgba(0, 0, 0, .08);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        transition: transform .12s ease, box-shadow .12s ease;
      }

      .map-top-overlay .ghost-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 12px 26px rgba(0, 0, 0, .10);
      }

      .map-top-overlay .ghost-btn:disabled {
        opacity: .55;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
      }

      /* ✅ 하단 입력바 */
      .map-bottom-bar {
        position: absolute;
        left: 50%;
        bottom: 16px;
        transform: translateX(-50%);
        width: min(780px, calc(100% - 32px));
        z-index: 11;

        display: flex;
        align-items: center;
        gap: 10px;

        padding: 10px;
        border-radius: 18px;

        /* glass */
        background: rgba(255, 255, 255, .72);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);

        /* gradient border 느낌 */
        border: 1px solid rgba(255, 255, 255, .55);
        box-shadow:
          0 18px 40px rgba(0, 0, 0, .12),
          inset 0 1px 0 rgba(255, 255, 255, .65);
      }

      /* 세그먼트형 필드 */
      .map-bottom-field {
        flex: 1;
        min-width: 0;
        height: 46px;

        display: flex;
        align-items: center;
        gap: 10px;

        padding: 0 14px;
        border-radius: 14px;

        background: rgba(255, 255, 255, .85);
        border: 1px solid rgba(0, 0, 0, .06);
        box-shadow: inset 0 1px 0 rgba(255, 255, 255, .9);

        transition: box-shadow .15s ease, border-color .15s ease, transform .15s ease;
      }

      /* focus가 들어오면 “링” 강조 */
      .map-bottom-field:focus-within {
        border-color: rgba(14, 165, 233, .35);
        box-shadow:
          0 10px 22px rgba(2, 132, 199, .12),
          0 0 0 4px rgba(2, 132, 199, .14),
          inset 0 1px 0 rgba(255, 255, 255, .9);
        transform: translateY(-1px);
      }

      .map-bottom-field .label {
        font-size: 12px;
        font-weight: 1000;
        color: #0f172a;
        white-space: nowrap;
        letter-spacing: -.2px;

        display: flex;
        align-items: center;
        gap: 6px;
      }

      /* 라벨 앞 작은 아이콘 느낌 */
      .map-bottom-field .label::before {
        content: "";
        width: 18px;
        height: 18px;
        border-radius: 8px;
        background: linear-gradient(180deg, rgba(14, 165, 233, .20), rgba(99, 102, 241, .16));
        border: 1px solid rgba(2, 132, 199, .16);
        box-shadow: 0 10px 18px rgba(2, 132, 199, .10);
      }

      /* input은 더 미니멀하게 */
      .map-bottom-field input {
        width: 100%;
        border: none;
        outline: none;
        background: transparent;
        font-size: 14px;
        font-weight: 800;
        color: #111827;
      }

      .map-bottom-field input::placeholder {
        color: rgba(100, 116, 139, .75);
        font-weight: 700;
      }

      /* 버튼: 더 “버튼답게” */
      .btn-start-trip {
        flex: 0 0 auto;
        height: 46px;
        padding: 0 18px;
        border: none;
        border-radius: 14px;

        font-weight: 1000;
        letter-spacing: -.2px;
        color: #fff;
        cursor: pointer;

        background: linear-gradient(135deg, var(--sky-500) 0%, var(--sky-600) 60%, #2563eb 100%);
        box-shadow:
          0 16px 30px rgba(2, 132, 199, .25),
          inset 0 1px 0 rgba(255, 255, 255, .35);

        transition: transform .12s ease, box-shadow .12s ease, filter .12s ease;
      }

      .btn-start-trip:hover {
        transform: translateY(-1px);
        filter: saturate(1.05) contrast(1.02);
        box-shadow:
          0 18px 36px rgba(2, 132, 199, .30),
          inset 0 1px 0 rgba(255, 255, 255, .35);
      }

      .btn-start-trip:active {
        transform: translateY(0);
        box-shadow:
          0 12px 24px rgba(2, 132, 199, .22),
          inset 0 2px 8px rgba(0, 0, 0, .18);
      }

      /* ================================
         - 요구: images 경로 고정
         - 요구: 3장(region_1,2,3) / 화살표 좌우 / 루프(A) + 오토플레이(C)
         - 요구: 한 번에 2장씩 노출
      ================================ */
      .below-panels {
        margin-top: 18px;
        display: grid;
        grid-template-columns: 360px 1fr;
        gap: 18px;
        align-items: stretch;
      }

      @media (max-width: 980px) {
        .below-panels {
          grid-template-columns: 320px 1fr;
        }
      }

      @media (max-width: 820px) {
        .below-panels {
          grid-template-columns: 1fr;
        }
      }

      /* ================================
   프리미엄 광고 카드 (이미지 꽉 채우기)
================================ */
      .premium-ad-card {
        position: relative;
        height: 190px;
        /* 원하는 높이 (필요시 조절) */
        background: transparent;
        /* 배경 제거 */
        border: 4.5px solid #22c55e;
        /* 테두리 제거 */
        border-radius: 0;
        /* 카드 느낌 제거 */
        box-shadow: none;
        /* 그림자 제거 */
        overflow: hidden;
        border-radius: 16px;
      }

      .premium-ad-card img {
        position: absolute;
        inset: 0;
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
        /* ✅ 비율 유지 + 가득 채우기 */
        object-position: center;
      }


      /* ================================
   추천 여행지 카드 (박스 완전 제거)
================================ */
      .region-carousel-card {
        background: transparent !important;
        border: none !important;
        border-radius: 0 !important;
        box-shadow: none !important;
        padding: 0 !important;
        overflow: hidden;
      }

      .region-carousel-card img {
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
      }

      .region-carousel-card {
        background: var(--card);
        border-radius: 16px;
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid rgba(0, 0, 0, .06);
        position: relative;
        padding: 14px 14px 16px;
      }

      .region-carousel-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        margin-bottom: 10px;
      }

      .region-carousel-head h3 {
        margin: 0;
        font-size: 1.05rem;
        letter-spacing: -0.2px;
      }

      .region-carousel-head p {
        margin: 3px 0 0;
        font-size: .82rem;
        color: var(--muted);
      }

      .region-carousel-title {
        display: flex;
        align-items: flex-start;
        gap: 10px;
      }

      .region-carousel-badge {
        width: 34px;
        height: 34px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        background: linear-gradient(180deg, rgba(99, 102, 241, .14) 0%, rgba(14, 165, 233, .10) 100%);
        border: 1px solid rgba(79, 70, 229, .16);
        color: #4f46e5;
        flex: 0 0 auto;
        margin-top: 2px;
      }

      .region-carousel-nav {
        display: flex;
        gap: 8px;
        align-items: center;
        flex: 0 0 auto;
      }

      .region-nav-btn {
        width: 38px;
        height: 38px;
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, .08);
        background: rgba(255, 255, 255, .85);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 10px 18px rgba(0, 0, 0, .06);
        transition: transform .12s ease, box-shadow .12s ease, opacity .12s ease;
      }

      .region-nav-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 12px 22px rgba(0, 0, 0, .08);
      }

      .region-nav-btn:active {
        transform: translateY(0);
        box-shadow: 0 10px 18px rgba(0, 0, 0, .06);
      }

      .region-carousel-slider {
        border-radius: 14px;
        overflow: hidden;
      }

      .region-carousel-slider .swiper-wrapper {
        align-items: stretch;
      }

      .region-carousel-slider .swiper-slide {
        height: 140px;
        border-radius: 14px;
        overflow: hidden;
      }

      @media (max-width: 820px) {
        .region-carousel-slider .swiper-slide {
          height: 160px;
        }
      }

      .region-carousel-slider .swiper-slide img {
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
        transition: transform .25s ease, filter .25s ease;
        filter: saturate(.98) contrast(1.02);
      }

      .region-carousel-slider .swiper-slide:hover img {
        transform: scale(1.03);
        filter: saturate(1.05) contrast(1.06);
      }

      /* ================================
         아래 후기/게시글 CSS (원문 유지)
      ================================ */
      .swiper-container {
        width: 100%;
        height: 330px;
        margin: 40px 0;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, .1);
        position: relative;
        background: #fff;
      }

      .swiper-slide {
        display: flex;
        justify-content: center;
        align-items: center;
      }

      .swiper-button-next,
      .swiper-button-prev {
        color: #0078ff;
        transition: opacity .2s ease;
      }

      .swiper-button-next:hover,
      .swiper-button-prev:hover {
        opacity: .8;
      }

      .swiper-slide .card {
        width: 335px;
      }

      .card-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        max-width: 1200px;
        margin: 0 auto;
      }

      .card {
        position: relative;
        height: 320px;
        perspective: 1000px;
        border-radius: 15px;
      }

      .card-inner {
        position: relative;
        width: 335px;
        height: 100%;
        transition: transform .8s;
        transform-style: preserve-3d;
      }

      .card:hover .card-inner {
        transform: rotateY(180deg);
      }

      .card-front,
      .card-back {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 15px;
        overflow: hidden;
        backface-visibility: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, .08);
        background: #fff;
      }

      .card-front img {
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
        background: #ddd;
      }

      .card-back {
        transform: rotateY(180deg);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }

      .card-body {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
        padding: 18px 20px;
      }

      .card-box {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
      }

      .card-theme {
        display: inline-block;
        background: #e3f2fd;
        color: #1976d2;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: .8em;
        font-weight: 500;
        margin: 0 6px 6px 0;
      }

      .material-symbols-outlined {
        font-variation-settings: "FILL" 0, "wght" 400, "GRAD" 0, "opsz" 48;
        color: #777;
        font-size: 24px;
        cursor: pointer;
        transition: all .2s ease;
      }

      .material-symbols-outlined.liked {
        font-variation-settings: "FILL" 1;
        color: #e53935;
      }

      .card-cnt {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: .85em;
        color: #666;
      }

      .card-title {
        font-size: 1.2em;
        font-weight: 600;
        color: #222;
        margin-bottom: 6px;
        line-height: 1.4;
      }

      .card-desc {
        font-size: .95em;
        color: #555;
        line-height: 1.5;
        flex: 1;
        margin-bottom: 10px;
      }

      .card-info {
        font-size: .9em;
        color: #777;
        margin-bottom: 12px;
      }

      .card-footer button {
        width: 100%;
        padding: 8px 0;
        background: #0078ff;
        border: none;
        color: #fff;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: background .2s;
      }

      .card-footer button:hover {
        background: #005fcc;
      }

      .bestCard-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
        max-width: 1200px;
        margin: 0 auto 40px;
      }

      .bestCard-container .card {
        background: var(--card);
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, .08);
        cursor: pointer;
        transition: transform .3s ease, box-shadow .3s ease;
        display: flex;
        flex-direction: column;
        height: auto;
        perspective: none;
      }

      .bestCard-container .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, .12);
      }

      .bestCard-container .card-body {
        padding: 15px;
        display: flex;
        flex-direction: column;
        flex: 1;
      }

      .bestCard-container .card-title {
        font-size: 1.15em;
        font-weight: 600;
        margin-bottom: 8px;
        color: #222;
      }

      .bestCard-container .card-desc {
        font-size: .95em;
        color: #555;
        flex: 1;
        margin-bottom: 10px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
      }

      .bestCard-container .card-info {
        font-size: .9em;
        color: #777;
        margin-bottom: 10px;
      }

      .bestCard-container .card-cnt {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 5px;
        font-size: .85em;
        color: #666;
      }

      .bestCard-container .material-symbols-outlined {
        font-variation-settings: "FILL" 0, "wght" 400, "GRAD" 0, "opsz" 48;
        color: #777;
        font-size: 20px;
        cursor: pointer;
        transition: all .2s ease;
      }

      .bestCard-container .material-symbols-outlined.liked {
        font-variation-settings: "FILL" 1;
        color: #e53935;
      }

      h2 {
        font-size: 22px;
        margin: 0 0 20px;
        text-align: center;
        color: #333;
      }





      /* ✅ 배경 오버레이 */
.popup-overlay{
  position: fixed;
  top:0; left:0; right:0; bottom:0;
  background: rgba(0,0,0,0.6);
  z-index: 999;   /* 팝업(1000)보다 1 낮게 */
  display:none;
}

/* ✅ 팝업이 오버레이 위로 오게 */
.sub-popup{
  z-index: 1000;
}
      /* ================================
   ✅ 구독 혜택 팝업 스타일
================================ */
.sub-popup{
  position: fixed;
  top: 250px;
  left: 50px;
  width: 520px;
  max-width: calc(100vw - 24px);
  background: #fff;
  border: 1px solid rgba(0,0,0,.10);
  border-radius: 14px;
  padding: 22px 22px 16px;
  z-index: 1000;
  box-shadow: 0 18px 45px rgba(0,0,0,.18);
}

.sub-popup__x{
  position:absolute;
  top:10px;
  right:12px;
  width:34px;
  height:34px;
  border:none;
  background:transparent;
  font-size:26px;
  line-height:34px;
  cursor:pointer;
  color:#111;
  opacity:.65;
}
.sub-popup__x:hover{ opacity:1; }

.sub-popup__title{
  margin: 0 0 30px 10px;
  font-size: 44px;
  line-height: 1.05;
  letter-spacing: -0.5px;
}

.sub-popup__desc{
  text-align: center;
  font-size: 16px;
  color:#222;
  line-height:1.5;
  margin-bottom: 16px;
}

.sub-popup__grid{
  display:flex;
  flex-direction:column;
  gap: 16px;
}

.sub-popup__row{
  display:grid;
  grid-template-columns: 1fr 30px 1fr;
  align-items:center;
  gap: 10px;
}

.sub-popup__card{
  margin:0;
  background:#fff;
  border: 1px solid rgba(0,0,0,.08);
  border-radius: 8px;
  overflow:hidden;
  min-height: 120px;
  display:flex;
  flex-direction:column;
}

.sub-popup__card img{
  width:100%;
  height: 150px;
  object-fit: cover;
  background:#f3f4f6;
  display:block;
}

.sub-popup__arrow{
  text-align:center;
  font-size: 26px;
  font-weight: 700;
  color:#111;
  opacity:.7;
}

.sub-popup__cap{
  padding: 10px 10px 12px;
  text-align:center;
  font-size: 16px;
  font-weight: 700;
  color:#111;
}

.sub-popup__hr{
  border:none;
  border-top: 1px solid rgba(0,0,0,.10);
  margin: 14px 0 12px;
}

.sub-popup__footer{
  display:flex;
  justify-content:space-between;
  align-items:center;
  gap: 10px;
}

.sub-popup__check{
  font-size: 14px;
  color:#111;
  display:flex;
  align-items:center;
  gap:8px;
}

.sub-popup__btn{
  border:none;
  background:#0ea5e9;
  color:#fff;
  font-weight:700;
  border-radius: 8px;
  padding: 8px 14px;
  cursor:pointer;
}
.sub-popup__btn:hover{ opacity:.92; }

@media (max-width: 560px){
  .sub-popup{
    left: 12px;
    right: 12px;
    width: auto;
    top: 12px;
  }
  .sub-popup__title{ font-size: 34px; }
  .sub-popup__row{ grid-template-columns: 1fr 26px 1fr; }
  .sub-popup__card img{ height: 120px; }
}
    </style>
  </head>

  <body>
    <%@ include file="components/header.jsp" %>

      <div id="app">
        <div class="content-wrapper">

          <!-- ✅ 최상단 광고 배너 -->
          <div class="top-banner-wrap">
            <div class="swiper top-banner-slider">
              <div class="swiper-wrapper">
                <div class="swiper-slide"><img src="/images/banner_1.png" alt="banner_1" /></div>
                <div class="swiper-slide"><img src="/images/banner_2.png" alt="banner_2" /></div>
                <div class="swiper-slide"><img src="/images/banner_3.png" alt="banner_3" /></div>
                <div class="swiper-slide"><img src="/images/banner_4.png" alt="banner_4" /></div>
                <div class="swiper-slide"><img src="/images/banner_5.png" alt="banner_5" /></div>
                <div class="swiper-slide"><img src="/images/banner_6.png" alt="banner_6" /></div>
                <div class="swiper-slide"><img src="/images/banner_7.png" alt="banner_7" /></div>
                <div class="swiper-slide"><img src="/images/banner_8.png" alt="banner_8" /></div>
                <div class="swiper-slide"><img src="/images/banner_9.png" alt="banner_9" /></div>
                <div class="swiper-slide"><img src="/images/banner_10.png" alt="banner_10" /></div>
              </div>

              <div class="swiper-pagination top-banner-pagination"></div>
              <div class="swiper-button-prev top-banner-prev"></div>
              <div class="swiper-button-next top-banner-next"></div>
            </div>
          </div>

          <!-- ✅ 메인 2컬럼 -->
          <div class="main-panels">

            <!-- ✅ 좌측: 지역 탭 + 대표명소(빈 이미지 자리) -->
            <aside class="left-card">
              <div class="region-top">
                <div class="region-title">
                  <div class="left">
                    <div class="badge"><i class="fa-solid fa-location-dot"></i></div>
                    <div>
                      <h3>어디로 가볼까요</h3>
                      <p>지역을 선택하면 우측 지도가 랜덤 장소로 이동합니다</p>
                    </div>
                  </div>
                </div>

                <div class="region-grid">
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='seoul' }"
                    @click="fnSelectRegion('seoul')">
                    <i class="fa-solid fa-city mini-ico"></i>서울
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='gyeonggi' }"
                    @click="fnSelectRegion('gyeonggi')">
                    <i class="fa-solid fa-mountain-sun mini-ico"></i>경기
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='incheon' }"
                    @click="fnSelectRegion('incheon')">
                    <i class="fa-solid fa-water mini-ico"></i>인천
                  </button>

                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='gangwon' }"
                    @click="fnSelectRegion('gangwon')">
                    <i class="fa-solid fa-person-snowboarding mini-ico"></i>강원
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='chungnam' }"
                    @click="fnSelectRegion('chungnam')">
                    <i class="fa-solid fa-tree mini-ico"></i>충남
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='jeonbuk' }"
                    @click="fnSelectRegion('jeonbuk')">
                    <i class="fa-solid fa-landmark mini-ico"></i>전북
                  </button>

                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='daegu' }"
                    @click="fnSelectRegion('daegu')">
                    <i class="fa-solid fa-route mini-ico"></i>대구
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='busan' }"
                    @click="fnSelectRegion('busan')">
                    <i class="fa-solid fa-umbrella-beach mini-ico"></i>부산
                  </button>
                  <button class="region-btn" :class="{ 'is-active': selectedRegionKey==='jeju' }"
                    @click="fnSelectRegion('jeju')">
                    <i class="fa-solid fa-volcano mini-ico"></i>제주
                  </button>
                </div>

                <div class="left-actions">
                  <button class="btn-soft" type="button" @click="fnRandomMove" :disabled="!selectedRegionKey">
                    <i class="fa-solid fa-dice"></i> 다른 장소 추천
                  </button>
                  <button class="btn-soft btn-primary" type="button" @click="fnSelectRegionByRandom">
                    <i class="fa-solid fa-wand-magic-sparkles"></i> 랜덤 지역
                  </button>
                </div>
              </div>

              <div class="spot-card">
                <div class="img-placeholder">
                  <div class="spot-meta">
                    <p class="name">{{ spotTitle }}</p>
                    <p class="desc">※ 이미지 자리(추후 해당 지역 대표 명소 사진으로 교체)</p>
                  </div>
                </div>
              </div>
            </aside>

            <!-- ✅ 우측: 카카오 지도 -->
            <section class="right-card">
              <div class="map_wrap">
                <div id="map"></div>

                <div class="map-top-overlay">
                  <div class="chip">
                    <span class="dot"></span>
                    <span>{{ selectedRegionName || '지역을 선택해 주세요' }}</span>
                  </div>
                  <button class="ghost-btn" type="button" @click="fnRandomMove" :disabled="!selectedRegionKey">
                    <i class="fa-solid fa-location-crosshairs"></i> 랜덤 이동
                  </button>
                </div>

                <div class="map-bottom-bar">
                  <div class="map-bottom-field">
                    <span class="label">인원수</span>
                    <input type="number" min="1" v-model.number="headCount" placeholder="예: 2" />
                  </div>
                  <div class="map-bottom-field">
                    <span class="label">예산</span>
                    <input type="number" min="0" v-model.number="budget" placeholder="예: 300000" />
                  </div>
                  <button type="button" class="btn-start-trip" @click="fnStartTrip">여행하기</button>
                </div>
              </div>
            </section>

          </div><!-- /main-panels -->

          <!-- 프리미엄 광고 + 추천 여행지 둘러보기 -->
          <div class="below-panels">
            <!-- 좌측: 플랫폼 광고 -->
            <div class="premium-ad-card">
              <img src="/images/premium_ad.png" alt="premium_ad" />
            </div>

            <!-- 우측: 추천 여행지 둘러보기(캐러셀) -->
            <div class="region-carousel-card">
              <div class="region-carousel-head">
                <div class="region-carousel-title">
                  <div class="region-carousel-badge"><i class="fa-solid fa-compass"></i></div>
                  <div>
                    <h3>추천 여행지 둘러보기</h3>
                  </div>
                </div>

                <div class="region-carousel-nav">
                  <button class="region-nav-btn region-prev" type="button" aria-label="prev">
                    <i class="fa-solid fa-chevron-left"></i>
                  </button>
                  <button class="region-nav-btn region-next" type="button" aria-label="next">
                    <i class="fa-solid fa-chevron-right"></i>
                  </button>
                </div>
              </div>

              <div class="swiper region-carousel-slider">
                <div class="swiper-wrapper">
                  <div class="swiper-slide">
                    <img src="/images/region_1.png" alt="region_1" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_2.png" alt="region_2" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_3.png" alt="region_3" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 후기 슬라이더 -->
          <div class="swiper review-slider" style="margin-top:40px">
            <h2>추천 후기글</h2>
            <div class="swiper-wrapper">
              <div class="swiper-slide card" v-for="item in list" :key="item.resNum" @click="fnDetail(item.resNum)">
                <div class="card-inner">
                  <div class="card-front">
                    <img class="card-img" :src="thumbnailMap[item.resNum]?.firstimage || getRandomImage()"
                      :alt="item.packname" />
                  </div>
                  <div class="card-back">
                    <div class="card-body">
                      <div class="card-box">
                        <div>
                          <div class="card-theme" v-for="tag in item.themNum.split(',')" :key="tag">{{ tag }}</div>
                        </div>
                        <div style="display:flex">
                          <span class="material-symbols-outlined" :class="{ liked: item.liked }"
                            @click.stop="toggleLike(item)">favorite</span>
                          <div>{{ item.fav }}</div>
                        </div>
                      </div>

                      <div class="card-box">
                        <div class="card-title">{{ item.packname }}</div>
                        <div class="card-cnt">
                          <span class="material-symbols-outlined">visibility</span>
                          <div>{{ item.cnt }}</div>
                        </div>
                      </div>

                      <div class="card-desc">{{ item.descript }}</div>

                      <div class="card-info">
                        💰 {{ Number(item.price).toLocaleString() }}원 <br />
                        👤 {{ item.userId }}
                      </div>

                      <div class="card-footer">
                        <button @click.stop="fnDetail(item.resNum)">상세보기</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="swiper-button-next review-button-next"></div>
            <div class="swiper-button-prev review-button-prev"></div>
          </div>

          <!-- 추천 게시글 -->
          <div style="margin-top:24px">
            <h2>추천 게시글</h2>
            <div class="bestCard-container">
              <div class="card" v-for="item in bestList" :key="item.resNum" @click="fnboardDetail(item.boardNo)">
                <div class="card-body">
                  <div class="card-title">{{ item.title }}</div>
                  <div class="card-cnt">
                    <div class="card-info">👤 {{ item.userId }}</div>
                    <div style="display:flex">
                      <div style="display:flex; margin-right:20px">
                        <span class="material-symbols-outlined">thumb_up</span>
                        <div>{{ item.fav }}</div>
                      </div>
                      <div style="display:flex">
                        <span class="material-symbols-outlined">visibility</span>
                        <div>{{ item.cnt }}</div>
                      </div>
                      <div style="display:flex; margin-left:20px">
                        <span class="material-symbols-outlined liked" @click.stop="toggleLike(item)">favorite</span>
                        <div>{{ item.fav }}</div>
                      </div>
                    </div>
                  </div>
                  <div class="card-desc">{{ item.contents }}</div>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>


</div> <!-- id="app 끝 -->

  <!-- ================================
     ✅ 구독 혜택 팝업 (7일간 숨김)
<div id="popup-overlay" class="popup-overlay" style="display:none;"></div>
<div id="ad-popup" class="sub-popup" style="display:none;">
  <button class="sub-popup__x" type="button" onclick="closePopup()" aria-label="닫기">×</button>

  <h2 class="sub-popup__title">구독 혜택</h2>

  <div class="sub-popup__desc">
    <div>여행하기 예산배분 잠금 활성화</div>
    <div>일1회 경로 생성 → 무제한 이용 가능</div>
  </div>

  <div class="sub-popup__grid">
    <!-- ✅ Row 1: 예산 배분 잠금 → 해제 -->
    <div class="sub-popup__row">
      <figure class="sub-popup__card">
        <img src="/img/ad/ad1.PNG" alt="예산배분 잠금 상태" />
      </figure>

      <div class="sub-popup__arrow">→</div>

      <figure class="sub-popup__card">
        <img src="/img/ad/ad2.PNG" alt="예산배분 무제한 상태" />
      </figure>
    </div>

    <!-- ✅ Row 2: 경로 보기 1회 → 무제한 -->
    <div class="sub-popup__row">
      <figure class="sub-popup__card">
        <img src="/img/ad/ad3.PNG" alt="차량 경로 보기 1회" />
        <figcaption class="sub-popup__cap">차량 경로 보기 일 1회</figcaption>
      </figure>

      <div class="sub-popup__arrow">→</div>

      <figure class="sub-popup__card">
        <img src="/img/ad/ad3.PNG" alt="무제한 이용 가능" />
        <figcaption class="sub-popup__cap">무제한 이용 가능</figcaption>
      </figure>
    </div>
  </div>

  <hr class="sub-popup__hr" />

  <div class="sub-popup__footer">
    <label class="sub-popup__check">
      <input type="checkbox" id="today-check" />
      7일 동안 보지 않기
    </label>

    <button class="sub-popup__btn" type="button" onclick="closePopup()">닫기</button>
  </div>
</div>


    <%@ include file="components/footer.jsp" %>

    <!-- ================================
         ✅ Vue / Kakao JS
    ================================= -->
    <script>
      const app = Vue.createApp({
        data(){
          return {
            map:null,
            ps:null,
            placeOverlay:null,
            contentNode:null,
            markers:[],
            currCategory:"",
            roadview:null,
            roadviewClient:null,
            lastClickedLatLng:null,
            // 리스트
            userId: "${sessionId}",
            list:[],
            bestList:[],
            liked:false,
            thumbnailMap:{},
            page:1,
            pageSize:6,
            randomImages:[
              "/img/defaultImg01.jpg",
              "/img/defaultImg02.jpg",
              "/img/defaultImg03.jpg",
              "/img/defaultImg04.jpg",
              "/img/defaultImg05.jpg",
              "/img/defaultImg06.jpg",
            ],
          }
        },
        methods:{
          // 초기화
          init(){
            let self = this;
            kakao.maps.load(()=>{
              self.initMap();
              self.initCategory();
              self.initRoadview();
            });
            self.$nextTick(()=> self.initSwiper());
          },

          // 지도 초기화
          initMap(){
            let self = this;
            const mapContainer = document.getElementById("map");
            const mapOption = {
              center: new kakao.maps.LatLng(37.566826, 126.9786567),
              level: 5,
            };
            self.map = new kakao.maps.Map(mapContainer, mapOption);
            self.ps = new kakao.maps.services.Places(self.map);
            self.placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
            self.contentNode = document.createElement("div");
            self.placeOverlay.setContent(self.contentNode);
            kakao.maps.event.addListener(self.map, "idle", ()=> self.searchPlaces());

            // 주소 → 좌표 변환 후 "내 위치" 커스텀 마커 + 말풍선
            let geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch("인천광역시 부평구 부평1동 534-48", function (result, status) {
              if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 1) 커스텀 SVG 핀
                const svgPin = `
                  <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36">
                    <defs>
                      <linearGradient id="g" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stop-color="#0ea5e9"/>
                        <stop offset="100%" stop-color="#0284c7"/>
                      </linearGradient>
                    </defs>
                    <path class="my-location-marker-shadow"
                      d="M18 2c-6.1 0-11 4.86-11 10.86 0 7.67 9.47 18.6 10.16 19.39a1.15 1.15 0 0 0 1.68 0C19.53 31.46 29 20.53 29 12.86 29 6.86 24.1 2 18 2z"
                      fill="url(#g)"/>
                    <circle cx="18" cy="13" r="4.6" fill="#fff"/>
                  </svg>`;
                const markerImage = new kakao.maps.MarkerImage(
                  'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(svgPin),
                  new kakao.maps.Size(36,36),
                  { offset: new kakao.maps.Point(18,36) }
                );
                var marker = new kakao.maps.Marker({
                  map: self.map,
                  position: coords,
                  image: markerImage
                });

                self.$nextTick(() => {
                  self.initTopBannerSwiper();
                  self.initSwiper();

                  /* ✅ (추가) 추천 여행지 둘러보기 Swiper 초기화 */
                  self.initRegionSwiper();
                });
              }

              /* ✅ 지도 생성 + relayout 강제 (붕 뜨는 문제 해결: 최종 방어 버전) */
              initMap() {
                const self = this;
                const mapContainer = document.getElementById("map");

                const center = new kakao.maps.LatLng(37.566826, 126.9786567);
                self.map = new kakao.maps.Map(mapContainer, { center, level: 7 });
                self.marker = new kakao.maps.Marker({ position: center, map: self.map });

                // ✅ 0) 화면 레이아웃이 진짜 잡힌 다음에 relayout (2번)
                requestAnimationFrame(() => {
                  if (!self.map) return;
                  self.map.relayout();
                  self.map.setCenter(center);
                });

                setTimeout(() => {
                  if (!self.map) return;
                  self.map.relayout();
                  if (self.marker) self.map.setCenter(self.marker.getPosition());
                }, 220);

                // ✅ 1) 브라우저 리사이즈
                window.addEventListener("resize", () => {
                  if (!self.map) return;
                  self.map.relayout();
                  if (self.marker) self.map.setCenter(self.marker.getPosition());
                });

                // ✅ 2) 폰트 로딩(구글폰트가 늦게 적용되며 레이아웃 바뀌는 경우)
                if (document.fonts && document.fonts.ready) {
                  document.fonts.ready.then(() => {
                    if (!self.map) return;
                    self.map.relayout();
                    if (self.marker) self.map.setCenter(self.marker.getPosition());
                  });
                }
              },

              fnSelectRegion(key) {
                const self = this;
                const info = self.REGION[key];
                if (!info) return;

                self.selectedRegionKey = key;
                self.selectedRegionName = info.name;
                self.spotTitle = info.spot;

                self.fnRandomMove();
              },

              fnSelectRegionByRandom() {
                const self = this;
                const keys = Object.keys(self.REGION);
                const pick = keys[Math.floor(Math.random() * keys.length)];
                self.fnSelectRegion(pick);
              },

              fnRandomMove() {
                const self = this;
                if (!self.selectedRegionKey || !self.map) return;

                const info = self.REGION[self.selectedRegionKey];
                const lat = info.lat + (Math.random() - 0.5) * info.jitter;
                const lng = info.lng + (Math.random() - 0.5) * info.jitter;

                const target = new kakao.maps.LatLng(lat, lng);
                const level = (self.selectedRegionKey === 'seoul' || self.selectedRegionKey === 'busan' || self.selectedRegionKey === 'daegu' || self.selectedRegionKey === 'incheon')
                  ? 7 : 9;

                self.map.setLevel(level);
                self.map.panTo(target);

                if (self.marker) self.marker.setPosition(target);

                // ✅ 이동 직후에도 relayout 1회 (처음 선택 시 특히)
                requestAnimationFrame(() => {
                  if (!self.map) return;
                  self.map.relayout();
                  if (self.marker) self.map.setCenter(self.marker.getPosition());
                });
              },

              initTopBannerSwiper() {
                if (this.topBannerSwiper) return;

                this.topBannerSwiper = new Swiper(".top-banner-slider", {
                  loop: true,
                  autoplay: { delay: 6000, disableOnInteraction: false },
                  speed: 650,
                  slidesPerView: 1,
                  pagination: { el: ".top-banner-pagination", clickable: true },
                  navigation: { nextEl: ".top-banner-next", prevEl: ".top-banner-prev" },
                });

                // ✅ Swiper가 레이아웃에 영향 줄 때 지도 리레이아웃
                this.topBannerSwiper.on("transitionEnd", () => {
                  if (this.map) {
                    this.map.relayout();
                    if (this.marker) this.map.setCenter(this.marker.getPosition());
                  }
                });
              },

              initSwiper() {
                let self = this;
                if (!self.reviewSwiper) {
                  self.reviewSwiper = new Swiper(".review-slider", {
                    loop: true,
                    autoplay: { delay: 4000, disableOnInteraction: false },
                    slidesPerView: 3,
                    spaceBetween: 20,
                    navigation: { nextEl: ".swiper-button-next", prevEl: ".swiper-button-prev" },
                    breakpoints: { 640: { slidesPerView: 1 }, 1024: { slidesPerView: 2 }, 1440: { slidesPerView: 3 } },
                  });
                }
              },

              /* ✅ (추가) 추천 여행지 둘러보기: 루프(A) + 오토플레이(C) + 한 번에 2장 */
              initRegionSwiper() {
                const self = this;
                if (self.regionSwiper) return;

                self.regionSwiper = new Swiper(".region-carousel-slider", {
                  loop: true,
                  speed: 650,
                  slidesPerView: 2,
                  spaceBetween: 14,
                  autoplay: {
                    delay: 3200,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: true,
                  },
                  navigation: {
                    nextEl: ".region-next",
                    prevEl: ".region-prev",
                  },
                  breakpoints: {
                    0: { slidesPerView: 1 },
                    820: { slidesPerView: 2 },
                  },
                });
              },

              fnResList() {
                let self = this;
                $.ajax({
                  url: "/review-list.dox",
                  dataType: "json",
                  type: "POST",
                  data: { userId: self.userId, pageSize: self.pageSize, page: (self.page - 1) * self.pageSize },
                  success: function (data) { self.list = data.list; },
                });
              },
              fnBestList() {
                let self = this;
                $.ajax({
                  url: "/bestList.dox",
                  dataType: "json",
                  type: "POST",
                  data: { userId: self.userId, pageSize: self.pageSize, page: (self.page - 1) * self.pageSize },
                  success: function (data) { self.bestList = data.list; },
                });
              },
              fnThumnail() {
                let self = this;
                $.ajax({
                  url: "/thumbnail.dox",
                  dataType: "json",
                  type: "GET",
                  success: function (data) { self.thumbnailMap = data.list; },
                });
              },

              fnDetail(resNum) { pageChange("review-view.do", { resNum }); },
              fnboardDetail(boardNo) { pageChange("board-view.do", { boardNo }); },

              toggleLike(item) {
                let self = this;
                const param = { userId: self.userId, boardNo: item.boardNo };
                $.ajax({
                  url: "review-favorite.dox",
                  dataType: "json",
                  type: "POST",
                  data: param,
                  success: function (data) {
                    item.liked = data.liked;
                    self.fnResList();
                  },
                });
              },

              getRandomImage() {
                if (!this.shuffled) this.shuffled = [...this.randomImages].sort(() => Math.random() - 0.5);
                if (this.shuffled.length === 0) this.shuffled = [...this.randomImages].sort(() => Math.random() - 0.5);
                return this.shuffled.pop();
              },

              fnStartTrip() {
                const self = this;

                if (!self.selectedRegionKey) {
                  alert("지역을 먼저 선택해 주세요.");
                  return;
                }

                const payload = {
                  regionKey: self.selectedRegionKey,
                  regionName: self.selectedRegionName,
                  headCount: self.headCount,
                  budget: self.budget,
                };
                console.log("[여행하기 payload]", payload);

                alert(
                  "여행하기 클릭!\n" +
                  "지역: " + (self.selectedRegionName || "-") + "\n" +
                  "인원: " + (self.headCount || 0) + "명\n" +
                  "예산: " + Number(self.budget || 0).toLocaleString() + "원"
                );
              },
            },

            mounted() {
              const self = this;

              const queryParams = new URLSearchParams(window.location.search);
              window.code = queryParams.get('code') || '';
              if (window.code != null) { fnKakao && fnKakao(); }

              self.init();
              self.fnResList();
              self.fnThumnail();
              self.fnBestList();

              self.$nextTick(() => {
                setTimeout(() => {
                  if (self.map) {
                    self.map.relayout();
                    if (self.marker) self.map.setCenter(self.marker.getPosition());
                  }
                }, 320);
              });

              window.addEventListener("popstate", () => {
                self.fnResList(); self.fnThumnail(); self.fnBestList();
              });
              window.addEventListener("pageshow", (event) => {
                if (event.persisted) {
                  self.fnResList(); self.fnThumnail(); self.fnBestList();
                }
              });
            },
          });
        },
      });
      app.mount("#app");





       // ================================
  // ✅ 광고 팝업 제어 (7일)
  // ================================
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

  popup.style.display = "none";
  overlay.style.display = "none";
}


  
    </script>
  </body>

  </html>