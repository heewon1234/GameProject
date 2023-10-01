<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>자유 게시판</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/ui_css/write_css.css">


		</head>
	
		<div class="container header pt-5 p-0">
		<div class="row p-0 m-0 header" id="main-header"></div>
		<hr>
		<div class="board-txt-top">글쓰기</div>
		<form id="frm" action="/update.board" method="post" enctype="multipart/form-data">
			<div class="board-border row">
				<div class="board-title col-md-10 p-0">
					<input type="hidden" value="${contentsList.seq}" name="seq">
					<input type="text" placeholder="제목을 입력하세요" name="title" id="board-title" value="${contentsList.title}">
				</div>
				<div class="game-select col-md-2 d-flex justify-content-end">
					<select name="game_name" id="selectBox">
						<option>게임 선택</option>
						<option value="MineSweeper" ${contentsList.game_name == 'MineSweeper' ? 'selected' : ''}>지뢰찾기</option>
						<option value="BounceBall" ${contentsList.game_name == 'BounceBall' ? 'selected' : ''}>바운스볼</option>
						<option value="FlappyBird" ${contentsList.game_name == 'FlappyBird' ? 'selected' : ''}>플래피버드</option>
						<option value="FullMoonBoat" ${contentsList.game_name == 'FullMoonBoat' ? 'selected' : ''}>풀문보트</option>
						<option value="Dragon" ${contentsList.game_name == 'Dragon' ? 'selected' : ''}>드래곤플라이트</option>
						<option value="ColorBlind" ${contentsList.game_name == 'ColorBlind' ? 'selected' : ''}>컬러블라인드</option>
					</select>
				</div>
				<div class="board-contents">
					<textarea id="summernote" name="contents" id="board-contents">${contentsList.contents}</textarea>
				</div>
				<div class="btns">
					<button id="cancelBtn" type="button">취소</button>
					<button>등록</button>
				</div>
			</div>
		</form>
	</div>

			<script>
			$(document).ready(function() {
				$("#main-header").load("/commons_ui/header.html");
			});
				$(document).ready(// //
						function () {
							$('#summernote')
								.summernote(
									{
										placeholder: '내용을 입력해주세요.',
										tabsize: 2,
										height: 400,
										callbacks: {
											onImageUpload: function (
												files) {

												let formData = new FormData(); // 폼 태그 인스턴스 생성 ( 텅 비어있음 )
												for (let i = 0; i < files.length; i++) {
													formData
														.append(
															"image"
															+ i,
															files[i]);
												}
												let input = $("<input>");
												input.attr("type",
													"file");
												input.attr("name",
													"file");
												input.css("display",
													"none");
												input[0].files = files;
												$("#frm").append(input);
												//formData.append("image",files[0]); // input type=file 넣기

												$
													.ajax(
														{
															url: "/upload.file",
															method: "post",
															data: formData,
															processData: false, // 인코딩 처리 금지 ( processData, contentType : false = multipart/form-data)
															contentType: false, // 파일 타입 그대로 유지
														})
													.done(
														function (
															resp) {
															for (let i = 0; i < files.length; i++) {
																let img = $("<img>");
																img
																	.attr(
																		"src",
																		"/files"
																		+ resp
																			.split("/files")[i + 1]);
																img
																	.attr(
																		"type",
																		"file")
																$(
																	"#summernote")
																	.summernote(
																		'insertNode',
																		img[0]);
																let paragraph = $("<p><br></p>");
																$(
																	"#summernote")
																	.summernote(
																		'insertNode',
																		paragraph[0]);
															}

														})

											}
										}

									});
							
							$("#frm").submit(function () {
								if ($("#selectBox").val() == "게임 선택") {
									alert("게임 카테고리를 선택해주세요");
									return false;
								}

								if ($("#board-title").val() == "") {
									alert("제목을 입력해주세요");
									$("#title").focus();
									return false
								}

								if ($("#summernote").val() == "") {
									alert("내용을 입력해주세요");
									$("#contents").focus();
									return false;
								}
							});
							
							$("#cancelBtn").on("click",function(){
								location.href="/showContents.board?seq=${contentsList.seq}";
							})

						});
			</script>


		</body>

		</html>