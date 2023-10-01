<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
</head>
<style>
.containerBox {
	padding-top: 60px;
	margin: auto;
}

a {
	text-decoration-line: none;
	color: black;
}
</style>
<body>
	<div class="containerBox" style="width: 50rem;">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<img src="/UI_img/logo3.jpg"
					style="width: 100%; margin-bottom: 35px;" id="logoImg">
			</div>
			<div class="col-md-3"></div>
		</div>
		<div class="container border">
			<div class="row">
				<!-- 사이드바 -->
				<div class="col-md-3" style="padding-top: 5%;">
					<hr>
					<div class="panel panel-info">
						<ul class="list-group">
							<li class="list-group-item"><a href="/members/id_Search.jsp">아이디
									찾기</a></li>
							<li class="list-group-item" style="background-color: #DDE6ED;"><a
								href="/members/pw_Search.jsp" style="color: #526D82">비밀번호 찾기</a></li>
							<li class="list-group-item"><a href="/members/login.jsp">로그인</a></li>
						</ul>
					</div>
					<hr>
				</div>
				<div class="col-md-9 border" style="padding: 20px;">
					<div>비밀번호 찾기</div>
					<hr>

					<div>비밀번호를 수정해주세요.</div>
					<hr style="color: white;">
					<form action="/pw_reset.members" id="pw-update-form" method="post">

						<div>
							<div class="mb-3 row">
								<label for="newPassword" class="col-sm-3 col-form-label">새
									비밀번호</label>
								<div class="col-sm-9">
									<input type="password" class="form-control update_list"
										id="newPassword" name="newPassword">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="confirmPassword" class="col-sm-3 col-form-label">비밀번호
									확인</label>
								<div class="col-sm-9">
									<input type="password" class="form-control update_list"
										id="confirmPassword" name="confirmPassword">
								</div>
								<div class="password-alert" id="password-alert"
									style="padding: 12px;"></div>
							</div>
						</div>


						<hr style="color: gray;">

						<div class="row justify-content-center">
							<div class="col-auto">
								<button type="submit" class="btn btn-primary" id="btn-submit">수정완료</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		$("#logoImg").on("click", function() {
			location.href = "/";
		})

		// 비밀번호 입력 시 유효성 검사
		let newPasswordInput = document.getElementById("newPassword");
		let confirmPasswordInput = document.getElementById("confirmPassword");
		let passwordAlert = document.getElementsByClassName("password-alert")[0];
		let btnSubmit = document.getElementById("btn-submit");
		let ispwcPassed = false;

		newPasswordInput.onkeyup = function() {
			validatePassword();
		}
		confirmPasswordInput.onkeyup = function() {
			validatePassword();
		}

		function validatePassword() {
			let newPassword = newPasswordInput.value;
			let confirmPassword = confirmPasswordInput.value;

			if (newPassword === "" && confirmPassword === "") {
				passwordAlert.innerHTML = "";
				return;
			}

			if (newPassword !== confirmPassword) {
				passwordAlert.innerHTML = "비밀번호가 일치하지 않습니다.";
				passwordAlert.style.color = "red";
				ispwcPassed = false;
			} else {
				passwordAlert.innerHTML = "비밀번호가 일치합니다.";
				passwordAlert.style.color = "blue";
				ispwcPassed = true;
			}
		}

		// submit 버튼 클릭시
		let frm = document.getElementById("pw-update-form");
		frm.onsubmit = function() {
			let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
			let newPassword = newPasswordInput.value;

			if (!pwRegExr.test(newPassword)) {
				alert("비밀번호를 확인 해주십시오.");
				return false;
			} else if (!ispwcPassed) {
				alert("비밀번호 재입력 칸을 확인 해주십시오.");
				return false;
			} else {
				return true;
			}
		};
	</script>
</body>
</html>