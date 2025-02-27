<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비</title>
<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

	* {
		font-family: "Nanum Gothic", sans-serif;
		margin: 0;
		padding: 0;
	}
	
	iframe {
		margin: auto;
	}
	
	
	#wrap {
		width: 1400px;
		margin: 0 auto;
		margin-top:50px;
	}
	
	.movieTrail {
		width: 1000px;
		max-width: 100%; 
		margin: 0 auto;
	}
	
	#movieTrail{
		margin: auto;
	}
	
	.end-message {
		display: none;
	}
	
	section {
		width: 100%;
		height: 1100px;
	}
	
	section h1 {
		position: relative;
		text-align: center; /* 가운데 정렬 */
		font-size: 32px; /* 폰트 크기 수정 */
		width: 100%; /* 너비 조정 */
		white-space: nowrap;
	}
	
	.nowMovie {
		width: 100%;
		height: 100px;
		display: flex;
		justify-content: center; /* 수평 가운데 정렬 */
		align-items: center;
	}
	
	.nowMovie .btn {
		white-space: nowrap;
	}
	
	.list {
		width: 1350px;
		margin-top: 50px;
		margin-bottom: 50px;
		text-align: center;
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
		overflow: hidden;
	}
	
	.movie img {
		margin: auto;
		margin-top: 20px;
		margin-bottom: 10px;
		width: 240px;
		height: 360px;
		display: flex;
	}
	
	.more {
		margin: 15px;
		text-align: center;
	}
	
	.more .btn {
		font-size: 25px;
	}
	
	.nowMovie>form>input[type=text] {
		height: 40px;
		width: 200px;
		outline: none;
		vertical-align: middle;
		margin-left: 150px;
	}
	
	.nowMovie>form>input[type=submit] {
		width: 90px;
		height: 40px;
		outline: none;
		font-weight: bold;
		margin-left: 5px;
		vertical-align: middle;
		padding: 0px;
	}
	
	footer{
		margin-top: 50px;
	}
</style>

<%-- <link href="${pageContext.request.contextPath}/resources/css/movie.css"	rel="stylesheet" type="text/css"> --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<div id="wrap">
		
		<section>
			<h2>부기무비 영화</h2>
			<hr>
			<div class="nowMovie">
				<button type="button" class="btn btn-outline-primary" onclick="window.location.href='movie'">현재 상영작</button>
				<button type="button" class="btn btn-outline-primary" onclick="window.location.href='movieFuture'">상영예정작</button>
				<button type="button" class="btn btn-outline-primary" id="boxoffice">박스오피스 순위</button>
				<button type="button" class="btn btn-outline-primary" id="recommendMovie">추천상영영화</button>
				<form action="searchMovie">
					<input type="text" name="searchKeyword" placeholder="제목을 입력해주세요" value="${param.searchKeyword}"> 
					<input type="submit" class="btn btn-dark" value="검색">
				</form>
			</div>
			<div class="list">
				<c:forEach var="movie" items="${movieInfo}" varStatus="loop"
					begin="0">
					<div class="movie">
						<img src="${movie.movie_poster}">
						<h6>${movie.movie_name}</h6>
						<input type="hidden" class="movie_num" name="movie_num"
							value="${movie.movie_num}">
						<button type="button" class="btn btn-secondary movieTicket">예매하기</button>
						<button type="button"
							class="btn btn-outline-secondary detail_button">상세보기</button>
					</div>
				</c:forEach>
			</div>
			<br>
			<div class="more">
				<button id="moreMoviesBtn" type="button" class="btn btn-warning mb-5">상영 중인 영화 더 보기</button>
				<footer>
					<jsp:include page="../inc/footer.jsp"></jsp:include>
				</footer>
			</div>
		</section>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
		
		
	<script type="text/javascript">
		$(document).ready(function() {
			
			let sId = "${sessionScope.sId}"; 
			$("#recommendMovie").on("click", function() {
				if (!sId) {
					if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
						window.location.href = 'member_login';
					}
				} else {
					if (confirm("추천 영화 페이지로 이동하시겠습니까?")) {
						window.location.href = 'recommand'; // 추천 영화 페이지로 이동
					}

				}
			});
			
			$("#boxoffice").on("click", function() {
				window.open('boxoffice', '_blank'); // 박스오피스 페이지를 새 창으로 열기
			});
			
			$(".list").on("click", ".detail_button", function() {
				let movie_num = $(this).siblings(".movie_num").val();
				window.location.href = 'movieInfo?movie_num=' + movie_num; // 영화 상세 정보 페이지로 이동
			});
			
			$(".list").on("click", ".movieTicket", function() {
				let movie_num = $(this).siblings(".movie_num").val();

				if (!sId) {
					if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
						window.location.href = 'member_login';
					}
				} else {
					if (confirm("예매 페이지로 이동하시겠습니까?")) {
						window.location.href = 'tic_ticketing'; // 예매 페이지로 이동
					}
				}
			});

			// 초기에는 8편의 영화만 표시하도록 설정
			let numShown = 12;
			$(".movie:gt(" + (numShown - 1) + ")").hide();

			// "더보기" 버튼 클릭 이벤트 처리
			$("#moreMoviesBtn").click(function() {
				numShown += 4; // 4개씩 추가로 보여주기
				$(".movie:lt(" + numShown + ")").show();

				// 섹션의 높이를 300px씩 추가
				let newHeight = $("section").height() + 300;
				$("section").height(newHeight);

				// 모든 영화를 보여주었을 경우 더보기 버튼 숨기기
				if (numShown >= $(".movie").length) {
					$("#moreMoviesBtn").hide();
				}
			});
		});
	</script>
</body>
</html>