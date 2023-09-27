<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 탈퇴</title>
<!-- JQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<!-- Bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<!-- SHA 512 -->
<script src="/commons/sha512.js" type="text/javascript"></script>

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
	<div class="container">
		<div class="row p-0 m-0 header" id="main-header"></div>
		<hr>
		<div class="center" style="margin-top: 175px; margin-bottom: 200px;">
			<div class="row">
				<!-- 사이드바 -->
				<div class="col-md-3">
					<div class="panel panel-info">
						<div class="panel-heading" align="center">
							<h3>${mypageList.id}</h3>
							${mypageList.email}
						</div>
					</div>
					<hr>
					<div class="panel panel-info">
						<ul class="list-group">
							<li class="list-group-item"><a href="/mypage.members">내
									프로필</a></li>
							<li class="list-group-item"><a
								href="/board/rankingBoard.jsp">랭킹</a></li>
							<li class="list-group-item"><a
								href="/delAccountPage.members">회원탈퇴</a></li>
						</ul>
					</div>
					<hr>
				</div>
				<div class="col-md-9 border"
					style="padding: 20px; display: flex; align-items: center;">
					<form action="/memberOut.members" class="row g-3 needs-validation"
						id="deleteAccount_form" method="post">
						<div class="mb-3 row">
							<label for="password" class="col-sm-3 col-form-label">Password</label>
							<div class="col-sm-9">
								<input type="password" class="form-control update_list"
									id="password" name="password">
							</div>
						</div>
						<div class="mb-3 row">
							<label for="verifyPassword" class="col-sm-3 col-form-label">Password
								재입력</label>
							<div class="col-sm-9">
								<input type="password" class="form-control update_list"
									id="verifyPassword" name="verifyPassword">
							</div>
							<div class="row g-0 row-alert">
								<div class="col-3 sign-header"></div>
								<div class="col-9 sign-body verify-pw-alert alert"></div>
							</div>
						</div>

						<div class="mb-3 row">
							<div class="col-sm-12" style="text-align: right;">
								<input type="submit" class="btn btn-primary" id="delete_btn"
									value="회원탈퇴"> <input type="button"
									class="btn btn-primary" id="return_btn" value="뒤로가기">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="footer_container"></div>
	<script>
        $(document).ready(function() {
    		$("#main-header").load("/commons_ui/header.html");
    	});
        $(document).ready(function() {
    		$("#footer_container").load("/commons/footer.html")
    	});
        
            let inputPW = document.getElementById("password");
            let inputPWC = document.getElementById("verifyPassword");
            // rowAlert 배열
            let rowAlert = document.getElementsByClassName("row-alert");

            // password 확인 입력 시 유효성 검사
            let pwcAlert = document.getElementsByClassName("verify-pw-alert")[0];
            let ispwcPassed = false;
            inputPWC.onkeyup = function (e) {
                if (inputPWC.value == "") {
                    rowAlert[0].setAttribute("style", "display:none");
                    pwcAlert.innerHTML = "";
                } else {
                    rowAlert[0].setAttribute("style", "display: flex")
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

            let frm = document.getElementById("deleteAccount_form");
    		frm.onsubmit = function() {
    			if (hex_sha512(inputPW.value) != "${loginPassword}") {
                    alert("비밀번호를 확인 해주십시오.");
                    inputPW.focus();
                    return false;
                } else if (!ispwcPassed) {
                    alert("비밀번호 재입력 칸을 확인 해주십시오.");
                    inputPWC.focus();
                    return false;
                } else {
                    let con_result = confirm("정말로 회원 탈퇴 하시겠습니까?");
                    if (con_result == false) {
                        return false;
                    } else {
                    	return true;
                    }
                }
    		};
    		
            // 뒤로가기 버튼 클릭
            $("#return_btn").on("click", function () {
                location.href = "/index.jsp";
            });
        </script>
</body>

</html>