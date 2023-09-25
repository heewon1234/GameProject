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
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
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
							<img src="/UI_img/marvlestudio.jpg">
						</div>
						<div class="col-md-2 p-0">
							<div class="d-flex align-items-center justify-content-center"
								style="height: 40px; width: 150px; border-radius: 5px; background-color: #D2DAFF; margin-top: 2.4%">
								<i class="fas fa-gamepad me-2 mx-2" style="font-size: 1.5rem;"></i>
								<select class="form-select" aria-label="Default select example"
									style="max-width: 120px; background-color: #D2DAFF; width: 100%;">
									<option selected>Game</option>
									<option value="1">1.지뢰찾기</option>
									<option value="2">2.바운스볼</option>
									<option value="3">3.플래피버드</option>
									<option value="4">4.풀문보트</option>
									<option value="5">5.드래곤플라이트</option>
									<option value="6">6.컬러블라인드</option>
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
						<li class="nav-item"><a class="nav-link"
							href="/members/myPage.jsp">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/board/gameBoard.jsp">게임</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/list.board">자유게시판</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/board/rankingBoard.jsp">랭킹게시판</a></li>
					</ul>
				</div>
				<div id="bottom" class="p-3 mt-2">
					<div id="title" style="color: white;">자유 게시판 ></div>
					<!-- DB에서 가져와야함 ( title )-->
					<div class="p-2 mt-2" style="background-color: white;">
						<h5>${dto.title }</h5>
					</div>
					<div style="display:none;" id="board-seq">${dto.seq }</div>
					<!-- DB에서 가져와야함 ( user, write_date )-->
					<div id="user" class="p-2" style="display: flex;">
						<div id="userIcon" style="font-size: 3rem">
							<i class="fa-solid fa-user"></i>
						</div>
						<div class="mt-3 mx-4">
							<div id="writer">${dto.writer }</div>
							<div id="write_date">${dto.write_date }</div>
						</div>
					</div>
					<hr>
					<div class="mb-2">
						<h6>${dto.contents }</h6>
					</div>
					<div class="mb-2">
						<c:if test="${loginID eq dto.writer }">
							<button id="backBtn">뒤로가기</button>
							<button id="edit">수정하기</button>
							<button id="delBtn">삭제</button>
						</c:if>

					</div>
					<hr>
					<!-- reply -->
					<div>
						<h6>Reply contents</h6>
					</div>
					<h6>댓글</h6>
					<div class="commendBox p-2"
						style="border: 1px solid #d3d3d3; border-radius: 8px">
						<div class="nickName mb-1">
							<input type="text" id="loginID"
								style="width: 15vw; border: none;" value="${loginID }" readonly>
						</div>
						<form action="/insert.reply">
							<input type="hidden" id="seq" name="seq" value="${dto.seq}">
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
						<div id="replyListContainer">
							<c:choose>
								<c:when test="${replyCount>0 }">
									<form action="/update.reply" method="post" id="replyForm">

									</form>
									<div id="replyFooter"></div>
								</c:when>
								<c:otherwise>
										댓글이 없습니다.
									</c:otherwise>
							</c:choose>
							
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer" class="pt-4">footer</div>
	</div>

	<script>
	$(document).ready(function() {
		let updateSuccess = true;

		$("#backBtn").on("click", function() {
			location.href = "/list.board?currentPage=${latestPageNum}";
		});

		$("#edit").on("click", function() {
			location.href = "/updateList.board?seq=${dto.seq}";

		});
		
		$("#delBtn").on("click",function() {
			window.open("/board/isDelContents.jsp", "","width=300,height=200");
		});
		
		$(function(){
			$.ajax({
				url:"/list.reply?parent_seq=${dto.seq}",
				dataType:"json"
			}).done(function(resp){
				for(let i=0;i<resp.length;i++){

					let replies = $("<div>");
					replies.addClass("replies");
					
					let replyHeader = $("<div>");
					replyHeader.append(resp[i].writer);
					$(replies).append(replyHeader);
					
					let replyWrite_date = $("<div>");
					replyWrite_date.append(resp[i].write_date);
					$(replies).append(replyWrite_date);
					
					let replyBody = $("<div>");
					replyBody.addClass("reply-body");
					replyBody.append(resp[i].contents);
					$(replies).append(replyBody);
					
					let replyBtns = $("<div>");
					replyBtns.addClass("reply-btns");

					if(resp[i].writer == "${loginID}"){
	
						let deleteReply = $("<button>");
						deleteReply.addClass("deleteReply");
						deleteReply.attr("type","button");
						deleteReply.attr("seq",resp[i].seq);
						deleteReply.attr("parent_seq",resp[i].parent_seq);
						deleteReply.append("삭제");
						$(replyBtns).append(deleteReply);
						
						let updateReply = $("<button>");
						updateReply.addClass("updateReply");
						updateReply.attr("type","button");
						updateReply.append("수정");
						$(replyBtns).append(updateReply);
					}

					let cancelReply = $("<button>");
					cancelReply.addClass("cancelReply");
					cancelReply.attr("type","button");
					cancelReply.append("취소");
					cancelReply.css("display","none");
					$(replyBtns).append(cancelReply);
					
					let seqInput = $("<input>");
					seqInput.val(resp[i].seq);
					seqInput.attr("name","seq");
					seqInput.attr("type","hidden");
					seqInput.addClass("seqInput");
					$(replyBtns).append(seqInput);
					
					let parentInput = $("<input>");
					parentInput.val(resp[i].parent_seq);
					parentInput.attr("name","parent_seq");
					parentInput.attr("type","hidden");
					parentInput.addClass("parentInput");
					$(replyBtns).append(parentInput);
					
					let replyPageInput = $("<input>");
					replyPageInput.val(${currentReplyPage});
					replyPageInput.attr("name","currentReplyPage");
					replyPageInput.attr("type","hidden");
					replyPageInput.addClass("replyPageInput");
					$(replyBtns).append(replyPageInput);
					
					let completeReply = $("<button>");
					completeReply.addClass("completeReply");
					completeReply.css("display","none");
					completeReply.append("수정완료");
					$(replyBtns).append(completeReply);
					
					$(replies).append(replyBtns);
					
					$("#replyForm").append(replies);
					let hr = $("<hr>");
					
					$("#replyForm").append(hr);

				}
				$(".deleteReply").on("click",function(){
					$(this).siblings(".seqInput").attr("id","seqInput");
					$(this).siblings(".parentInput").attr("id","parent_seq");
					$(this).siblings(".replyPageInput").attr("id","replyPage");
					window.open("/reply/isDelReply.jsp","","width=300,height=200");
					
				});
				$(".cancelReply").on("click",function(){
					location.reload();
				});
				
				$(".updateReply").on("click",function() {
					
					if(!updateSuccess){
						alert("댓글 수정완료 하고 눌러주세요");
						return;
					}

					updateSuccess = false;
					let value = $(this).parent(".reply-btns").siblings(".reply-body").html().trim();
					$(this).parent(".reply-btns").siblings(".reply-body").html("");
					let contentsInput = $("<input>");
					contentsInput.attr("name", "contents");
					contentsInput.attr("value", value);
					contentsInput.addClass("input");
					$(this).parent(".reply-btns").siblings(".reply-body").append(contentsInput);
					$(this).css("display", "none");
					$(this).siblings(".deleteReply").css("display","none");
					$(this).siblings(".cancelReply").css("display","inline");
					$(this).siblings(".completeReply").css("display","inline");
					
				});
				
			});
		});
		
		
		
		let replyFooter = document.getElementById("replyFooter");
		let recordTotalCount = ${recordTotalCount};
		let recordCountPerPage = ${recordCountPerPage};
		let naviCountPerPage = ${naviCountPerPage};
		let currentReplyPage = ${currentReplyPage};
		
		let pageTotalCount = 0;

		if((recordTotalCount%recordCountPerPage)>0){
			pageTotalCount = Math.floor( recordTotalCount/recordCountPerPage ) + 1;
		} else {
			pageTotalCount =  recordTotalCount/ recordCountPerPage;
		}
		console.log(recordTotalCount, recordCountPerPage, naviCountPerPage, currentReplyPage)
		if(currentReplyPage<1){currenReplyPage=1;}
		else if(currentReplyPage>pageTotalCount){currentReplyPage=pageTotalCount;}
		
		let startNavi = Math.floor(( currentReplyPage - 1 ) / naviCountPerPage) * naviCountPerPage + 1;
		let endNavi = startNavi + naviCountPerPage - 1;
		if(endNavi > pageTotalCount) {endNavi = pageTotalCount;}
		console.log(currentReplyPage);
		console.log(Math.floor(( currentReplyPage - 1 )));
		let needPrev = true;
		let needNext = true;
		
		if( startNavi == 1 ) { needPrev=false; }
		if( endNavi == pageTotalCount ) { needNext = false; }
		
		if(needPrev) {
			$("#replyFooter").append("<a href='/showContents.board?currentReplyPage="+(startNavi-1)+"&seq=${dto.seq}'>"+ "<<"+ "</a>");
		}
		for(let i = startNavi; i<=endNavi; i++) {
			$("#replyFooter").append("<a href='/showContents.board?currentReplyPage="+ i +"&seq=${dto.seq}' class='naviNum'>" + i + "</a>");
		}
		if(needNext) {$("#replyFooter").append("<a href='/showContents.board?currentReplyPage="+(endNavi+1)+"&seq=${dto.seq}'>"+ ">>"+ "</a>");}
		
		let childNum = currentReplyPage;
		if(childNum>10){childNum = childNum-9;}
		$(".naviNum:nth-child("+childNum+")").css("color","red").css("text-decoration","underline");
	});
	</script>
</body>
</html>