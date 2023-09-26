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
			<link rel="stylesheet" type="text/css" href="/ui_css/freeboard_css.css">
		</head>

		<body>
			<div class="container header pt-5 p-0">
        <div class="row p-0 m-0 header" id="main-header">
            
        </div>
        <hr>
        <div class="board-txt-top">
            자유게시판
            <form action="/list.board">
                <input type="text" placeholder="search" name="keyword" id="input_search">
                <button id="btn_search">search</button>
            </form>
        </div>

        <div class="board-border">
            <div class="board">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col" style="width: 40px; text-align: center">번호</th>
                            <th scope="col" style="width: 80px; text-align: center">카테고리</th>
                            <th scope="col" style="width: 400px; text-align: center">제목</th>
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
                                <td style="text-align: center"><a href="showContents.board?seq=${list.seq }" class="board-list-title">${list.title}</a></td>
                                <td style="text-align: center">${list.view_count}</td>
                                <td style="text-align: center">${list.writer}</td>
                                <td style="text-align: center">${list.timestampToString}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="6" style="text-align: right;">
                                <input type="button" class="btn btn-primary" id="write_btn" value="작성하기"> 
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="d-flex justify-content-center" id="navi"></div>
            </div>
        </div>

    </div>
			<script>
			$(document).ready(function() {
				$("#main-header").load("/commons_ui/header.html");
			});
			
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