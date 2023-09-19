<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>회원 탈퇴</title>
        <!-- JQuery CDN -->
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
        <style>
            body {
                padding-top: 60px;
            }

            a {
                text-decoration-line: none;
                color: black;
            }
        </style>
    </head>

    <body>
        <div class="container border">
            <div class="row">
                <!-- 사이드바 -->
                <div class="col-md-3">
                    <div class="panel panel-info">
                        <div class="panel-heading" align="center">
                            <h3>
                                ${mypageList.id}
                            </h3>
                            ${mypageList.email1}@${mypageList.email2}
                        </div>
                    </div>
                    <hr>
                    <div class="panel panel-info">
                        <ul class="list-group">
                            <li class="list-group-item"><a href="./myPage.jsp">내프로필</a></li>
                            <li class="list-group-item"><a href="#">랭킹</a></li>
                            <li class="list-group-item"><a href="./deleteAccount.jsp">회원탈퇴</a></li>
                        </ul>
                    </div>
                    <hr>
                </div>
                <div class="col-md-9 border" style="padding: 20px; display: flex; align-items: center;">
                    <form action="/delete.members" class="row g-3 needs-validation" id="deleteAccount_form"
                        method="post">
                        <div class="mb-3 row">
                            <label for="password" class="col-sm-3 col-form-label">Password</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control update_list" id="password" name="password">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="verifyPassword" class="col-sm-3 col-form-label">Password 재입력</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control update_list" id="verifyPassword"
                                    name="verifyPassword">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-sm-12" style="text-align: right;">
                                <input type="submit" class="btn btn-primary" id="delete_btn" value="회원탈퇴">
                                <input type="button" class="btn btn-primary" id="return_btn" value="뒤로가기">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>

            // 회원탈퇴 버튼 클릭
            $("#delete_btn").on("click", function () {
                let con_result = confirm("정말로 회원 탈퇴 하시겠습니까?");

                if (con_result == true) {

                } else {

                }
            });

            // 뒤로가기 버튼 클릭
            $("#return_btn").on("click", function () {
                location.href = "/index.jsp";
            });
        </script>
    </body>

    </html>