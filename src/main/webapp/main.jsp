<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<style>
#head {
	background-color: #A6E3E9
}

#body {
	background-color: #BCCEF8
}

#footer {
	background-color: #A6E3E9
}
</style>
</head>

<body>
	<div class="container-fluid p-0" style="background-color:#CBF1F5;">
		<div id="head">
			<div>
				<div class="container">
					<div class="row">
						<div class="col-md-2"><img src="marvlestudio.jpg"></div>
						<div class="col-md-2 d-flex align-items-center">
							<i class="fas fa-gamepad me-2" style="font-size: 1.5rem;"></i> <select class="form-select"
								aria-label="Default select example"
								style="max-width: 120px; background-color: #CBF1F5;">
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
				</div>

			</div>
			<div style="background-color: #CBF1F5; height: 30px "></div>
		</div>
		<div class="container-fluid p-0" style="background-color:#E3FDFD;">
			<div id="body" class="container">
				<div id="titleImg">
					<div id="carouselExampleSlidesOnly" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="어벤져스.jpg" class="d-block w-100" alt="..."
									style="max-height: 350px;">
							</div>
							<div class="carousel-item">
								<img src="어벤져스.jpg" class="d-block w-100" alt="..."
									style="max-height: 350px;">
							</div>
							<div class="carousel-item">
								<img src="어벤져스.jpg" class="d-block w-100" alt="..."
									style="max-height: 350px;">
							</div>
						</div>
					</div>
				</div>
				<div id="contents" class="row">
					<div id="left" class="col-8 pt-4">
						<div class="container">
							<div id="top"
								style="border: 2px solid #000; border-radius:15px; padding: 40px; background-color: #98A8F8;">
								<div>
									<h5 style="color: white">게임선택</h5>
								</div>
								<div class="row row-cols-2 row-cols-lg-3 g-2 g-lg-3 text-center">
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임1</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임2</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임3</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임4</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임5</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="캡틴.jpg" class="figure-img img-fluid rounded"
													alt="...">
												<figcaption class="figure-caption text-center">게임6</figcaption>
											</figure>
										</div>
									</div>
								</div>
							</div>
							<div id="bottom"
								style="border: 2px solid #000; border-radius:15px; padding: 40px; background-color: #98A8F8;"
								class="mt-4">
								<div>
									<h5 style="color: white">최근 게시물 ></h5>
								</div>
								<table class="table mt-4">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">First</th>
											<th scope="col">Last</th>
											<th scope="col">Handle</th>
										</tr>
									</thead>
									<tbody class="table-group-divider">
										<tr>
											<th scope="row">1</th>
											<td>Mark</td>
											<td>Otto</td>
											<td>@mdo</td>
										</tr>
										<tr>
											<th scope="row">2</th>
											<td>Jacob</td>
											<td>Thornton</td>
											<td>@fat</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div id="right" class="col-4 pt-4">
						<div class="container">
							<div id="login"
								style="border: 2px solid #000; border-radius:15px; padding: 40px; padding-top:60px; background-color: #98A8F8;">
								<div class="mb-3" style="text-align: center">
									<h5>로그인 해주세요!!</h5>
								</div>
								<div class="row mb-3">
									<button type="submit" class="btn btn-primary ">로그인</button>
								</div>
								<div class="row mb-3">
									<ul class="nav justify-content-center" style="font-size: 1rem;">
										<li class="nav-item"><a class="nav-link active p-2"
											aria-current="page" style="color: white" href="#">비밀번호 찾기</a></li>
										<li class="nav-item"><a class="nav-link p-2" style="color: white" href="#">아이디
												찾기</a></li>
										<li class="nav-item"><a class="nav-link p-2" style="color: white" href="#">회원가입</a></li>
									</ul>
								</div>
							</div>
							<div id="ranking" class="mt-4"
								style="border: 2px solid #000; border-radius:15px; padding: 40px; background-color: #98A8F8;">
								<h5 style="color: white">내 랭킹 ></h5>
								<table class="table mt-4">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">First</th>
											<th scope="col">Last</th>
											<th scope="col">Handle</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row">1</th>
											<td>Mark</td>
											<td>Otto</td>
											<td>@mdo</td>
										</tr>
										<tr>
											<th scope="row">2</th>
											<td>Jacob</td>
											<td>Thornton</td>
											<td>@fat</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td colspan="2">Larry the Bird</td>
											<td>@twitter</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">footer</div>

	</div>
</body>
</html>