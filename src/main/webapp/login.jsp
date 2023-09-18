<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<style>
.container {
	width: 600px;
}
#head{padding:30px;font-size: 4rem; display: flex;justify-content: center;align-content: center;}
form,#footer {
	border: 1px solid gray; /* 테두리 스타일 및 색상 설정 */
	padding: 40px; /* 테두리 주위의 여백 설정 */
}
</style>
</head>
<body>
	<div class="container">
		<div id="head">Login</div>
		<div id="body">
			<form>
				<div class="row mb-3">
					<label for="inputId" class="col-sm-3 col-form-label"><img src="user.svg" alt="userImg">
					아이디</label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputId">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputPassword" class="col-sm-3 col-form-label"><img src="lock.svg" alt="lockImg"> 비밀번호</label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="inputPassword">
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-12">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="idCheck">
							<label class="form-check-label" for="idCheck"> 아이디
								기억하기 </label>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<button type="submit" class="btn btn-primary ">로그인</button>
				</div>
			</form>
			<div class="row mb-3">
				<ul class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">비밀번호 찾기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">아이디 찾기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">회원가입</a></li>
				</ul>
			</div>
		</div>
		<div id="footer" style="text-align: center">어벤져스</div>
	</div>
</body>
</html>