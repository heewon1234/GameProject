<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
</head>
<style>
* {
	box-sizing: border-box;
}

.containerBox {
	padding-top: 60px;
	margin: auto;
}

a {
	text-decoration-line: none;
	color: black;
}
#logoImg:hover{cursor:pointer;}
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
					<form action="/pwSearch.members" method="post" id="pw-search-form">
						<div>비밀번호 찾기</div>
						<hr>
						<div class="row mb-3">
							<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputId"
									name="inputId">
							</div>
						</div>

						<div class="mb-3 row"
							style="display: flex; justify-content: space-between;">
							<label for="email" class="col-sm-2 col-form-label">이메일</label>
							<div class="col-sm-3">
								<input type="text" class="form-control update_list" id="email1"
									name="email1">
							</div>

							@
							<div class="col-sm-3">
								<input type="text" class="form-control" id="email2"
									name="email2" style="width: 125px; background-color: #D5D5D5;"
									readonly="true">
							</div>
							<div class="col-sm-3 sign-body">

								<select class="form-select" id="email2_dropdown">
									<option value="선택하세요" selected>선택</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.com">hanmail.com</option>
									<option value="직접입력">직접입력</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-4">
								<input type="button" class="btn btn-outline-primary"
									value="인증코드 발송" id="btn-send-verification">
							</div>

							<!-- 인증 코드 입력 폼 -->
							<div class="col-sm-5">
								<input type="text" class="form-control" placeholder="인증 코드 입력"
									id="input-verification-code">
							</div>
							<div class="col-sm-3"
								style="display: flex; justify-content: end;">
								<input type="button" class="btn btn-outline-primary"
									value="인증확인" id="btn-verify-code">
							</div>
						</div>
						<div class="row g-0 row-alert">
							<!-- 이메일 올바른지 체크 메시지 -->
							<div class="col-6 sign-body email-alert alert"></div>
							<!-- 인증 결과 메시지 -->
							<div class="col-6 sign-body verification-alert alert"></div>
						</div>

						<hr style="color: gray;">

						<div class="row justify-content-center">
							<div class="col-auto">
								<button type="submit" class="btn btn-primary" id="btn-next">다음</button>
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

		let inputID = document.getElementById("inputId");
		let inputEmail = document.getElementById("email1");
		let inputEmail2 = document.getElementById("email2");
		let btnSubmit = document.getElementById("btn-next");

		$("#email2_dropdown")
				.on(
						"change",
						function() {
							if ($("#email2_dropdown option:selected").val() == "직접입력") {
								$("#email2").val("").css("backgroundColor",
										"white").attr("readonly", false);
							} else if ($("#email2_dropdown option:selected")
									.val() == "선택하세요") {
								$("#email2").val("").css("backgroundColor",
										"#D5D5D5").attr("readonly", true);
							} else {
								$("#email2").val(
										$("#email2_dropdown option:selected")
												.val()).css("backgroundColor",
										"#D5D5D5").attr("readonly", true);
							}
						})

		// 이메일 인증 코드 발송 버튼 클릭 이벤트 핸들러
		$("#btn-send-verification").on("click", function() {
			let email = inputEmail.value + "@" + inputEmail2.value;

			// 이메일 주소가 유효한지 확인 (예: 정규식 사용)
			let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;
			if (!emailRegExr.test(email)) {
				$(".verification-alert").text("올바른 이메일 형식이 아닙니다.");
				return;
			}

			// 서버에 이메일 주소를 전송하고 인증 코드를 요청
			$.ajax({
				url : "/sendVerificationCode.members", // 서버의 인증 코드 발송 API 엔드포인트
				method : "POST",
				data : {
					email : email
				},
				success : function(data) {
					if (data === "success") {
						// 인증 코드 발송 성공
						$(".verification-alert").text("인증 코드가 발송되었습니다.");
					} else if (data === "email_error") {
						// 이메일 주소 오류
						$(".verification-alert").text("올바르지 않은 이메일 주소입니다.");
					} else if (data === "send_error") {
						// 이메일 발송 오류
						$(".verification-alert").text("인증 코드 발송에 실패했습니다.");
					}
				},
				error : function() {
					$("verification-alert").text("서버와의 통신 중 오류가 발생했습니다.");
				}
			});
		});

		let isEmailVerified = false;

		// 인증 코드 확인 버튼 클릭 이벤트 핸들러
		$("#btn-verify-code").on("click", function() {
			let enteredCode = $("#input-verification-code").val();

			// 서버에 인증 코드를 전송하고 검증
			$.ajax({
				url : "/verifyCode.members", // 서버의 인증 코드 검증 API 엔드포인트
				method : "POST",
				data : {
					code : enteredCode
				},
				success : function(data) {
					if (data === "success") {
						// 인증 코드 일치
						$(".verification-alert").text("인증되었습니다.");
						isEmailVerified = true;
					} else {
						// 인증 코드 불일치
						$(".verification-alert").text("인증 코드가 일치하지 않습니다.");
						isEmailVerified = false;
					}
				},
				error : function() {
					$(".verification-alert").text("서버와의 통신 중 오류가 발생했습니다.");
					isEmailVerified = false;
				}
			});
		});

		// submit 버튼 클릭시
		let frm = document.getElementById("pw-search-form");

		frm.onsubmit = function() {
			let idRegExr = /^[A-Za-z0-9_]{8,14}$/;
			let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;

			if (!idRegExr.test(inputID.value)) {
				alert("ID를 확인 해주십시오.");
				return false;
			} else if (!emailRegExr.test(inputEmail.value + "@"
					+ inputEmail2.value)) {
				alert("이메일 주소를 확인 해주십시오.");
				return false;
			} else if (!isEmailVerified) {
				alert("이메일 인증이 필요합니다.");
				return false;
			} else {
				return true;
			}
		};
	</script>
</body>
</html>