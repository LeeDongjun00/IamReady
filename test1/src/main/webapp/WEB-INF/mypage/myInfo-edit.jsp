<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="/css/main-style.css">
    <link rel="stylesheet" href="/css/common-style.css">
    <link rel="stylesheet" href="/css/header-style.css">
    <link rel="stylesheet" href="/css/main-images.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans KR', sans-serif;
            background: #f8fafc;
        }

        .field {
            margin: 40px auto;
            width: 100%;
            max-width: 600px;
            padding: 0 20px 100px;
        }

        .infoField {
            background: white;
            border-radius: 16px;
            margin: 20px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .infoBanner {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            padding: 20px 24px;
            color: white;
            font-weight: 700;
            font-size: 18px;
        }

        .infoBanner2 {
            padding: 20px 24px;
            color: #475569;
            font-size: 15px;
            border-bottom: 1px solid #f1f5f9;
        }

        .infoBanner2:last-child {
            border-bottom: none;
        }

        .infoBanner2 i {
            color: #0078FF;
            font-size: 16px;
            margin-right: 8px;
        }

        .infoBanner2 label {
            display: block;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 12px;
        }

        .infoBanner2 input[type="text"],
        .infoBanner2 select {
            padding: 10px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s ease;
            color: #475569;
        }

        .infoBanner2 input[type="text"]:focus,
        .infoBanner2 select:focus {
            outline: none;
            border-color: #0078FF;
            box-shadow: 0 0 0 3px rgba(0, 120, 255, 0.1);
        }

        .infoBanner2 input[type="text"]:disabled {
            background: #f8fafc;
            cursor: not-allowed;
        }

        .inputWidth {
            width: 200px;
        }

        .addr {
            width: calc(100% - 90px);
            display: inline-block;
        }

        .phone {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .phone select {
            width: 80px;
        }

        .phone input {
            width: 70px;
            text-align: center;
        }

        .checkButton {
            padding: 10px 20px;
            background: #f1f5f9;
            color: #0078FF;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-left: 8px;
        }

        .checkButton:hover {
            background: #0078FF;
            color: white;
            border-color: #0078FF;
        }

        .email-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .email-container input {
            flex: 1;
            max-width: 150px;
        }

        .email-container select {
            flex: 1;
            max-width: 180px;
        }

        .date-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .date-container select {
            padding: 10px;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-top: 8px;
        }

        .status-user {
            background: #f1f5f9;
            color: #64748b;
        }

        .status-subscriber {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
        }

        .status-admin {
            background: linear-gradient(135deg, #ddd6fe, #c4b5fd);
            color: #5b21b6;
        }

        .btnField {
            display: flex;
            gap: 12px;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btnField button {
            flex: 1;
            height: 50px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .backBtn {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .backBtn:hover {
            background: #e2e8f0;
            color: #475569;
        }

        .editBtn {
            background: linear-gradient(135deg, #0078FF 0%, #00C9FF 100%);
            color: white;
            box-shadow: 0 4px 14px rgba(0, 120, 255, 0.4);
        }

        .editBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 120, 255, 0.5);
        }

        .editBtn:active {
            transform: translateY(0);
        }

        input[type="file"] {
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            width: 100%;
            margin-top: 8px;
        }

        input[type="file"]::file-selector-button {
            padding: 8px 16px;
            background: #f1f5f9;
            color: #0078FF;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            margin-right: 12px;
            transition: all 0.2s ease;
        }

        input[type="file"]::file-selector-button:hover {
            background: #0078FF;
            color: white;
        }

        .readonly-text {
            color: #64748b;
            background: #f8fafc;
            padding: 10px 14px;
            border-radius: 8px;
            display: inline-block;
            margin-top: 8px;
        }

        @media (max-width: 640px) {
            .field {
                padding: 20px 16px 80px;
            }

            .infoBanner {
                padding: 16px 20px;
                font-size: 16px;
            }

            .infoBanner2 {
                padding: 16px 20px;
            }

            .phone {
                flex-wrap: wrap;
            }

            .email-container {
                flex-direction: column;
                align-items: stretch;
            }

            .email-container input,
            .email-container select {
                max-width: 100%;
            }

            .addr {
                width: 100%;
                margin-bottom: 8px;
            }

            .checkButton {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../components/header.jsp" %>
    <div id="app">
        <div class="field">
            <div class="infoField">
                <div class="infoBanner">
                    내 정보 수정
                </div>
                
                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-user"></i>
                        이름
                    </label>
                    <input class="inputWidth" type="text" v-model="name" placeholder="이름을 입력하세요">
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-phone"></i>
                        전화번호
                    </label>
                    <div class="phone">
                        <select v-model="phone1">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="012">012</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
                        </select>
                        <span>-</span>
                        <input type="text" v-model="phone2" @input="phone2 = phone2.replace(/[^0-9]/g, '').slice(0, 4)" placeholder="0000">
                        <span>-</span>
                        <input type="text" v-model="phone3" @input="phone3 = phone3.replace(/[^0-9]/g, '').slice(0, 4)" placeholder="0000">
                    </div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-envelope"></i>
                        이메일
                    </label>
                    <div class="email-container">
                        <input type="text" v-model="emailFront" @input="emailFront = emailFront.replace(/[^a-z0-9]/g, '')" placeholder="이메일">
                        <span>@</span>
                        <select v-model="emailBack">
                            <option value="abc">선택해주세요</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="yahoo.com">yahoo.com</option>
                        </select>
                    </div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-pen-clip"></i>
                        아이디
                    </label>
                    <div class="readonly-text">{{info.userId}}</div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-regular fa-face-smile"></i>
                        닉네임
                    </label>
                    <input class="inputWidth" type="text" v-model="nickname" placeholder="닉네임을 입력하세요">
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-star"></i>
                        사용자 등급
                    </label>
                    <div>
                        <span v-if="info.status === 'U'" class="status-badge status-user">
                            <i class="fa-solid fa-circle-user"></i>
                            일반 사용자
                        </span>
                        <span v-else-if="info.status === 'S'" class="status-badge status-subscriber">
                            <i class="fa-solid fa-star"></i>
                            구독자
                        </span>
                        <span v-else-if="info.status === 'A'" class="status-badge status-admin">
                            <i class="fa-solid fa-user-secret"></i>
                            관리자
                        </span>
                    </div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-gift"></i>
                        생년월일
                    </label>
                    <div class="date-container">
                        <select v-model="year">
                            <option
                                v-for="y in Array.from({ length: new Date().getFullYear() - 1900 + 1 }, (_, i) => 1900 + i)"
                                :key="y"
                                :value="y"
                            >
                                {{ y }}
                            </option>
                        </select>
                        <span>년</span>
                        <select v-model="month">
                            <option :value="String(num).padStart(2, '0')" v-for="num in 12">{{ String(num).padStart(2, '0') }}</option>
                        </select>
                        <span>월</span>
                        <select v-model="day">
                            <option v-if="month%2 == 1" :value="String(num).padStart(2, '0')" v-for="num in 31">{{ String(num).padStart(2, '0') }}</option>
                            <option v-else-if="month==2" :value="String(num).padStart(2, '0')" v-for="num in 29">{{ String(num).padStart(2, '0') }}</option>
                            <option v-else :value="String(num).padStart(2, '0')" v-for="num in 30">{{ String(num).padStart(2, '0') }}</option>
                        </select>
                        <span>일</span>
                    </div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-house"></i>
                        주소
                    </label>
                    <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                        <input type="text" v-model="addr" class="addr" disabled>
                        <button class="checkButton" @click="fnAddr">검색</button>
                    </div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-file-image"></i>
                        프로필 사진 변경
                    </label>
                    <input type="file" id="file1" name="file1" accept=".jpg, .png">
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-solid fa-calendar"></i>
                        가입일
                    </label>
                    <div class="readonly-text">{{info.cdate}}</div>
                </div>

                <div class="infoBanner2">
                    <label>
                        <i class="fa-regular fa-calendar"></i>
                        지난 정보 수정일
                    </label>
                    <div class="readonly-text">{{info.udate}}</div>
                </div>
            </div>

            <div class="btnField">
                <button class="backBtn" @click="fnBack">취소</button>
                <button class="editBtn" @click="fnEdit">수정 완료</button>
            </div>
        </div>
    </div>
    <%@ include file="../components/footer.jsp" %>
</body>
</html>

<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
        window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
    }

    const app = Vue.createApp({
        data() {
            return {
                sessionId : window.sessionData.id,
                info : {},
                name : "",
                emailFront : "",
                emailBack : "abc",
                addr : "",
                phone1 : "",
                phone2 : "",
                phone3 : "",
                nickname : "",
                year : "",
                month : "",
                day : ""
            };
        },
        methods: {
            fnMyInfo: function () {
                let self = this;
                let param = {
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/mypage/myInfo.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.info = data.info;
                        self.name = data.info.name;
                        self.nickname = data.info.nickname;
                        self.addr = data.info.addr;
                        self.emailFront = data.dataEmail.username;
                        self.emailBack = data.dataEmail.domain;
                        self.year = data.dataBirth.year;
                        self.month = data.dataBirth.month;
                        self.day = data.dataBirth.day;
                        self.phone1 = data.dataPhone.phoneFirst;
                        self.phone2 = data.dataPhone.phoneSecond;
                        self.phone3 = data.dataPhone.phoneLast;
                    }
                });
            },

            fnAddr : function () {
                window.open("/member/addr.do", "addr", "width=500, height=500");
            },

            fnResult : function (roadFullAddr, addrDetail, zipNo) {
                let self = this;
                self.addr = roadFullAddr;
            },

            fnEdit: function() {
                let self = this;

                if(self.name == ""){
                    alert("이름을 입력해주세요.");
                    return;
                }
                if(self.phone2.length !=4 || self.phone3.length != 4){
                    alert("전화번호를 입력해주세요.");
                    return;
                }
                if(self.emailFront == ""){
                    alert("이메일을 입력해주세요.");
                    return;
                }
                if(self.emailBack=="abc"){
                    alert("이메일을 입력해주세요.");
                    return;
                }
                if(self.addr == ""){
                    alert("주소를 입력해주세요.");
                    return;
                }
                if(self.nickname==""){
                    self.nickname=self.name;
                }

                let param = {
                    userId : self.sessionId,
                    name : self.name,
                    email : self.emailFront + '@' + self.emailBack,
                    addr : self.addr,
                    phone : self.phone1 + '-' + self.phone2 + '-' + self.phone3,
                    nickname : self.nickname,
                    birth : self.year + self.month + self.day
                }

                $.ajax({
                    url: "/mypage/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            self.fnProfilePath();
                            alert(data.msg);
                            location.href="/myInfo.do";            
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            },

            fnProfileUpload(form){
                var self = this;
                $.ajax({
                    url : "/member/profileUpload.dox", 
                    type : "POST", 
                    processData : false, 
                    contentType : false, 
                    data : form, 
                    success:function(data) { 
                    }	           
                });
            },

            fnProfilePath : function () {
                let self = this;
                let param = {
                    userId : self.sessionId
                };
                $.ajax({
                    url:"/member/profilePath.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data){
                        if(data.info.storUrl == null){
                            let form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] );
                            form.append( "userId",  self.sessionId);
                            self.fnProfileUpload(form);
                        } else {
                            let form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] );
                            form.append( "userId",  self.sessionId);
                            form.append( "mediaId",  data.info.mediaId);
                            self.fnProfileUpdate(form);
                        }
                    }
                })
            },
            
            fnProfileUpdate(form){
                var self = this;
                $.ajax({
                    url : "/member/profileUpdate.dox", 
                    type : "POST", 
                    processData : false, 
                    contentType : false, 
                    data : form, 
                    success:function(data) { 
                    }	           
                });
            },

            fnBack: function () {
                location.href="/myInfo.do";
            }
        },
        mounted() {
            let self = this;
            self.fnMyInfo();
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>