<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link href="/ui_css/index_css.css" rel="stylesheet" type="text/css">
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

<body>
	<div class="container header pt-5 p-0">
        <div class="row p-0 m-0 header" id="main-header">
            
        </div>
        <hr>
        <div class="body">
            <div class="bodyBorder">
                <div class="banner">
                    <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                          <div class="carousel-item active">
                            <img src="/UI_img/banner_1.png" class="d-block w-100" alt="...">
                          </div>
                          <div class="carousel-item">
                            <img src="/UI_img/banner_2.png" class="d-block w-100" alt="...">
                          </div>
                          <div class="carousel-item">
                            <img src="/UI_img/banner_3.png" class="d-block w-100" alt="...">
                          </div>
                          <div class="carousel-item">
                            <img src="/UI_img/banner_4.png" class="d-block w-100" alt="...">
                          </div>
                          <div class="carousel-item">
                            <img src="/UI_img/banner_5.png" class="d-block w-100" alt="...">
                          </div>
                          <div class="carousel-item">
                            <img src="/UI_img/banner_6.png" class="d-block w-100" alt="..." style="border:1px solid gainsboro;">
                          </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                          <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                          <span class="carousel-control-next-icon" aria-hidden="true"></span>
                          <span class="visually-hidden">Next</span>
                        </button>
                      </div>
                </div>
                <div class="contents">
                    <div class="contents-left">
                        <div class="game-border">
                            <div class="game-select-text"> 게임선택 </div>
                            <hr>
                            <div class="game-select">
                                <div class="game">
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/1.png" style="width:80%;">
                                        </div>
                                        <div class="game-txt"><a href="/game/minesweeper/eazyMinesweeper.jsp">지뢰찾기</a></div>
                                    </div>
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/2.png" style="width:80%;">
                                        </div>
                                        <div class="game-txt"><a href="/game/bounceball/bounceball_main.jsp">바운스볼</a></div>
                                    </div>
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/3.png" style="width:80%;">
                                        </div>
                                        <div class="game-txt"><a href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a></div>
                                    </div>
                                </div>
                                <div class="game">
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/4.png" style="width:80%;">
                                        </div>
                                        <div class="game-txt"><a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a></div>
                                    </div>
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/5.png" style="width:80%;">
                                        </div>
                                        <div class="game-txt"><a href="/game/dragon/dragon.jsp">드래곤플라이트</a></div>
                                    </div>
                                    <div class="game-list">
                                        <div class="game-img">
                                            <img src="/UI_img/6.png" style="width:80%; border:1px solid gainsboro;">
                                        </div>
                                        <div class="game-txt"><a href="/game/colorblind/colorblind.jsp">컬러블라인드</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="board-border">
                            <div class="board-text"><a href="/list.board">최근게시물 ></a></div>
                            <div class="board">
                                <table class="table">
									<thead>
										<tr>
											<th scope="col" style="padding:0px;">번호</th>
											<th scope="col" style="padding:0px; text-align:center;">카테고리</th>
											<th scope="col" style="padding:0px; text-align:center;">제목</th>
											<th scope="col" style="padding:0px; text-align:center;">조회수</th>
											<th scope="col" style="padding:0px; text-align:center;">작성자</th>
											<th scope="col" style="padding:0px; text-align:center;">작성일</th>
										</tr>
									</thead>
									<tbody class="table-group-divider" id="tableBody">
										
									</tbody>
								</table>
                            </div>
                        </div>
                    </div>
                    <div class="contents-right">
                        <div class="loginbox">
                        	<c:choose>
                        		<c:when test="${loginID == null }">
                        			<div class="login-button">
                                		<button id="loginButton">로그인</button>
                            		</div>
                            		<div class="login-txt">
                                		<a href="/goToIdSearch.members">아이디찾기</a> | 
                                		<a href="/goToPwSearch.members">비밀번호찾기</a> | 
                                		<a href="/goToSignUp.members">회원가입</a>
                            		</div>
                        		</c:when>
                            	<c:otherwise>
                            		<div id="profile">
										<div id="user" class="p-2" style="display: flex;">
											<div id="userIcon" style="font-size: 3rem">
												<i class="fa-solid fa-user"></i>
											</div>
											<div class="mt-3 mx-4">
												<div id="user">${loginID}</div>
												<div id="email">${email}</div>
											</div>

											<div class="mt-3" style="cursor: pointer;"
												onclick="window.location.href='/logout.members';">
												<div class="d-flex border p-2"
													style="width: 120px; border-radius: 20px; align-items: center;">
													<div>로그아웃</div>
													<img src="/UI_img/log-out.svg" style="margin-left: 5px;">
												</div>
											</div>
										</div>
										<div style="text-align:center;margin-bottom:10px; border-top:1px solid gainsboro;"><a href="/mypage.members">마이페이지</a></div>
										
									</div>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="rnk-board">
                            <div class="rnk-txt"><a href="/board/rankingBoard.jsp">나의 랭킹 ></a> </div>
                            <div class="rnk-board-contents">
                                <table class="table">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">game_name</th>
											<th scope="col">score</th>
											<th scope="col">rank_date</th>
										</tr>
									</thead>
									<tbody class="table-group-divider" id="rankList">

									</tbody>
								</table>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
	<script>
		$(document).ready(function() {
			$("#main-header").load("/commons_ui/header.html");
		});
		$(document).ready(function() {
			$("#loginButton").on("click", function() {
				location.href = "/goToLogin.members";
			})
		});

		$(document).ready(function() {
			$("#footer_container").load("../commons/footer.html")
		});

		// 최근 게시물
		$.ajax({
			type : "POST",
			url : "/indexList.board",
			dataType : "json",
		}).done(
				function(resp) {
					try {
						var parsedData = resp;
						// 성공적으로 서버로부터 데이터를 받았을 때 실행되는 부분
						var $tableBody = $("#tableBody");

						if (parsedData.length > 0) {
							// 데이터가 존재하는 경우
							for (var i = 0; i < parsedData.length; i++) {
								var fiveList = parsedData[i];

								var $row = $("<tr>");
								$row.append($("<td>").text(fiveList.seq), 
								$("<td>").text(fiveList.game_name).css("text-align","center"), 
								$("<td>").text(fiveList.title).css("text-align","center"), 
								$("<td>").text(fiveList.view_count).css("text-align","center"), 
								$("<td>").text(fiveList.writer).css("text-align","center"), 
								$("<td>").text(fiveList.write_date)).css("text-align","center");
								$tableBody.append($row);
							}
						}
					} catch (error) {
						console.error("JSON 파싱 오류:", error);
					}
				}).fail(function(xhr, status, error) {
			console.error("요청 실패:", status, error);
		});
		// 내 랭킹
		$.ajax({
			type : "POST",
			url : "/myRankGames.rankBoard",
			dataType : "json",
		}).done(
				function(resp) {
					try {
						var parsedData = resp;
						// 성공적으로 서버로부터 데이터를 받았을 때 실행되는 부분
						var $rankList = $("#rankList");

						if (parsedData.length > 0) {
							// 데이터가 존재하는 경우
							for (var i = 0; i < parsedData.length; i++) {
								var myRank = parsedData[i];

								var $row = $("<tr>");
								$row.append($("<td>").text(myRank.ranking), $(
										"<td>").text(myRank.game_name), $(
										"<td>").text(myRank.score), $("<td>")
										.text(myRank.rank_date));
								$rankList.append($row);
							}
						}
					} catch (error) {
						console.error("JSON 파싱 오류:", error);
					}
				}).fail(function(xhr, status, error) {
			console.error("요청 실패:", status, error);
		});
	</script>


</body>
</html>