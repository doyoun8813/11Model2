<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!--  Menu 구성 Start /////////////////////////////////////-->
<div class="col-md-2">

	<!--  회원관리 목록에 제목 -->
	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-heart"></i> 회원관리
		</div>
		<!--  회원관리 아이템 -->
		<ul class="list-group">
			<li class="list-group-item"><a href="#">개인정보조회</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
			<!-- <li class="list-group-item">
				 	<a href="#">회원정보조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li> -->
		</ul>
	</div>


	<!-- <div class="panel panel-primary">
			<div class="panel-heading">
				<i class="glyphicon glyphicon-briefcase"></i> 판매상품관리
   			</div>
			<ul class="list-group">
				 <li class="list-group-item">
				 	<a href="#">판매상품등록</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li>
				 <li class="list-group-item">
				 	<a href="#">판매상품관리</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li>
			</ul>
       </div> -->


	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-shopping-cart"></i> 상품구매
		</div>
		<ul class="list-group">
			<li class="list-group-item"><a href="#">상품검색</a></li>
			<li class="list-group-item"><a href="#">구매이력조회</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
			<li class="list-group-item"><a href="#">최근본상품</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
		</ul>
	</div>

</div>
<!--  Menu 구성 end /////////////////////////////////////-->



<script type="text/javascript">

	function history(){
		popWin = window.open("../history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}

	//==> 추가된 부분 : "listProduct" Event 연결
	$("a[href='#']:contains('상품검색')").on("click", function() {
		$(this).attr("href", "/product/listProduct?menu=search");
	});

	console.log("user : ${user}");
	if ("${user}") {
		//alert("로그인 함");
		
		//==> 금지 glipycon 로그인시 없애기
		$(".list-group-item").children("i").hide();
		
		//==> 추가된 부분: "getUser" Event 연결
		$("a[href='#']:contains('개인정보조회')").on("click", function() {
			$(this).attr("href", "/user/getUser?userId=${user.userId}");
		});
		
		//==> 추가된 부분: "listPurchase" Event 연결
		$("a[href='#']:contains('구매이력조회')").on("click", function() {
			$(this).attr("href", "/purchase/listPurchase");
		});
		
		//==> 추가된 부분: "listPurchase" Event 연결
		$("a[href='#']:contains('최근본상품')").on("click", function() {
			history();
		});
		
	} else {
		$("a[href='#']:contains('개인정보조회')").on("click", function() {
			alert("로그인을 하셔야 접속 가능합니다.");
		});
		
		$("a[href='#']:contains('구매이력조회')").on("click", function() {
			alert("로그인을 하셔야 접속 가능합니다.");
		});
		
		$("a[href='#']:contains('최근본상품')").on("click", function() {
			alert("로그인을 하셔야 접속 가능합니다.");
		});
	}
</script>
