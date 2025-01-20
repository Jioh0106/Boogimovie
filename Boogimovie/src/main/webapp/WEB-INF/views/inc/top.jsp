<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>new-top</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   <style type="text/css">
	#topnav-area {
 		background-color: #fcd308; 
	}
	
	#login-area{
		height: 20px;
		
	}
	
	#topnav {
		width: 1200px;
		margin: auto;
	}

	.nav-item .top-nav-link {
		font-size: 20px;
		font-weight: bolder;
		color: black;
		padding: 15px;
	}
	
	.nav-item .top-nav-link:hover {
/*   		background-color: #f6d787;   */
		color: #ff6300;
		border-bottom: 3px solid black;
		border-radius: 0px;
	}
    
	p a {
    	text-decoration: none;
    	color: black;
    	font-size: 14px;
    }
    
    .menubar .nav {
    	
    }
    
 
   </style>
</head>

<body>

	<div id="topnav-area" class="">
		<div id="topnav" class="">
			<!-- 로그인/로그아웃/마이페이지 -->
			<div class="row pt-3" id="login-area">
				<div class="d-flex flex-row justify-content-end ">
					<c:choose>
						<c:when test="${empty sId}">
							<p class="mx-3 " ><a href="member_login">로그인</a></p>
						</c:when>
						<c:otherwise>
							<p class="mx-3 "  ><a onclick="member_logout()" class="cursor-pointer">로그아웃</a></p> 
							<p class="mx-3" ><a onclick="location.href='myp_main'" class="cursor-pointer">마이페이지</a></p>
						</c:otherwise>
					</c:choose>
				</div>
			
				<c:if test="${empty sId}">
					<p class="mx-3" ><a href="member_pre_reg_member">회원가입</a></p>
				</c:if>
			
				<c:if test="${sId eq 'admin' or sId eq 'admin22' or sId eq 'admin33'}">
					<p class="mx-3" ><a href="admin_main">관리자페이지</a></p>
				</c:if>
			</div><!-- 로그인/로그아웃/마이페이지 -->
	      
		      <!-- 메인 로고 -->
		      <div class="row d-flex justify-content-center">
		         <img src="${pageContext.request.contextPath}/resources/images/logo/boogimovie3.png" style="width: 400px;" onclick="location.href='./'">
		      </div>
	      
	      	<!-- 네비바  -->
	     	 <div class="row mt-3 menubar" align="center">
				<ul class="nav nav-pills nav-fill">
					<li class="nav-item">
						<a class="nav-link top-nav-link" href="movie">영화</a>
					</li>
					<li class="nav-item">
						<a class="nav-link top-nav-link" href="tic_ticketing">예매</a>
					</li>
					<li class="nav-item">
						<a class="nav-link top-nav-link" href="theater">극장</a>
					</li>
					<li class="nav-item">
						<a class="nav-link top-nav-link"  href="store">스토어</a>
					</li>
					<li class="nav-item">
						<a class="nav-link top-nav-link" href="event">이벤트</a>
					</li>
					<li class="nav-item">
						<a class="nav-link top-nav-link" href="csc_main">고객센터</a>
					</li>
				</ul>
	      
			</div>
		</div>
	</div>
   
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>