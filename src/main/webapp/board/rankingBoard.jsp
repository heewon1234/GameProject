<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <!DOCTYPE html>
      <html>

      <head>
         <meta charset="UTF-8">
         <title>랭킹 게시판</title>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
            crossorigin="anonymous">
         <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
         <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
         <link rel="stylesheet" type="text/css" href="/ui_css/rankboard_css.css">
         <style>
.active-game {
	background-color: gainsboro;
	color: #fff;
}
</style>
      </head>

      <body>
         <div class="container header pt-5 p-0">
      <div class="row p-0 m-0 header" id="main-header"></div>
      <hr>
      <div class="board-txt-top">랭킹게시판</div>
      <div class="rnk-game-select" style="display: flex; justify-content: space-between;">
         <ul class="nav nav-pills nav-fill"
            style="width: 100%; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
            <li class="nav-item dropdown game-list"><button type="button" class="btn"
                  data-bs-toggle="dropdown" aria-expanded="false">지뢰 찾기</button>
               <ul class="dropdown-menu">
                  <li><a class="game dropdown-item" href="#"
                     data-game="minesweeperEazy">초급</a></li>
                  <li><a class="game dropdown-item" href="#"
                     data-game="minesweeperNormal">중급</a></li>
                  <li><a class="game dropdown-item" href="#"
                     data-game="minesweeperHard">고급</a></li>
               </ul>
            <li class="game nav-item game-list"><a class="nav-link" href="#"
               data-game="bounceball" style="color:black;">바운스볼</a></li>
            <li class="game nav-item game-list"><a class="nav-link" href="#"
               data-game="flappyBird" style="color:black;">플래피 버드</a></li>
            <li class="game nav-item game-list"><a class="nav-link" href="#"
               data-game="fullMoonBoat" style="color:black;">풀 문 보트</a></li>
            <li class="game nav-item game-list"><a class="nav-link" href="#"
               data-game="dragon" style="color:black;">드래곤 플라이트</a></li>
            <li class="game nav-item game-list"><a class="nav-link" href="#"
               data-game="colorblind" style="color:black;">컬러 블라인드</a></li>
         </ul>
      </div>
      <div class="board-border">
         <div class="board">
            <div class="rnk-txt">
               <나의 랭킹>
            </div>
            <table class="table">
               <thead>
                  <tr>
                     <th scope="col" class="w-10">순위</th>
                     <th scope="col" class="w-35" style="text-align: start;">게임</th>
                     <th scope="col" class="w-25">점수</th>
                     <th scope="col" class="w-25">등록시간</th>
                  </tr>
               </thead>
               <tbody class="table-group-divider" id="myTable">


               </tbody>
            </table>
         </div>
      </div>
      <div class="board-border">
         <div class="board">
            <div class="rnk-txt">
               <전체 랭킹>
            </div>
            <table class="table">
               <thead>
                  <tr>
                     <th scope="col" class="w-10">순위</th>
                     <th scope="col" class="w-35">게임</th>
                     <th scope="col" class="w-25">점수</th>
                     <th scope="col" class="w-25">닉네임</th>
                  </tr>
               </thead>
               <tbody class="table-group-divider" id="tableBody">


               </tbody>
            </table>
         </div>
      </div>
   </div>
   <div id="footer_container"></div>
         <script>
             $(document).ready(function() {
                  $("#main-header").load("/commons_ui/header.html");
              });
            $(document).ready(function () {
               // Footer를 로드
               $("#footer_container").load("/commons/footer.html");

               // 처음 랭킹 페이지 들어갔을 때 default로 지뢰찾기 초급을 보여주는 AJAX 요청
               $.ajax({
                  type: "POST",
                  url: "/list.rankBoard",
                  dataType: "json",
               })
                  .done(function (resp) {
                     try {
                        var parsedData = resp;
                        var $tableBody = $("#tableBody");

                        if (parsedData.length > 0) {
                           for (var i = 0; i < parsedData.length; i++) {
                              var gameList = parsedData[i];

                              var $row = $("<tr>");
                              $row.append(
                                 $("<td>").text(gameList.ranking),
                                 $("<td>").text(gameList.game_name),
                                 $("<td>").text(gameList.score),
                                 $("<td>").text(gameList.id)
                              );
                              $tableBody.append($row);
                           }
                        }
                     } catch (error) {
                        //console.error("JSON 파싱 오류:", error);
                     }
                  })
                  .fail(function (xhr, status, error) {
                     //console.error("요청 실패:", status, error);
                  });

               // 내 지뢰찾기 초급 랭킹을 보여주는 AJAX 요청
               $.ajax({
                  type: "POST",
                  url: "/myMines.rankBoard",
                  dataType: "json",
               })
                  .done(function (resp) {
                     try {
                        var parsedData = resp;
                        var $rankList = $("#myTable");

                        if (parsedData.length > 0) {
                           for (var i = 0; i < parsedData.length; i++) {
                              var myRank = parsedData[i];

                              var $row = $("<tr>");
                              $row.append(
                                 $("<td>").text(myRank.ranking),
                                 $("<td>").text(myRank.game_name),
                                 $("<td>").text(myRank.score),
                                 $("<td>").text(myRank.rank_date)
                              );
                              $rankList.append($row);
                           }
                        }
                     } catch (error) {
                        //console.error("JSON 파싱 오류:", error);
                     }
                  })
                  .fail(function (xhr, status, error) {
                     //console.error("요청 실패:", status, error);
                  });

               // 게임 메뉴를 클릭했을 때 해당 게임 정보를 보여주는 AJAX 요청
               $(".game.nav-item a.nav-link,.game.dropdown-item").on("click", function (event) {
                  event.preventDefault();
                  var gameName = $(this).data("game");
         
			        
                  //console.log("게임 이름:", gameName);
                  
                  $.ajax({
                     type: "POST",
                     url: "/game.rankBoard",
                     data: { game_name: gameName },
                     dataType: "json",
                  }).done(function (resp) {
                     // 서버로부터의 응답 처리
                     //console.log("게임 이름 전송 및 응답:", resp);

                     // HTML 테이블을 업데이트하기 위한 변수
                     var tableBody = $("#tableBody");

                     // 이전 데이터를 지우고 새로운 데이터로 업데이트
                     tableBody.empty();

                     // resp가 JSON 배열인지 확인
                     if (Array.isArray(resp)) {
                        // 배열을 반복하면서 테이블 행을 추가
                        resp.forEach(function (item, index) {
                           var row = $("<tr>");
                           row.append(
                              $("<td>").text(item.ranking),
                              $("<td>").text(item.game_name),
                              $("<td>").text(item.score),
                              $("<td>").text(item.id)
                           );
                           tableBody.append(row);
                        });
                     } else {
                        //console.error("서버로부터 받은 데이터가 올바른 형식이 아닙니다.");
                     }
                  }).fail(function (error) {
                     //console.error("에러 발생:", error);
                  });
                  // 해당 게임의 자신의 랭킹을 보여주는 ajax
                  $.ajax({
                     type: "POST",
                     url: "/myGame.rankBoard",
                     data: { game_name: gameName },
                     dataType: "json",
                  }).done(function (resp) {
                     // 서버로부터의 응답 처리
                     //console.log("게임 이름 전송 및 응답:", resp);

                     // HTML 테이블을 업데이트하기 위한 변수
                     var myTable = $("#myTable");

                     // 이전 데이터를 지우고 새로운 데이터로 업데이트
                     myTable.empty();

                     // resp가 JSON 배열인지 확인
                     if (Array.isArray(resp)) {
                        // 배열을 반복하면서 테이블 행을 추가
                        resp.forEach(function (item, index) {
                           var row = $("<tr>");
                           row.append(
                              $("<td>").text(item.ranking),
                              $("<td>").text(item.game_name),
                              $("<td>").text(item.score),
                              $("<td>").text(item.rank_date)
                           );
                           myTable.append(row);
                        });
                     } else {
                        //console.error("서버로부터 받은 데이터가 올바른 형식이 아닙니다.");
                     }
                  }).fail(function (error) {
                     //console.error("에러 발생:", error);
                  });


               });
               $(".game.nav-item a.nav-link").on("click", function (event) {
                   event.preventDefault();
                   
                   $(".game.nav-item a.nav-link").removeClass("active-game");
 			      $(this).addClass("active-game");
               });
            });
         </script>




      </body>

      </html>