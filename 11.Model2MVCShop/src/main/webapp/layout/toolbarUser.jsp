<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">

	<div class="container">

		<a class="navbar-brand" href="/index.jsp">Doyoun Shop</a>

		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse"
				data-target="#target">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
		<div class="collapse navbar-collapse navbar-right" id="target">
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${ empty user }">
				<li><a href="#">회원가입</a></li>
				</c:if>
				
				<!-- <li><a href="#">로 그 인</a></li> -->
				<li><a href="#">${ !empty user ? "로그아웃" : "로그인" }</a></li>
			</ul>
		</div>
		
	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->



<script type="text/javascript">
	
	function cookieRemove() {
		
	    // 변수를 선언한다.
	    var date = new Date();
	    date.setDate(date.getDate() - 1);
	
	    var willCookie = "";
	    willCookie += "CookieName=Value;";
	    willCookie += "Expires=" + date.toUTCString();
	
	    // 쿠키를 집어넣는다.
	    document.cookie = willCookie;
	}
	//============= 회원원가입 화면이동 =============
	$(function() {
		//==> 추가된부분 : "addUser"  Event 연결
		$("a[href='#' ]:contains('회원가입')").on("click", function() {
			self.location = "/user/addUser"
		});
	});

	//============= 로그인 화면이동 =============
	$(function() {
		
		//==> 추가된부분 : "login"  Event 연결
		$("a[href='#' ]:contains('로그인')").on("click", function() {
			self.location = "/user/login"
		});

		//==> 추가된 부분 : "logout" Event 연결
		$("a[href='#']:contains('로그아웃')").on("click", function() {
			cookieRemove();
			self.location = "/user/logout";
		});
	});
</script>
