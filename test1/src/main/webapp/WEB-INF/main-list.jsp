<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Team Project</title>

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

        --shadow: 0 10px 30px rgba(0, 0, 0, 0.08);

        --main-panels-height: 520px;
        --left-panel-width: 360px;

        --top-banner-height: 220px;
        --top-banner-height-mobile: 140px;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        background: var(--bg);
        font-family:
          "Noto Sans KR",
          system-ui,
          -apple-system,
          Segoe UI,
          Roboto,
          Helvetica,
          Arial,
          sans-serif;
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
        transition:
          transform 0.25s ease,
          filter 0.25s ease;
        filter: saturate(0.95) contrast(1.02);
      }

      .top-banner-wrap:hover .swiper-slide img {
        transform: scale(1.02);
        filter: saturate(1.05) contrast(1.08);
      }

      .top-banner-prev,
      .top-banner-next {
        opacity: 0;
        pointer-events: none;
        transition:
          opacity 0.18s ease,
          transform 0.18s ease;
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
        text-shadow: 0 6px 16px rgba(0, 0, 0, 0.35);
      }

      .top-banner-pagination {
        position: absolute;
        left: 0;
        right: 0;
        bottom: 10px;
        z-index: 5;
      }

      .top-banner-pagination .swiper-pagination-bullet {
        opacity: 0.45;
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
         좌측: 지역 탭 + 대표 이미지(랜덤 관광지)
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
        background: linear-gradient(180deg, rgba(14, 165, 233, 0.15) 0%, rgba(2, 132, 199, 0.1) 100%);
        border: 1px solid rgba(2, 132, 199, 0.18);
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
        font-size: 0.82rem;
        color: var(--muted);
        line-height: 1.35;
      }

      .region-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 8px;
      }

      .region-btn {
        appearance: none;
        border: 1px solid rgba(0, 0, 0, 0.08);
        background: #fff;
        color: #111827;
        height: 38px;
        border-radius: 12px;
        font-weight: 900;
        font-size: 0.88rem;
        cursor: pointer;
        transition:
          transform 0.12s ease,
          box-shadow 0.12s ease,
          border-color 0.12s ease,
          background 0.12s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        user-select: none;
      }

      .region-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 10px 22px rgba(2, 132, 199, 0.1);
        border-color: rgba(2, 132, 199, 0.25);
      }

      .region-btn.is-active {
        background: linear-gradient(180deg, var(--sky-500) 0%, var(--sky-600) 100%);
        color: #fff;
        border-color: transparent;
        box-shadow: 0 12px 26px rgba(2, 132, 199, 0.22);
      }

      .region-btn .mini-ico {
        font-size: 14px;
        opacity: 0.9;
      }

      .left-actions {
        display: flex;
        gap: 8px;
      }

      .btn-soft {
        flex: 1;
        height: 40px;
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, 0.08);
        background: #fff;
        font-weight: 900;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition:
          transform 0.12s ease,
          box-shadow 0.12s ease,
          border-color 0.12s ease;
      }

      .btn-soft:hover {
        transform: translateY(-1px);
        box-shadow: 0 10px 22px rgba(99, 102, 241, 0.1);
        border-color: rgba(99, 102, 241, 0.25);
      }

      .btn-soft:disabled {
        opacity: 0.55;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
      }

      .btn-primary {
        background: linear-gradient(180deg, var(--indigo-500) 0%, #4f46e5 100%);
        border-color: transparent;
        color: #fff;
        box-shadow: 0 12px 26px rgba(79, 70, 229, 0.22);
      }

      .btn-primary:hover {
        box-shadow: 0 14px 28px rgba(79, 70, 229, 0.26);
      }

      .spot-card {
        flex: 1;
        min-height: 0;
        border-radius: 14px;
        overflow: hidden;
        border: 1px solid rgba(0, 0, 0, 0.08);
        background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%);
        position: relative;
      }

      /* ✅ 랜덤 관광지 이미지가 있으면 꽉 채우기 */
      .spot-card .spot-img {
        position: absolute;
        inset: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        display: block;
        filter: saturate(1.02) contrast(1.02);
        transform: scale(1.01);
      }

      .spot-card .img-placeholder {
        width: 100%;
        height: 100%;
        background:
          radial-gradient(900px 200px at 20% 20%, rgba(14, 165, 233, 0.18), transparent 60%),
          radial-gradient(700px 220px at 70% 35%, rgba(99, 102, 241, 0.16), transparent 60%),
          linear-gradient(180deg, rgba(255, 255, 255, 0.6), rgba(255, 255, 255, 0.2));
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        padding: 14px;
      }

      .spot-card .spot-meta {
        position: absolute;
        left: 14px;
        right: 14px;
        bottom: 14px;
        background: rgba(255, 255, 255, 0.7);
        border: 1px solid rgba(0, 0, 0, 0.06);
        border-radius: 12px;
        padding: 10px 12px;
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        box-shadow: 0 10px 26px rgba(0, 0, 0, 0.08);
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
        font-size: 0.82rem;
        line-height: 1.35;
      }

      /* ================================
         ✅ 우측: 카카오 지도 (여백/붕뜸 제거 최종)
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
        display: block !important;
        align-items: stretch !important;
        justify-content: stretch !important;

        background: linear-gradient(180deg, #eaf4ff 0%, #f6f9ff 100%);
        overflow: hidden;
        border-radius: 16px;
      }

      #map {
        position: absolute !important;
        inset: 0 !important;
        width: 100% !important;
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
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
        background: rgba(255, 255, 255, 0.82);
        border: 1px solid rgba(0, 0, 0, 0.06);
        box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        font-weight: 1000;
        font-size: 0.9rem;
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
        border: 1px solid rgba(0, 0, 0, 0.06);
        background: rgba(255, 255, 255, 0.82);
        cursor: pointer;
        font-weight: 1000;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        transition:
          transform 0.12s ease,
          box-shadow 0.12s ease;
      }

      .map-top-overlay .ghost-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 12px 26px rgba(0, 0, 0, 0.1);
      }

      .map-top-overlay .ghost-btn:disabled {
        opacity: 0.55;
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

        background: rgba(255, 255, 255, 0.72);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);

        border: 1px solid rgba(255, 255, 255, 0.55);
        box-shadow:
          0 18px 40px rgba(0, 0, 0, 0.12),
          inset 0 1px 0 rgba(255, 255, 255, 0.65);
      }

      .map-bottom-field {
        flex: 1;
        min-width: 0;
        height: 46px;

        display: flex;
        align-items: center;
        gap: 10px;

        padding: 0 14px;
        border-radius: 14px;

        background: rgba(255, 255, 255, 0.85);
        border: 1px solid rgba(0, 0, 0, 0.06);
        box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.9);

        transition:
          box-shadow 0.15s ease,
          border-color 0.15s ease,
          transform 0.15s ease;
      }

      .map-bottom-field:focus-within {
        border-color: rgba(14, 165, 233, 0.35);
        box-shadow:
          0 10px 22px rgba(2, 132, 199, 0.12),
          0 0 0 4px rgba(2, 132, 199, 0.14),
          inset 0 1px 0 rgba(255, 255, 255, 0.9);
        transform: translateY(-1px);
      }

      .map-bottom-field .label {
        font-size: 12px;
        font-weight: 1000;
        color: #0f172a;
        white-space: nowrap;
        letter-spacing: -0.2px;

        display: flex;
        align-items: center;
        gap: 6px;
      }

      .map-bottom-field .label::before {
        content: "";
        width: 18px;
        height: 18px;
        border-radius: 8px;
        background: linear-gradient(180deg, rgba(14, 165, 233, 0.2), rgba(99, 102, 241, 0.16));
        border: 1px solid rgba(2, 132, 199, 0.16);
        box-shadow: 0 10px 18px rgba(2, 132, 199, 0.1);
      }

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
        color: rgba(100, 116, 139, 0.75);
        font-weight: 700;
      }

      .btn-start-trip {
        flex: 0 0 auto;
        height: 46px;
        padding: 0 18px;
        border: none;
        border-radius: 14px;

        font-weight: 1000;
        letter-spacing: -0.2px;
        color: #fff;
        cursor: pointer;

        background: linear-gradient(135deg, var(--sky-500) 0%, var(--sky-600) 60%, #2563eb 100%);
        box-shadow:
          0 16px 30px rgba(2, 132, 199, 0.25),
          inset 0 1px 0 rgba(255, 255, 255, 0.35);

        transition:
          transform 0.12s ease,
          box-shadow 0.12s ease,
          filter 0.12s ease;
      }

      .btn-start-trip:hover {
        transform: translateY(-1px);
        filter: saturate(1.05) contrast(1.02);
        box-shadow:
          0 18px 36px rgba(2, 132, 199, 0.3),
          inset 0 1px 0 rgba(255, 255, 255, 0.35);
      }

      .btn-start-trip:active {
        transform: translateY(0);
        box-shadow:
          0 12px 24px rgba(2, 132, 199, 0.22),
          inset 0 2px 8px rgba(0, 0, 0, 0.18);
      }

      /* ================================
         아래 패널
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

      .premium-ad-card {
        position: relative;
        height: 190px;
        background: transparent;
        border: 4.5px solid #22c55e;
        border-radius: 0;
        box-shadow: none;
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
        object-position: center;
      }

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
        border: 1px solid rgba(0, 0, 0, 0.06);
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
        background: linear-gradient(180deg, rgba(99, 102, 241, 0.14) 0%, rgba(14, 165, 233, 0.1) 100%);
        border: 1px solid rgba(79, 70, 229, 0.16);
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
        border: 1px solid rgba(0, 0, 0, 0.08);
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 10px 18px rgba(0, 0, 0, 0.06);
        transition:
          transform 0.12s ease,
          box-shadow 0.12s ease,
          opacity 0.12s ease;
      }

      .region-nav-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 12px 22px rgba(0, 0, 0, 0.08);
      }

      .region-nav-btn:active {
        transform: translateY(0);
        box-shadow: 0 10px 18px rgba(0, 0, 0, 0.06);
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
        transition:
          transform 0.25s ease,
          filter 0.25s ease;
        filter: saturate(0.98) contrast(1.02);
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
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
        transition: opacity 0.2s ease;
      }

      .swiper-button-next:hover,
      .swiper-button-prev:hover {
        opacity: 0.8;
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
        transition: transform 0.8s;
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
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
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
        font-size: 0.8em;
        font-weight: 500;
        margin: 0 6px 6px 0;
      }

      .material-symbols-outlined {
        font-variation-settings:
          "FILL" 0,
          "wght" 400,
          "GRAD" 0,
          "opsz" 48;
        color: #777;
        font-size: 24px;
        cursor: pointer;
        transition: all 0.2s ease;
      }

      .material-symbols-outlined.liked {
        font-variation-settings: "FILL" 1;
        color: #e53935;
      }

      .card-cnt {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 0.85em;
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
        font-size: 0.95em;
        color: #555;
        line-height: 1.5;
        flex: 1;
        margin-bottom: 10px;
      }

      .card-info {
        font-size: 0.9em;
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
        transition: background 0.2s;
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
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        cursor: pointer;
        transition:
          transform 0.3s ease,
          box-shadow 0.3s ease;
        display: flex;
        flex-direction: column;
        height: auto;
        perspective: none;
      }

      .bestCard-container .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
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
        font-size: 0.95em;
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
        font-size: 0.9em;
        color: #777;
        margin-bottom: 10px;
      }

      .bestCard-container .card-cnt {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 5px;
        font-size: 0.85em;
        color: #666;
      }

      .bestCard-container .material-symbols-outlined {
        font-variation-settings:
          "FILL" 0,
          "wght" 400,
          "GRAD" 0,
          "opsz" 48;
        color: #777;
        font-size: 20px;
        cursor: pointer;
        transition: all 0.2s ease;
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






      /* 구독창 css */
      /* ✅ 배경 오버레이 */
      .popup-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.6);
        z-index: 999;
        /* 팝업(1000)보다 1 낮게 */
        display: none;
      }

      /* ✅ 팝업이 오버레이 위로 오게 */
      .sub-popup {
        z-index: 1000;
      }

      /* ================================
   ✅ 구독 혜택 팝업 스타일
================================ */
      .sub-popup {
        position: fixed;
        top: 250px;
        left: 50px;
        width: 520px;
        max-width: calc(100vw - 24px);
        background: #fff;
        border: 1px solid rgba(0, 0, 0, .10);
        border-radius: 14px;
        padding: 22px 22px 16px;
        z-index: 1000;
        box-shadow: 0 18px 45px rgba(0, 0, 0, .18);
      }

      .sub-popup__x {
        position: absolute;
        top: 15px;
        right: 12px;
        width: 34px;
        height: 34px;
        border: none;
        background: transparent;
        font-size: 26px;
        line-height: 34px;
        cursor: pointer;
        color: #111;
        opacity: .65;
      }

      .sub-popup__x:hover {
        opacity: 1;
      }

      .sub-popup__title {
        margin: 0 0 30px 10px;
        font-size: 44px;
        line-height: 1.05;
        letter-spacing: -0.5px;
      }

      .sub-popup__desc {
        text-align: center;
        font-size: 16px;
        color: #222;
        line-height: 1.5;
        margin-bottom: 16px;
      }

      .sub-popup__grid {
        display: flex;
        flex-direction: column;
        gap: 16px;
      }

      .sub-popup__row {
        display: grid;
        grid-template-columns: 1fr 30px 1fr;
        align-items: center;
        gap: 10px;
      }

      .sub-popup__card {
        margin: 0;
        background: #fff;
        border: 1px solid rgba(0, 0, 0, .08);
        border-radius: 8px;
        overflow: hidden;
        min-height: 120px;
        display: flex;
        flex-direction: column;
      }

      .sub-popup__card img {
        width: 100%;
        height: 150px;
        object-fit: cover;
        background: #f3f4f6;
        display: block;
      }

      .sub-popup__arrow {
        text-align: center;
        font-size: 26px;
        font-weight: 700;
        color: #111;
        opacity: .7;
      }

      .sub-popup__cap {
        padding: 10px 10px 12px;
        text-align: center;
        font-size: 16px;
        font-weight: 700;
        color: #111;
      }

      .sub-popup__hr {
        border: none;
        border-top: 1px solid rgba(0, 0, 0, .10);
        margin: 14px 0 12px;
      }

      .sub-popup__footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
      }

      .sub-popup__check {
        font-size: 14px;
        color: #111;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .sub-popup__btn {
        border: none;
        background: #0ea5e9;
        color: #fff;
        font-weight: 700;
        border-radius: 8px;
        padding: 8px 14px;
        cursor: pointer;

      }

      .sub-popup__btn:hover {
        opacity: .92;
      }

      @media (max-width: 560px) {
        .sub-popup {
          left: 12px;
          right: 12px;
          width: auto;
          top: 12px;
        }

        .sub-popup__title {
          font-size: 34px;
        }

        .sub-popup__row {
          grid-template-columns: 1fr 26px 1fr;
        }

        .sub-popup__card img {
          height: 120px;
        }
      }
    </style>
  </head>

  <body>
    <%@ include file="components/header.jsp" %>

      <div id="app">
        <div class="content-wrapper">
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

          <div class="main-panels">
            <aside class="left-card">
              <div class="region-top">
                <div class="region-title">
                  <div class="left">
                    <div class="badge"><i class="fa-solid fa-location-dot"></i></div>
                    <div>
                      <h3>어디로 가볼까요</h3>
                      <p>지역을 선택하면 우측 지도가 랜덤 장소로 이동하고, 좌측에 랜덤 관광지 사진이 뜹니다</p>
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
                <img v-if="spotImageUrl" class="spot-img" :src="spotImageUrl" :alt="spotTitle" />
                <div v-else class="img-placeholder"></div>

                <div class="spot-meta">
                  <p class="name">{{ spotTitle }}</p>
                  <p class="desc">
                    {{ spotDesc }}
                  </p>
                </div>
              </div>
            </aside>

            <section class="right-card">
              <div class="map_wrap">
                <div id="map"></div>

                <div class="map-top-overlay">
                  <div class="chip">
                    <span class="dot"></span>
                    <span>{{ selectedRegionName || "지역을 선택해 주세요" }}</span>
                  </div>
                  <button class="ghost-btn" type="button" @click="fnRandomMove" :disabled="!selectedRegionKey">
                    <i class="fa-solid fa-location-crosshairs"></i> 랜덤 이동
                  </button>
                </div>

                <div class="map-bottom-bar">
                  <div class="map-bottom-field">
                    <span class="label">인원수</span>
                    <input type="number" min="0" v-model.number="headCount" placeholder="예: 2" />
                  </div>
                  <div class="map-bottom-field">
                    <span class="label">예산</span>
                    <input type="number" min="0" v-model.number="budget" placeholder="예: 300000" />
                  </div>
                  <button type="button" class="btn-start-trip" @click="fnStartTrip">여행하기</button>
                </div>
              </div>
            </section>
          </div>
          <div class="below-panels">
            <div class="premium-ad-card">
              <img src="/images/premium_ad.png" alt="premium_ad" />
            </div>

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
                  <div class="swiper-slide">
                    <img src="/images/region_4.png" alt="region_1" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_5.png" alt="region_2" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_6.png" alt="region_3" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_7.png" alt="region_1" />
                  </div>
                  <div class="swiper-slide">
                    <img src="/images/region_8.png" alt="region_2" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="swiper review-slider" style="margin-top: 40px">
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
                        <div style="display: flex">
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

          <div style="margin-top: 24px">
            <h2>추천 게시글</h2>
            <div class="bestCard-container">
              <div class="card" v-for="item in bestList" :key="item.resNum" @click="fnboardDetail(item.boardNo)">
                <div class="card-body">
                  <div class="card-title">{{ item.title }}</div>
                  <div class="card-cnt">
                    <div class="card-info">👤 {{ item.userId }}</div>
                    <div style="display: flex">
                      <div style="display: flex; margin-right: 20px">
                        <span class="material-symbols-outlined">thumb_up</span>
                        <div>{{ item.fav }}</div>
                      </div>
                      <div style="display: flex">
                        <span class="material-symbols-outlined">visibility</span>
                        <div>{{ item.cnt }}</div>
                      </div>
                      <div style="display: flex; margin-left: 20px">
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
      <div id="popup-overlay" class="popup-overlay" style="display:none;"></div>

      <div id="ad-popup" class="sub-popup" style="display:none;">
        <button class="sub-popup__x" type="button" onclick="closePopup()" aria-label="닫기">×</button>

        <h2 class="sub-popup__title">구독 혜택</h2>

        <p class="sub-popup__desc">
          ✨ 여행하기 예산배분 잠금 활성화<br />
          ✨ 일 1회 경로 생성 → 무제한 이용 가능
        </p>

        <div class="sub-popup__grid">
          <div class="sub-popup__row">
            <figure class="sub-popup__card">
              <img src="/img/ad/ad1.PNG" alt="예산배분 잠금 상태" />
            </figure>
            <div class="sub-popup__arrow">→</div>
            <figure class="sub-popup__card">
              <img src="/img/ad/ad2.PNG" alt="예산배분 무제한 상태" />
            </figure>
          </div>

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

        <div class="sub-popup__footer">
          <label class="sub-popup__check">
            <input type="checkbox" id="today-check" /> 7일 동안 보지 않기
          </label>
          <button class="sub-popup__btn" type="button" onclick="closePopup()">닫기</button>
        </div>
      </div>

      <%@ include file="components/footer.jsp" %>

        <script>
          const app = Vue.createApp({
            data() {
              return {
                map: null,
                marker: null,

                userId: "${sessionId}",
                list: [],
                bestList: [],
                thumbnailMap: {},
                page: 1,
                pageSize: 6,
                
                // ✅ 제공해주신 이미지 리스트로 확장
                randomImages: [
                    "/img/defaultImg01.jpg", "/img/defaultImg02.jpg", "/img/defaultImg03.jpg", "/img/defaultImg04.jpg", "/img/defaultImg05.jpg", "/img/defaultImg06.jpg",
                    "/img/defaultmg07.jpg", "/img/defaultmg08.jpg", "/img/defaultmg09.jpg", "/img/defaultmg10.jpg", "/img/defaultmg11.jpg", "/img/defaultmg12.jpg",
                    "/img/defaultmg13.jpg", "/img/defaultmg14.jpg", "/img/defaultmg15.jpg", "/img/defaultmg16.jpg", "/img/defaultimg17.jpg", "/img/defaultimg18.jpg",
                    "/img/defaultimg19.jpg", "/img/defaultimg20.jpg", "/img/defaultimg21.jpg", "/img/defaultimg22.jpg", "/img/defaultimg23.jpg", "/img/defaultimg24.jpg",
                    "/img/defaultimg25.jpg", "/img/defaultimg26.jpg", "/img/defaultimg27.jpg", "/img/defaultimg28.jpg", "/img/defaultimg29.jpg", "/img/defaultimg30.jpg",
                    "/img/defaultimg31.jpg", "/img/defaultimg32.jpg", "/img/defaultimg33.jpg", "/img/defaultimg34.jpg", "/img/defaultimg35.jpg", "/img/defaultimg36.jpg",
                    "/img/defaultimg37.jpg", "/img/defaultimg38.jpg", "/img/defaultimg39.jpg", "/img/defaultimg40.jpg", "/img/defaultimg41.jpg", "/img/defaultimg42.jpg",
                    "/img/defaultimg43.jpg", "/img/defaultimg44.jpg", "/img/defaultimg45.jpg", "/img/defaultimg46.jpg", "/img/defaultimg47.jpg", "/img/defaultimg48.jpg",
                    "/img/defaultimg49.jpg",
                    "/img/defaultImg50.PNG", "/img/defaultImg51.PNG", "/img/defaultImg52.PNG", "/img/defaultImg53.PNG", "/img/defaultImg54.PNG", "/img/defaultImg55.PNG",
                    "/img/defaultImg56.PNG", "/img/defaultImg57.PNG", "/img/defaultImg58.PNG", "/img/defaultImg59.PNG", "/img/defaultImg60.PNG", "/img/defaultImg61.PNG",
                    "/img/defaultImg62.PNG", "/img/defaultImg63.PNG", "/img/defaultImg64.PNG", "/img/defaultImg65.PNG", "/img/defaultImg66.PNG", "/img/defaultImg67.PNG",
                    "/img/defaultImg68.PNG", "/img/defaultImg69.PNG", "/img/defaultImg70.PNG", "/img/defaultImg71.PNG", "/img/defaultImg72.PNG", "/img/defaultImg73.PNG",
                    "/img/defaultImg74.PNG", "/img/defaultImg75.PNG"
                ],

                headCount: 0,
                budget: 0,

                topBannerSwiper: null,
                reviewSwiper: null,
                regionSwiper: null,

                selectedRegionKey: "",
                selectedRegionName: "",

                spotTitle: "지역을 선택해 주세요",
                spotDesc: "※ 지역을 선택하면 관광지 사진이 랜덤으로 표시됩니다",
                spotImageUrl: "", // 초기엔 비워둠 (placeholder 표시)

                REGION: {
                  seoul: { name: "서울특별시", lat: 37.5665, lng: 126.978, jitter: 0.05, spot: "서울 랜덤 관광지" },
                  gyeonggi: { name: "경기도", lat: 37.4138, lng: 127.5183, jitter: 0.12, spot: "경기 랜덤 관광지" },
                  incheon: { name: "인천광역시", lat: 37.4563, lng: 126.7052, jitter: 0.08, spot: "인천 랜덤 관광지" },
                  gangwon: { name: "강원특별자치도", lat: 37.8228, lng: 128.1555, jitter: 0.16, spot: "강원 랜덤 관광지" },
                  chungnam: { name: "충청남도", lat: 36.6588, lng: 126.6728, jitter: 0.14, spot: "충남 랜덤 관광지" },
                  jeonbuk: { name: "전북특별자치도", lat: 35.7175, lng: 127.153, jitter: 0.14, spot: "전북 랜덤 관광지" },
                  daegu: { name: "대구광역시", lat: 35.8714, lng: 128.6014, jitter: 0.07, spot: "대구 랜덤 관광지" },
                  busan: { name: "부산광역시", lat: 35.1796, lng: 129.0756, jitter: 0.08, spot: "부산 랜덤 관광지" },
                  jeju: { name: "제주특별자치도", lat: 33.4996, lng: 126.5312, jitter: 0.12, spot: "제주 랜덤 관광지" },
                },

                AREA_CODE: {
                  seoul: 1, incheon: 2, daegu: 4, busan: 6, gyeonggi: 31,
                  gangwon: 32, chungnam: 34, jeonbuk: 37, jeju: 39,
                },
              };
            },
            methods: {
              init() {
                const self = this;

                kakao.maps.load(() => {
                  self.initMap();
                });

                self.$nextTick(() => {
                  self.initTopBannerSwiper();
                  self.initSwiper();
                  self.initRegionSwiper();
                });
              },

              /* ✅ 지도 생성 + relayout 강제 */
              initMap() {
                const self = this;
                const mapContainer = document.getElementById("map");

                const center = new kakao.maps.LatLng(37.566826, 126.9786567);
                self.map = new kakao.maps.Map(mapContainer, { center, level: 7 });
                self.marker = new kakao.maps.Marker({ position: center, map: self.map });

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

                window.addEventListener("resize", () => {
                  if (!self.map) return;
                  self.map.relayout();
                  if (self.marker) self.map.setCenter(self.marker.getPosition());
                });

                if (document.fonts && document.fonts.ready) {
                  document.fonts.ready.then(() => {
                    if (!self.map) return;
                    self.map.relayout();
                    if (self.marker) self.map.setCenter(self.marker.getPosition());
                  });
                }
              },

              /* ✅ (핵심) 지역 선택 시: 지도 랜덤이동 + 랜덤 관광지 이미지 갱신 */
              fnSelectRegion(key) {
                const self = this;
                const info = self.REGION[key];
                if (!info) return;

                self.selectedRegionKey = key;
                self.selectedRegionName = info.name;

                // 기본 텍스트 먼저 세팅
                self.spotTitle = info.spot;
                self.spotDesc = "관광지 정보를 불러오는 중입니다...";
                self.spotImageUrl = "";

                // 지도 이동 + 랜덤 관광지 호출
                self.fnRandomMove();
                self.fnFetchRandomSpot();
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
                const level =
                  self.selectedRegionKey === "seoul" ||
                    self.selectedRegionKey === "busan" ||
                    self.selectedRegionKey === "daegu" ||
                    self.selectedRegionKey === "incheon"
                    ? 7
                    : 9;

                self.map.setLevel(level);
                self.map.panTo(target);

                if (self.marker) self.marker.setPosition(target);

                requestAnimationFrame(() => {
                  if (!self.map) return;
                  self.map.relayout();
                  if (self.marker) self.map.setCenter(self.marker.getPosition());
                });

                // ✅ "다른 장소 추천" 눌렀을 때도 사진도 같이 바뀌게(원하시면 유지로 바꿔드릴게요)
                self.fnFetchRandomSpot();
              },

              /* ✅ (핵심) 백엔드로 지역코드 전달 → TourAPI에서 랜덤 관광지 1개 뽑아서 이미지/제목 반환 */
              fnFetchRandomSpot() {
                const self = this;
                if (!self.selectedRegionKey) return;

                const areaCode = self.AREA_CODE[self.selectedRegionKey] || "";

                if (!areaCode) {
                  self.spotTitle = self.REGION[self.selectedRegionKey]?.spot || "랜덤 관광지";
                  self.spotDesc = "※ areaCode 매핑이 없어 기본 이미지로 표시됩니다";
                  self.spotImageUrl = self.getRandomImage(); // ✅ 여기서 사용됨
                  return;
                }

                $.ajax({
                  url: "/tour-random-spot.dox",
                  dataType: "json",
                  type: "GET",
                  data: { areaCode: areaCode },
                  success: function (data) {
                    const spot = data && (data.spot || data.item || data.data || data);
                    const title = spot?.title || self.REGION[self.selectedRegionKey]?.spot || "랜덤 관광지";
                    const img = spot?.firstimage || spot?.firstImage || spot?.imageUrl || "";
                    const addr = spot?.addr1 || spot?.address || "";

                    self.spotTitle = title;
                    self.spotDesc = addr ? addr : "※ 해당 관광지의 주소 정보가 없습니다";
                    // ✅ 이미지가 없으면 랜덤 이미지 사용
                    self.spotImageUrl = img ? img : self.getRandomImage(); 
                  },
                  error: function () {
                    self.spotTitle = self.REGION[self.selectedRegionKey]?.spot || "랜덤 관광지";
                    self.spotDesc = "※ 관광지 이미지를 출력합니다.";
                    self.spotImageUrl = self.getRandomImage(); // ✅ 에러 시에도 사용됨
                  },
                });
              },

              /* ✅ 랜덤 이미지 추출 (셔플링 방식) */
              getRandomImage() {
                if (!this.shuffled || this.shuffled.length === 0) {
                    // 배열 복사 후 랜덤 섞기 (Fisher-Yates Shuffle 유사)
                    this.shuffled = [...this.randomImages].sort(() => Math.random() - 0.5);
                }
                return this.shuffled.pop(); // 하나씩 꺼내서 줌 (중복 방지)
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
                  success: function (data) {
                    self.list = data.list;
                  },
                });
              },
              fnBestList() {
                let self = this;
                $.ajax({
                  url: "/bestList.dox",
                  dataType: "json",
                  type: "POST",
                  data: { userId: self.userId, pageSize: self.pageSize, page: (self.page - 1) * self.pageSize },
                  success: function (data) {
                    self.bestList = data.list;
                  },
                });
              },
              fnThumnail() {
                let self = this;
                $.ajax({
                  url: "/thumbnail.dox",
                  dataType: "json",
                  type: "GET",
                  success: function (data) {
                    self.thumbnailMap = data.list;
                  },
                });
              },

              fnDetail(resNum) {
                pageChange("review-view.do", { resNum });
              },
              fnboardDetail(boardNo) {
                pageChange("board-view.do", { boardNo });
              },

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

              /* ✅ (핵심) alert 대신 reservation.do로 값 넘기기 */
              fnStartTrip() {
                const self = this;

                if (!self.selectedRegionKey) {
                  alert("지역을 먼저 선택해 주세요.");
                  return;
                }

                // 숫자 보정(빈 값이면 0)
                const headCount = Number.isFinite(self.headCount) ? self.headCount : 0;
                const budget = Number.isFinite(self.budget) ? self.budget : 0;

                const payload = {
                  regionKey: self.selectedRegionKey,
                  regionName: self.selectedRegionName,
                  areaCode: self.AREA_CODE[self.selectedRegionKey] || "",
                  headCount: headCount,
                  budget: budget,
                };

                console.log("[reservation.do payload]", payload);

                // ✅ reservation.do로 이동 (page-change.js 사용)
                pageChange("reservation.do", payload);
              },
            },

            mounted() {
              const self = this;

              const queryParams = new URLSearchParams(window.location.search);
              window.code = queryParams.get("code") || "";
              if (window.code != null) {
                fnKakao && fnKakao();
              }

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
                self.fnResList();
                self.fnThumnail();
                self.fnBestList();
              });
              window.addEventListener("pageshow", (event) => {
                if (event.persisted) {
                  self.fnResList();
                  self.fnThumnail();
                  self.fnBestList();
                }
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