<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<style>
		.container{
			margin:auto;
			border:1px solid gainsboro;
			height:180px;
			width:250px;
		}
		.text{
			display:flex;
			align-items: center;
			justify-content: center;
			height:70%;
			font-weight:bold;
			font-size:large;
		}
		.btns{
			display:flex;
			align-items: center;
			justify-content: space-evenly;
			height:30%;
		}
		.btns>button{
			width:50px;
			height:30px;
			border:1px solid gainsboro;
			margin-bottom:30px;
		}
		.btns>button{cursor:pointer;}
	</style>
</head>
<body>
	<div class="container">
		<div class="text">
			정말 삭제하시겠습니까?
		</div>
		<hr>
		<div class="btns">
			<button id="delContentsBtn">삭제</button>
			<button id="cancelBtn">취소</button>
		</div>
	</div>
	<script>
		console.log(opener.document.getElementById('parent_seq').value, opener.document.getElementById('replyPage').value);
		$("#cancelBtn").on("click",function(){
			window.close();
		});
		$("#delContentsBtn").on("click",function(){
			let seq = opener.document.getElementById('seqInput').value;
			let parent_seq = opener.document.getElementById('parent_seq').value;
			let currentReplyPage = opener.document.getElementById('replyPage').value;
			opener.location.href="/delete.reply?seq="+seq+"&parent_seq="+parent_seq+"&currentReplyPage="+currentReplyPage;
			window.close();
		});
	</script>
</body>
</html>