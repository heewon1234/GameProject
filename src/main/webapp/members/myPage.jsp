<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <!-- SHA 512 -->
    <script src="/commons/sha512.js" type="text/javascript"></script>    
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
                        ${mypageList.email}
                    </div>
                </div>
                <hr>
                <div class="panel panel-info">
                    <ul class="list-group">
                        <li class="list-group-item"><a href="/mypage.members">내프로필</a></li>
                        <li class="list-group-item"><a href="/board/rankingBoard.jsp">랭킹</a></li>
                        <li class="list-group-item"><a href="/delAccountPage.members">회원탈퇴</a></li>
                        <c:if test="${mypageList.id eq 'admin'}">
                            <li class="list-group-item"><a href="/membersInfo.members">관리자 페이지</a></li>
                        </c:if>
                    </ul>
                </div>
                <hr>
            </div>
            <div class="col-md-9 border" style="padding: 20px;">
                <form action="/update.members" class="row g-3 needs-validation" id="mypage_form" method="post">
                    <div class="mb-3 row">
                        <label for="password" class="col-sm-3 col-form-label">현재 Password</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control update_list" id="password" readonly>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="password" class="col-sm-3 col-form-label">변경할 Password</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control update_list" id="changePassword" name="password"
                                readonly>
                        </div>
                        <div class="row g-0 row-alert">
                            <div class="col-3 sign-header"></div>
                            <div class="col-9 sign-body pw-alert alert"></div>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="verifyPassword" class="col-sm-3 col-form-label">Password 재입력</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control update_list" id="verifyPassword" readonly>
                        </div>
                        <div class="row g-0 row-alert">
                            <div class="col-3 sign-header"></div>
                            <div class="col-9 sign-body verify-pw-alert alert"></div>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="name" class="col-sm-3 col-form-label">이름</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control update_list" id="name" name="name"
                                value="${mypageList.name}" readonly>
                        </div>
                        <div class="row g-0 row-alert">
                            <div class="col-3 sign-header"></div>
                            <div class="col-9 sign-body name-alert alert"></div>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="phone" class="col-sm-3 col-form-label">전화번호</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control update_list" id="phone_head" name="phone_head"
                                value="${fn:substring(mypageList.phone,0,3) }" pattern="\d*" maxlength="3" readonly>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" class="form-control update_list" id="phone_body" name="phone_body"
                                value="${fn:substring(mypageList.phone,3,7) }" pattern="\d*" maxlength="4" readonly>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" class="form-control update_list" id="phone_tail" name="phone_tail"
                                value="${fn:substring(mypageList.phone,7,11) }" pattern="\d*" maxlength="4" readonly>
                        </div>
                    </div>
                    <div class="row g-0 row-alert">
                        <div class="col-3 sign-header"></div>
                        <div class="col-9 sign-body phone-alert alert"></div>
                    </div>
                    <div class="mb-3 row">
                        <label for="postcode" class="col-sm-3 col-form-label">우편번호</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="postcode" name="zipcode"
                                value="${mypageList.zipcode}" readonly>
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
        let inputCPW = document.getElementById("changePassword");
        let inputVPW = document.getElementById("verifyPassword");
        let inputName = document.getElementById("name");
        let inputPhoneHead = document.getElementById("phone_head");
        let inputPhoneBody = document.getElementById("phone_body");
        let inputPhoneTail = document.getElementById("phone_tail");

        // 취소 버튼 클릭
        $("#cancle_btn").on("click", function () {
            location.reload();
        });

        // 수정하기 버튼 클릭
        $("#update_btn").on("click", function () {
            $("#postcode_btn").css("display", "inline-block");
            $("#update_complete").css("display", "inline-block");
            $("#cancle_btn").css("display", "inline-block");

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

        let ispwcPassed = false;
        
        // chanePassword 입력 시 유효성 검사
        let pwAlert = document.getElementsByClassName("pw-alert")[0];
        inputCPW.onkeyup = function (e) {
            let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
            let pwRegExr2 = /[0-9]+/;
            let pwRegExr3 = /[A-Za-z]+/;
            if (inputCPW.value == "") {
                rowAlert[0].setAttribute("style", "display:none");
                pwAlert.innerHTML = "";
            } else {
                rowAlert[0].setAttribute("style", "display: flex")
                if (!(pwRegExr.test(inputCPW.value) && pwRegExr2
						.test(inputCPW.value) && pwRegExr3.test(inputCPW.value))) {
                    pwAlert.setAttribute("style", "color: red;");
                    pwAlert.innerHTML = "올바르지 않은 비밀번호 형식입니다.";
                } else {
                    pwAlert.setAttribute("style", "color: blue;");
                    pwAlert.innerHTML = "올바른 비밀번호 형식입니다.";
                }
            }
            
         	// 비밀번호 확인칸과 비교 및 알림창 바꾸기
			if (inputPW.value != inputPWC.value && $(rowAlert[1]).attr("style") == "display: flex") {
                pwcAlert.setAttribute("style", "color: red;");
                pwcAlert.innerHTML = "비밀번호가 다릅니다.";
                ispwcPassed = false;
            } else if (inputPW.value == inputPWC.value && $(rowAlert[1]).attr("style") == "display: flex") {
                pwcAlert.setAttribute("style", "color: blue;");
                pwcAlert.innerHTML = "비밀번호와 일치합니다.";
                ispwcPassed = true;
            }
        }

        // password 확인 입력 시 유효성 검사
        let pwcAlert = document.getElementsByClassName("verify-pw-alert")[0];
        inputVPW.onkeyup = function (e) {
            if (inputVPW.value == "") {
                rowAlert[1].setAttribute("style", "display:none");
                pwcAlert.innerHTML = "";
                ispwcPassed = false;
            } else {
                rowAlert[1].setAttribute("style", "display: flex")
                if (inputCPW.value != inputVPW.value) {
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
        	let nameRegExr = /^[가-힣]{2,5}$/;
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
			let pwRegExr2 = /[0-9]+/;
			let pwRegExr3 = /[A-Za-z]+/;
			let nameRegExr = /^[가-힣]{2,5}$/;
            let phoneHeadRegExr = /[0-9]{3}$/;
            let phoneRegExr = /[0-9]{4}$/;
			
            if (hex_sha512(inputPW.value) != "${mypageList.password}" ) {
            	alert("비밀번호를 확인 해주십시오.");
                inputPW.focus();
                return false;
            } else if (!(pwRegExr.test(inputCPW.value) && pwRegExr2.test(inputCPW.value) && pwRegExr3.test(inputCPW.value))) {
                alert("변경할 비밀번호를 확인 해주십시오.");
                inputCPW.focus();
                return false;
            } else if (!ispwcPassed) {
                alert("비밀번호 재입력 칸을 확인 해주십시오.");
                inputVPW.focus();
                return false;
            } else if (!nameRegExr.test(inputName.value)) {
                alert("이름을 확인 해주십시오.");
                inputName.focus();
                return false;
            } else if (!phoneHeadRegExr.test(inputPhoneHead.value) || !phoneRegExr.test(inputPhoneBody.value) || !phoneRegExr.test(inputPhoneTail.value)) {
                alert("전화번호를 확인 해주십시오.");
                inputPhoneHead.focus();
                return false;
            } else if ($("#address").val() == "" || $("#detailaddress").val() == "") {
                alert("주소를 확인 해주십시오.");
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