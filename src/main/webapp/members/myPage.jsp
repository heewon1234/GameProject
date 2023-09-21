<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>My Page</title>
        <!-- JQuery CDN -->
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <!-- Kakao Post API -->
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
        <!-- input[type=number] 스크롤 제거 -->
        <style type="text/css">
            input[type=number]::-webkit-inner-spin-button,
            input[type=number]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>

        <style>
            body {
                padding-top: 60px;
            }

            a {
                text-decoration-line: none;
                color: black;
            }

            .row-alert {
                margin-top: 0px;
                margin-bottom: 0px;
                display: none;
            }

            .row-alert>div {
                font-size: small;
                padding: 0px;
                display: flex;
            }
        </style>
    </head>

    <body>
        <div class="container border">
            <div class="row">
                <!-- 사이드바 -->
                <div class="col-md-3">
                    <div class="panel panel-info">
                        <div class="panel-heading" align="center">
                            <h3>
                                ${mypageList.id}
                            </h3>
                            ${mypageList.email1}@${mypageList.email2}
                        </div>
                    </div>
                    <hr>
                    <div class="panel panel-info">
                        <ul class="list-group">
                            <li class="list-group-item"><a href="/members/myPage.jsp">내프로필</a></li>
                            <li class="list-group-item"><a href="/board/rankingBoard.jsp">랭킹</a></li>
                            <li class="list-group-item"><a href="/members/deleteAccount.jsp">회원탈퇴</a></li>
                        </ul>
                    </div>
                    <hr>
                </div>
                <div class="col-md-9 border" style="padding: 20px;">
                    <form action="/update.members" class="row g-3 needs-validation" id="mypage_form" method="post">
                        <div class="mb-3 row">
                            <label for="password" class="col-sm-3 col-form-label">Password</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control update_list" id="password" name="password"
                                    readonly>
                            </div>
                            <div class="row g-0 row-alert">
                                <div class="col-6 sign-header"></div>
                                <div class="col-6 sign-body pw-alert alert"></div>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="verifyPassword" class="col-sm-3 col-form-label">Password 재입력</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control update_list" id="verifyPassword" readonly>
                            </div>
                            <div class="row g-0 row-alert">
                                <div class="col-6 sign-header"></div>
                                <div class="col-6 sign-body verify-pw-alert alert"></div>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="name" class="col-sm-3 col-form-label">이름</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control update_list" id="name" name="name"
                                    value="${mypageList.name}" readonly>
                            </div>
                            <div class="row g-0 row-alert">
                                <div class="col-6 sign-header"></div>
                                <div class="col-6 sign-body name-alert alert"></div>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="phone" class="col-sm-3 col-form-label">전화번호</label>
                            <div class="col-sm-3">

                                <input type="text" class="form-control update_list" id="phone_head" name="phone_head"
                                    value="${mypageList.phone1}" pattern="\d*" maxlength="3" readonly>
                            </div>
                            <div class="col-sm-3">
                                <input type="text" class="form-control update_list" id="phone_body" name="phone_body"
                                    value="${mypageList.phone2}" pattern="\d*" maxlength="4" readonly>
                            </div>
                            <div class="col-sm-3">
                                <input type="text" class="form-control update_list" id="phone_tail" name="phone_tail"
                                    value="${mypageList.phone3}" pattern="\d*" maxlength="4" readonly>
                            </div>
                        </div>
                        <div class="row g-0 row-alert">
                            <div class="col-6 sign-header"></div>
                            <div class="col-6 sign-body phone-alert alert"></div>
                        </div>
                        <div class="mb-3 row">
                            <label for="email" class="col-sm-3 col-form-label">Email</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control update_list" id="email1" name="email1"
                                    value="${mypageList.email1}" readonly>
                            </div>

                            <div class="col-sm-1">
                                @
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="email2" name="email2"
                                    value="${mypageList.email2}" readonly>
                                <select class="form-select" id="email2_dropdown" name="email2" style="display: none;">
                                    <option selected>선택하세요</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="hanmail.com">hanmail.com</option>
                                    <option value="">직접입력</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="postcode" class="col-sm-3 col-form-label">우편번호</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="postcode" name="postcode"
                                    value="${mypageList.postcode}" readonly>
                            </div>
                            <div class="col-sm-3">
                                <input type="button" class="btn btn-primary" id="postcode_btn" value="우편번호 찾기"
                                    style="display: none;" onclick="execDaumPostcode()">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="address1" class="col-sm-3 col-form-label">주소</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control update_list" id="address" name="address1"
                                    value="${mypageList.address1}" readonly>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="address2" class="col-sm-3 col-form-label">상세주소</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control update_list" id="detailAddress" name="address2"
                                    value="${mypageList.address2}" readonly>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <div class="col-sm-12" style="text-align: right;">
                                <input type="submit" class="btn btn-primary" id="update_complete" value="수정 완료"
                                    style="display: none;">
                                <input type="button" class="btn btn-primary" id="cancle_btn" value="취소"
                                    style="display: none;">
                                <input type="button" class="btn btn-primary" id="update_btn" value="수정하기">
                                <input type="button" class="btn btn-primary" id="return_btn" value="뒤로가기">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            let inputPW = document.getElementById("password");
            let inputPWC = document.getElementById("verifyPassword");
            let inputName = document.getElementById("name");
            let inputPhoneHead = document.getElementById("phone_head");
            let inputPhoneBody = document.getElementById("phone_body");
            let inputPhoneTail = document.getElementById("phone_tail");

            //Email Dropdown
            $("#email2_dropdown").on("change", function () {
                // 직접입력 선택
                if ($(this).val() == "") {
                    $("#email2").css("display", "inline-block");
                    $("#email2").removeAttr("readonly");
                    $("#email2").val("");
                }
                // 그 외 선택
                else {
                    $("#email2").val($(this).val());
                    $("#email2").css("display", "none");
                }
            })

            // 취소 버튼 클릭
            $("#cancle_btn").on("click", function () {
                location.reload();
            });

            // 수정하기 버튼 클릭
            $("#update_btn").on("click", function () {
                $("#email2_dropdown").css("display", "inline-block");
                $("#postcode_btn").css("display", "inline-block");
                $("#update_complete").css("display", "inline-block");
                $("#cancle_btn").css("display", "inline-block");

                $("#email2").css("display", "none");
                $("#update_btn").css("display", "none");
                $("#return_btn").css("display", "none");

                // 업데이트 리스트 쓰기 가능하게 변경
                $(".update_list").removeAttr("readonly");
            });

            // 뒤로가기 버튼 클릭
            $("#return_btn").on("click", function () {
                location.href = "/index.jsp";
            });

            // rowAlert 배열
            let rowAlert = document.getElementsByClassName("row-alert");

            // password 입력 시 유효성 검사
            let pwAlert = document.getElementsByClassName("pw-alert")[0];
            inputPW.onkeyup = function (e) {
                let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
                let pwRegExr2 = /[0-9]+/;
                if (inputPW.value == "") {
                    rowAlert[0].setAttribute("style", "display:none");
                    pwAlert.innerHTML = "";
                } else {
                    rowAlert[0].setAttribute("style", "display: flex")
                    if (!(pwRegExr.test(inputPW.value) && pwRegExr2.test(inputPW.value))) {
                        pwAlert.setAttribute("style", "color: red;");
                        pwAlert.innerHTML = "올바르지 않은 비밀번호 형식입니다.";
                    } else {
                        pwAlert.setAttribute("style", "color: blue;");
                        pwAlert.innerHTML = "올바른 비밀번호 형식입니다.";
                    }
                }
            }

            // password 확인 입력 시 유효성 검사
            let pwcAlert = document.getElementsByClassName("verify-pw-alert")[0];
            let ispwcPassed = false;
            inputPWC.onkeyup = function (e) {
                if (inputPWC.value == "") {
                    rowAlert[1].setAttribute("style", "display:none");
                    pwcAlert.innerHTML = "";
                } else {
                    rowAlert[1].setAttribute("style", "display: flex")
                    if (inputPW.value != inputPWC.value) {
                        pwcAlert.setAttribute("style", "color: red;");
                        pwcAlert.innerHTML = "비밀번호가 다릅니다.";
                        ispwcPassed = false;
                    } else {
                        pwcAlert.setAttribute("style", "color: blue;");
                        pwcAlert.innerHTML = "비밀번호와 일치합니다.";
                        ispwcPassed = true;
                    }
                }
            }

            // 이름 입력 시 유효성 검사
            let nameAlert = document.getElementsByClassName("name-alert")[0];
            inputName.onkeyup = function (e) {
                let nameRegExr = /^[^A-Za-z0-9_]{2,5}$/;
                if (inputName.value == "") {
                    rowAlert[2].setAttribute("style", "display:none");
                    nameAlert.innerHTML = "";
                } else {
                    rowAlert[2].setAttribute("style", "display: flex")
                    if (!nameRegExr.test(inputName.value)) {
                        nameAlert.setAttribute("style", "color: red;");
                        nameAlert.innerHTML = "올바르지 않은 이름 형식입니다.";
                    } else {
                        nameAlert.setAttribute("style", "color: blue;");
                        nameAlert.innerHTML = "올바른 이름 형식입니다.";
                    }
                }
            }

            // submit 버튼 클릭시
            let frm = document.getElementById("mypage_form");
            frm.onsubmit = function () {
                let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
                let nameRegExr = /^[^A-Za-z0-9_]{2,5}$/;
                let phoneHeadRegExr = /[0-9]{3}$/;
                let phoneRegExr = /[0-9]{4}$/;
                let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;

                if (!pwRegExr.test(inputPW.value)) {
                    alert("비밀번호를 확인 해주십시오.")
                    return false;
                } else if (!ispwcPassed) {
                    alert("비밀번호 재입력 칸을 확인 해주십시오.")
                    return false;
                } else if (!nameRegExr.test(inputName.value)) {
                    alert("이름을 확인 해주십시오.")
                    return false;
                } else if (!phoneHeadRegExr.test(inputPhoneHead.value) || !phoneRegExr.test(inputPhoneBody.value) || !phoneRegExr.test(inputPhoneTail.value)) {
                    alert("전화번호를 확인 해주십시오.")
                    return false;
                } else if ($("#email1").val() == "") {
                    alert("이메일 주소를 확인 해주십시오.")
                    return false;
                } else if ($("#address").val() == "" || $("#detailaddress").val() == "") {
                    alert("주소를 확인 해주십시오.")
                    return false;
                } else {
                    return true;
                }
            }


            // Kakao Post API
            function execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function (data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('postcode').value = data.zonecode;
                        document.getElementById("address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("detailAddress").focus();
                    }
                }).open();
            }
        </script>
    </body>

    </html>