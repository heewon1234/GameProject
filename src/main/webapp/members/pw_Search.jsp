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
		<div class="row">
			<!-- 사이드바 -->
			<div class="col-md-3"  style="padding-top: 5%;">
				
				<hr>
				<div class="panel panel-info">
					<ul class="list-group">
						<li class="list-group-item"><a href="#">아이디 찾기</a></li>
						<li class="list-group-item" style="background-color: #DDE6ED;"><a href="#" style="color: #526D82">비밀번호
								찾기</a></li>
						<li class="list-group-item"><a href="#">로그인</a></li>
					</ul>
				</div>
				<hr>
			</div>
			<div class="col-md-9 border" style="padding: 20px;">
				<form>
					<div><h5>비밀번호 찾기</h5></div>
					<hr>
					<div class="row m-0 border" style="border-radius: 5px; max-width:">
						<div class="col-sm-1"
							style="display: flex; justify-content: center; align-items: center;">
							<img src="/UI_img/user.svg" alt="userImg">
						</div>
						<div class="col-sm-11 p-0">
							<input class="form-control" id="inputID" placeholder="아이디 입력"
								style="border: none; font-size: larger;">
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-12 mt-3" style="display: flex;justify-content: center;">
							<button type="submit" class="btn btn-primary" style="width: 50%;">다음</button>
						</div>
					</div>
					<hr style="color: gray;">
					<div class="row mb-3">
						<div class="col-sm-12 d-flex justify-content-center">
							<div class="text-center">
								아이디가 기억나지 않는다면? <a href="#" style="color: blue;">아이디 찾기</a>
							</div>
						</div>
					</div>
			</div>

			</form>
		</div>
	</div>
	</div>

</body>
</html>