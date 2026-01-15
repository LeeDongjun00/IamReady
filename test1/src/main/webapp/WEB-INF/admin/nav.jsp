<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            .navBox{
                width: 150px;
                border: 1px solid lightgray;
                height: 800px;
                background-color: lightgray;
                margin-bottom: 30px;
                color: white;
                text-align: center;
                line-height: 40px;
            }
            .navChild{
                height: 40px;
                background-color: gray;
            }
            .navChild:hover{
                cursor: pointer;
                background-color: rgb(88, 88, 88);
                font-weight: bold;
            }
            .navChild.active{
                background-color: rgb(60, 60, 60);
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <!-- <ul>
            <li>메인 페이지</li>
            <li>공지사항</li>
            <li>자유게시판</li>
            <li>Q&A</li>
            <li>...</li>
        </ul> -->

        <!-- <nav>
            <ul>
                <li><a href="/admin-page.do">메인 페이지</a></li>
                <li><a href="/admin-noticeList.do">공지사항 관리</a></li>
                <li><a href="/admin-boardList.do">자유게시판 관리</a></li>
                <li><a href="/admin-qnaList.do">Q&A 관리</a></li>
                <li><a href="/admin-userList.do">회원 관리</a></li>
            </ul> -->
        <nav>
            <!-- <ul>
                <li><a href="#"></a>dashboard</li>
            </ul> -->
            <div class="navBox">
                <div class="navChild active" data-type="dashboard">대시보드</div>
                <div class="navChild" data-type="report">신고</div>
                <div class="navChild" data-type="inquiry">문의</div>
                <div class="navChild" data-type="userManage">회원 관리</div>
                <div class="navChild" data-type="hsdf">hsdf</div>
                <div class="navChild" data-type="t645y">t645y</div>
            </div>
        </nav>

    </body>

</html>

<script>
    let navState = {
        dashboard : false,
        report : false,
        inquiry : false,
        userManage : false,
        hsdf : false,
        t645y : false
    }

    document.querySelectorAll('.navChild').forEach(el=>{
        el.addEventListener('click', function () {
            let type = this.dataset.type;

            //모든 flag를 false로
            Object.keys(navState).forEach(key => {
                navState[key] = false;
            });

            //선택한 flag만 true로
            navState[type] = true;

            //active 클래스 처리
            document.querySelectorAll('.navChild').forEach(item=>{
                item.classList.remove('active');
            });
            this.classList.add('active');

            window.dispatchEvent(new CustomEvent('admin-nav-change', {
                detail: {
                    type: type,
                }
            }))

            // console.log(navState);
        });
    });
</script>