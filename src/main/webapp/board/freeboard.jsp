<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>자유게시판</title>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
				integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
				crossorigin="anonymous">
			<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
			<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
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
				
				.page {
					text-decoration: none;
					color : black;
				}
			</style>
		</head>

		<body>
			<div class="container-fluid p-0">
				<div id="head">
					<div>
						<div class="container">
							<div class="row">
								<div class="col-md-2 d-flex align-items-center justify-content-center">
									<a href="/index.jsp"><img src="/UI_img/marvlestudio.jpg"></a>
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
								<div class="col-md-8 ml-auto d-flex align-items-center justify-content-end p-0">
									<a class="nav-link" href="/logout.members"><img src="/UI_img/log-out.svg"></a>
								</div>

							</div>
						</div>
					</div>
					<div style="background-color: #D2DAFF; height: 20px"></div>
				</div>
				<div class="container-fluid p-0" style="background-color: #EEF1FF;">
					<div id="body" class="container p-0">
						<div id="top" style="display: flex; justify-content: center; align-items: center;">
							<img src="/UI_img/marvlestudio.jpg" alt="Marvel Studio">
						</div>

						<div id="center" class="mt-4" style="background-color: #FFF9B0; text-align: center;">
							<ul class="nav nav-pills nav-fill"
								style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
								<li class="nav-item"><a class="nav-link" href="/mypage.members">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link" href="/game/minesweeper/eazyMinesweeper.jsp">게임</a></li>
								<li class="nav-item"><a class="nav-link" href="/list.board">자유게시판</a></li>
								<li class="nav-item"><a class="nav-link" href="/board/rankingBoard.jsp">랭킹게시판</a></li>
							</ul>
						</div>



						<div id="bottom" class="p-3 mt-2">
							<div class="d-flex pb-1 justify-content-end">
								<form class="d-flex pb-3" role="search" style="width: 250px;" method="get" id="searchForm">
									<input class="form-control me-2" type="search" placeholder="Search"
										aria-label="Search" id="input_search" name="keyword">
									<button class="btn btn-outline-success" type="button" id="btn_search">Search</button>
								</form>
							</div>
							<div id="title" class="p-2"
								style="background-color: white; display: flex; justify-content: space-between; align-items: center; font-size: larger;">
								<div>자유게시판</div>
								<div>프로필 정보</div>
							</div>
							<div id="contents" class="mt-4">
								<table class="table">
									<thead>
										<tr>
											<th scope="col" style="width: 40px; text-align: center">번호</th>
											<th scope="col" style="width: 80px; text-align: center">카테고리</th>
											<th scope="col" style="width: 400px">제목</th>
											<th scope="col" style="width: 50px; text-align: center">조회수</th>
											<th scope="col" style="width: 120px; text-align: center">작성자</th>
											<th scope="col" style="width: 120px; text-align: center">작성일</th>
										</tr>
									</thead>
									<tbody class="table-group-divider">
										<c:forEach var="list" items="${listDTO }">
											<tr>
												<th scope="row" style="text-align: center">${list.seq}</th>
												<td style="text-align: center">${list.game_name}</td>
												<td><a href="/showContents.board?seq=${list.seq}">${list.title}</a></td>
												<td style="text-align: center">${list.view_count}</td>
												<td style="text-align: center">${list.writer}</td>
												<td style="text-align: center">${list.timestampToString}</td>
											</tr>
										</c:forEach>
										<tr>
											<td colspan="6" style="text-align: right;">
												<input type="button" class="btn btn-primary" id="write_btn" value="작성하기">
												<input type="button" class="btn btn-primary" id="home_btn" value="홈으로">
											</td>
										</tr>
									</tbody>
								</table>
								<div class="d-flex justify-content-center" id="navi">
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<div id="footer_container"></div>
			<script>
			$(document).ready(function () {
	            $("#footer_container").load("../commons/footer.html")
	        });
				// 페이지네이션
				let recordTotalCount = ${ recordTotalCount };
				let recordCountPerPage = ${ recordCountPerPage };
				let naviCountPerPage = ${ naviCountPerPage };

				// // 총 페이지 개수
				let pageTotalCount = 0;
				let latestPage = ${ latestPage };

				if (recordTotalCount % recordCountPerPage > 0) {
					pageTotalCount = Math.floor((recordTotalCount / recordCountPerPage)) + 1;
				} else {
					pageTotalCount = Math.floor((recordTotalCount / recordCountPerPage));
				}

				let startNavi = Math.floor((latestPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
				let endNavi = startNavi + (naviCountPerPage - 1);

				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				}

				let needPrev = true;
				let needNext = true;

				if (startNavi == 1) { needPrev = false; }
				if (endNavi == pageTotalCount) { needNext = false; }

				if (needPrev) { $("#navi").append("<a class='page ms-1 me-1' href=/list.board?keyword=${keyword}&cPage=" + (startNavi - 1) + "> < </a> "); }
				for (let i = startNavi; i <= endNavi; i++) {
					$("#navi").append("<a class='page ms-1 me-1' href=/list.board?keyword=${keyword}&cPage=" + i + ">" + i + "</a> ");
				}
				if (needNext) { $("#navi").append("<a class='page ms-1 me-1' href=/list.board?keyword=${keyword}&cPage=" + (endNavi + 1) + ">> </a> "); }
				// 페이지네이션 끝
				
				$("#write_btn").on("click", function () {
                    location.href = "/board/write.jsp";
                });
                $("#home_btn").on("click", function () {
                    location.href = "/index.jsp";
                });
                $("#btn_search").on("click", function() {
                	if($("#input_search").val() == "") {
                		return false;
                	}
                	$("#searchForm").submit();
                })
                
			</script>
		</body>

		</html>