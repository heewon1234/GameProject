<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board Contentes</title>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
				integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
				crossorigin="anonymous">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ui_css/boardContents_css.css">

</head>
<body>
	<div class="container header pt-5 p-0">
		<div class="row p-0 m-0 header" id="main-header"></div>
		<hr>
		<div class="board-txt-top">자유게시판</div>
		<form>
			<div class="board-border row">
				<div class="board-title col-md-11 p-0">
					<input value="${dto.title}" readonly>
				</div>
				<div class="game-select col-md-1 d-flex justify-content-end">
					<c:if test="${loginID eq dto.writer }">
						<button id="delBtn" type="button">삭제</button>
						<div style="display:none;" id="board-seq">${dto.seq }</div>
					</c:if>
				</div>
				<div class="board-info col-md-11 p-0">
					<input type="text" value="글 번호 : ${dto.seq}" readonly> | 
					<input type="text" value="작성자 : ${dto.writer}" readonly> | 
					<input type="text" value="작성일 : ${dto.write_date}" readonly> | 
					<input type="text" value="조회수 : ${dto.view_count}" readonly> | 
					<input type="text" value="카테고리 : ${dto.game_name}" readonly>
				</div>
				<div class="board-contents" style="overflow:scroll;">
					${dto.contents}
				</div>
				<div class="btns">
					<button id="backBtn" type="button">뒤로가기</button>
					<c:if test="${loginID eq dto.writer }">
						<button id="edit" type="button">수정</button>
					</c:if>

				</div>
			</div>
		</form>

		<hr>
		<form action="/insert.reply" id="replyInsertForm">
			<div class="reply">
				<div class="replyWriter">${loginID}</div>
				<div class="replyContents">
					<input type="hidden" value="${dto.seq }" name="seq">
					<textarea placeholder="내용을 입력해주세요" name="contentsReply" id="contentsReply"></textarea>
				</div>
				<div class="insertReply">
					<button>등록</button>
				</div>
			</div>
		</form>

		<div id="replyListContainer">
			<c:choose>
				<c:when test="${replyCount>0 }">
					<form action="/update.reply" method="post" id="replyForm"></form>
					<div id="replyFooter"></div>
				</c:when>
				<c:otherwise>
                    댓글이 없습니다.
                </c:otherwise>
			</c:choose>

		</div>


	</div>

	<script>
	$(document).ready(function() {
		$("#main-header").load("/commons_ui/header.html");
	});
	
	$(document).ready(function() {
		let updateSuccess = true;
		
		$("#replyInsertForm").submit(function(){
			if($("#contentsReply").val()==""){
				$("#contentsReply").focus();
				alert("내용을 입력해주세요");
				return false;
			}
		});
		
		$("#backBtn").on("click", function() {
			location.href = "/list.board?cPage=${latestPage}";
		});

		$("#edit").on("click", function() {
			location.href = "/goToEdit.board?seq=${dto.seq}";

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
					replyHeader.addClass("replyHeader");
					replyHeader.append(resp[i].writer);
					$(replies).append(replyHeader);
					
					let replyWrite_date = $("<div>");
					replyWrite_date.append(resp[i].write_date);
					replyWrite_date.addClass("replyWrite_date");
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