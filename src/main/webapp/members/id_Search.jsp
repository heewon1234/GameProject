<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
body {
	padding-top: 60px;
}

a {
	text-decoration-line: none;
	color: black;
}
</style>
<body>
	<div class="container border" style="width: 50rem;margin-top: 10%;">
		<div class="row" >
			<!-- 사이드바 -->
			<div class="col-md-3"  style="padding-top: 5%;">
				<hr>
				<div class="panel panel-info">
					<ul class="list-group">
						<li class="list-group-item" style="background-color: #DDE6ED; "><a href="#" style="color: #526D82">아이디 찾기</a></li>
						<li class="list-group-item" ><a href="#">비밀번호
								찾기</a></li>
						<li class="list-group-item"><a href="#">로그인</a></li>
					</ul>
				</div>
				<hr>
			</div>
			<div class="col-md-9 border" style="padding: 20px;">
				<form>
					<div>아이디 찾기</div>
					<hr>
					<div class="row mb-3">
						<label for="inputName" class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input type="name" class="form-control" id="inputName">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="email" class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-5">
							<input type="text" class="form-control update_list" id="email1"
								name="email1" value="${mypageList.email1}" readonly>
						</div>

						<div class="col-sm-1">@</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="email2" name="email2"
								value="${mypageList.email2}" readonly> <select
								class="form-select" id="email2_dropdown" name="email2"
								style="display: none;">
								<option selected>선택하세요</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.com">hanmail.com</option>
								<option value="">직접입력</option>
							</select>
						</div>
					</div>
					<hr style="color: gray;">
					<div class="row mb-3">
						<div class="col-sm-10">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="gridCheck1">
								<label class="form-check-label" for="gridCheck1"> 본인확인
									이메일로 인증</label>
							</div>
						</div>
					</div>
					<div class="row justify-content-center">
						<div class="col-auto">
							<button type="submit" class="btn btn-primary">다음</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>