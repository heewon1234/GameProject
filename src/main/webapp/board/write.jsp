<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

 <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


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
                           <option value="MineSweeper">1.지뢰찾기</option>
                           <option value="BounceBall">2.바운스볼</option>
                           <option value="FlappyBird">3.플래피버드</option>
                           <option value="FullMoonBoat">4.풀문보트</option>
                           <option value="Dragon">5.드래곤플라이트</option>
                           <option value="ColorBlind">6.컬러블라인드</option>
                        </select>
                     </div>
                  </div>
                  <div
                     class="col-md-8 ml-auto d-flex align-items-center justify-content-end p-0">
                     <a class="nav-link" href="#"><img src="/UI_img/log-out.svg"></a>
                  </div>
               </div>
            </div>
         </div>
         <div style="background-color: #C9CFFF; height: 10px"></div>
      </div>
      <div class="container-fluid p-0" style="background-color: #EEF1FF;">
         <div id="body" class="container p-0">
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
                     href="/board/freeboard.jsp">자유게시판</a></li>
                  <li class="nav-item"><a class="nav-link"
                     href="/board/rankingBoard.jsp">랭킹게시판</a></li>
               </ul>
            </div>

            <form class="d-flex" role="search" action="/insert.board"
               method="post" enctype="multipart/form-data" id="frm">
               <div id="bottom" class="p-3 mt-2 " style="width: 100%;">
                  <div
                     style="background-color: white; border-radius: 5px; display: flex; align-items: center; width: 100%;">
                     <div class="p-2" style="width: 93%; font-size: 2.5rem">글쓰기</div>

                     <button class="btn btn-outline-success" type="submit"
                        style="justify-content: flex-end;">등록</button>
                  </div>
                  <div class="mt-4" style="display: flex; align-items: center;">
                     <select class="form-select" aria-label="Default select example"
                        style="max-width: 200px" name="game_name" id="selectBox">
                        <option selected>게임선택</option>
                        <option value="MineSweeper">1.지뢰찾기</option>
                        <option value="BounceBall">2.바운스볼</option>
                        <option value="FlappyBird">3.플래피버드</option>
                        <option value="FullMoonBoat">4.풀문보트</option>
                        <option value="Dragon">5.드래곤플라이트</option>
                        <option value="ColorBlind">6.컬러블라인드</option>
                     </select>
                  </div>
                  <div class="mt-4" style="align-items: center;">
                     <input class="form-control me-2" type="search"
                        placeholder="제목을 입력해주세요." aria-label="Search"
                        style="width: 100%" name="title" id="board-title">
                  </div>
                  <div class="mt-4">
                     <textarea id="summernote" name="contents" id="board-contents"></textarea>
                  </div>
               </div>
            </form>

         </div>
      </div>
      <div id="footer" class="pt-4">footer</div>
   </div>

   <script>
      $(document)
            .ready(
                  function() {
                     $('#summernote')
                           .summernote(
                                 {
                                    placeholder : '내용을 입력해주세요.',
                                    tabsize : 2,
                                    height : 400,
                                    callbacks : {
                                       onImageUpload : function(
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
                                                         url : "/upload.file",
                                                         method : "post",
                                                         data : formData,
                                                         processData : false, // 인코딩 처리 금지 ( processData, contentType : false = multipart/form-data)
                                                         contentType : false, // 파일 타입 그대로 유지
                                                      })
                                                .done(
                                                      function(
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

                     $("#frm").submit(function() {
                        if ($("#selectBox").val() == "게임선택") {
                           alert("게임 카테고리를 선택해주세요");
                           return false;
                        }

                        if ($("#board-title").val() == "") {
                           alert("제목을 입력해주세요");
                           $("#title").focus();
                           return false
                        }

                        if ($("#board-contents").val() == "") {
                           alert("내용을 입력해주세요");
                           $("#contents").focus();
                           return false();
                        }
                     });

                  });
   </script>


</body>

</html>