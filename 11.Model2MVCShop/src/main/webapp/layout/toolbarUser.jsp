<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">

	<div class="container">

		<a class="navbar-brand" href="#">Model2 MVC Shop</a>

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

		<div class="collapse navbar-collapse" id="target">
			<ul class="nav navbar-nav navbar-right">
				
				<li><a href="#">회원가입</a></li>
				<!-- <li><a href="#">로 그 인</a></li> -->
				<li><a href="#">${ !empty user ? "로그아웃" : "로그인" }</a></li>
			</ul>
		</div>

	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->



<script type="text/javascript">
	//============= 회원원가입 화면이동 =============
	$(function() {
		//==> 추가된부분 : "addUser"  Event 연결
		$("a[href='#' ]:contains('회원가입')").on("click", function() {
			self.location = "/user/addUser"
		});
	});

	//============= 로그인 화면이동 =============
	$(function() {
		function history(){
			popWin = window.open("../history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
		
		//==> 추가된 부분: "listPurchase" Event 연결
		$("a[href='#']:contains('최근본상품')").on("click", function() {
			history();
		});
		
		//==> 추가된부분 : "login"  Event 연결
		$("a[href='#' ]:contains('로그인')").on("click", function() {
			self.location = "/user/login"
		});

		//==> 추가된 부분 : "logout" Event 연결
		$("a[href='#']:contains('로그아웃')").on("click", function() {
			self.location = "/user/logout";
		});
	});
</script>
