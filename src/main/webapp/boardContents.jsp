<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board Contentes</title>
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
* {
	box-sizing: border-box;
}

#head {
	background-color: #B1B2FF
}

#body {
	background-color: #D2DAFF
}

#footer {
	background-color: #B1B2FF
}
</style>
</head>
<body>
	<div class="container-fluid p-0">
		<div id="head">
			<div>
				<div class="container">
					<div class="row">
						<div class="col-md-2">
							<img src="UI_img/marvlestudio.jpg">
						</div>
						<div class="col-md-2 p-0">
							<div class="d-flex align-items-center justify-content-center"
								style="height: 40px; width: 150px; border-radius: 5px; background-color: #D2DAFF; margin-top: 2.4%">
								<i class="fas fa-gamepad me-2 mx-2" style="font-size: 1.5rem;"></i>
								<select class="form-select" aria-label="Default select example"
									style="max-width: 120px; background-color: #D2DAFF; width: 100%;">
									<option selected>Game</option>
									<option value="1">One</option>
									<option value="2">Two</option>
									<option value="3">Three</option>
									<option value="4">Four</option>
									<option value="5">Five</option>
									<option value="6">Six</option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="background-color: #C9CFFF; height: 10px"></div>
		</div>
		<div class="container-fluid p-0" style="background-color: #EEF1FF;">
			<div id="body" class="container">
				<div id="top"
					style="display: flex; justify-content: center; align-items: center;">
					<img src="/UI_img/marvlestudio.jpg" alt="Marvel Studio">
				</div>

				<div id="center" class="mt-4"
					style="background-color: #FFF9B0; text-align: center;">
					<ul class="nav nav-pills nav-fill"
						style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
						<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#">게임</a></li>
						<li class="nav-item"><a class="nav-link" href="#">자유게시판</a></li>
						<li class="nav-item"><a class="nav-link" href="#">랭킹게시판</a></li>
					</ul>
				</div>
				<div id="bottom" class="p-3 mt-2">
					<div id="title" style="color: white;">자유 게시판 ></div>
					<!-- DB에서 가져와야함 ( title )-->
					<div class="p-2 mt-2" style="background-color: white;">
						<h5>Board Title</h5>
					</div>
					<!-- DB에서 가져와야함 ( user, write_date )-->
					<div id="user" class="p-2" style="display: flex;">
						<div id="userIcon" style="font-size: 3rem">
							<i class="fa-solid fa-user"></i>
						</div>
						<div class="mt-3 mx-4">
							<div id="writer">user</div>
							<div id="write_date">2023.09.19</div>
						</div>
					</div>
					<hr>
					<div class="mb-2">
						<h6>board contents</h6>
					</div>
					<hr>
					<!-- reply -->
					<div><h6>Reply contents</h6></div>
					<h6>댓글</h6>
					<div class="commendBox p-2"
							style="border: 1px solid #d3d3d3; border-radius: 8px">
							<div class="nickName mb-1">
								<input type="text" id="loginID"
									style="width: 15vw; border: none;" value="${loginID }" readonly>
							</div>
							<form action="#">
								<input type="hidden" id="seq" name="seq" value="${boardDTO.seq}">
								<div class="contents mb-2">
									<input type="text" placeholder="내용을 입력해주세요."
										name="contentsReply" style="width: 50vw">
								</div>
								<div class="controls d-flex" style="justify-content: flex-end;">
									<input id="send" type="submit" class="btn btn-primary write "
										value="등록">
								</div>
							</form>
							<hr>
							<div id="replyListContainer"></div>
						</div>
				</div>
			</div>
		</div>
		<div id="footer" class="pt-4">footer</div>
	</div>
</body>
</html>