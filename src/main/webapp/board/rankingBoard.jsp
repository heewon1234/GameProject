<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>랭킹게시판</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
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
        </style>
    </head>

    <body>
        <div class="container-fluid p-0">
            <div id="head">
                <div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 d-flex align-items-center justify-content-center">
                                <img src="/UI_img/marvlestudio.jpg">
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
                                <a class="nav-link" href="#"><img src="/UI_img/log-out.svg"></a>
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
                            <li class="nav-item"><a class="nav-link" href="/members/myPage.jsp">마이페이지</a></li>
							<li class="nav-item"><a class="nav-link" href="/board/gameBoard.jsp">게임</a></li>
							<li class="nav-item"><a class="nav-link" href="/board/freeboard.jsp">자유게시판</a></li>
							<li class="nav-item"><a class="nav-link" href="/board/rankingBoard.jsp">랭킹게시판</a></li>
                        </ul>
                    </div>



                    <div id="bottom" class="p-3 mt-2">
                        <div id="title" class="p-2"
                            style="background-color: white; display: flex; justify-content: space-between; align-items: center;">
                            <ul class="nav nav-pills nav-fill"
                                style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
                                <li class="nav-item"><a class="nav-link" href="#">게임 1</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">게임 2</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">게임 3</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">게임 4</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">게임 5</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">게임 6</a></li>
                            </ul>
                        </div>
                        <h3 style="margin-top: 20px;">내 랭킹</h3>
                        <div id="title" class="mt-4">
                            <table class="table">
                                <tbody class="table">
                                    <tr>
                                        <th scope="col" class="w-25">1위</th>
                                        <td class="w-25">3000점</td>
                                        <td class="w-25">Otto</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="contents" class="mt-4">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" class="w-25">순위</th>
                                        <th scope="col" class="w-25">점수</th>
                                        <th scope="col" class="w-25">닉네임</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>Mark</td>
                                        <td>Otto</td>

                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>Jacob</td>
                                        <td>Thornton</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">4</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">5</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">6</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">7</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">8</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">9</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">10</th>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer" class="pt-4">footer</div>
        </div>
    </body>

    </html>