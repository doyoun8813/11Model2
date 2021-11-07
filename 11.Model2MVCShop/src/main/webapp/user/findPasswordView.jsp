<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>찾은 비밀번호 조회</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		//============= 회원정보수정 Event 처리 =============	
		$(function() {
			
			$("a:contains('로그인 하러가기')	").on("click",function(){
				self.location = "/user/login";
			});
			
			$("a:contains('이전')	").on("click",function(){
				history.go(-1);
			});
			
		});
	</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbarUser.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu 구성 Start /////////////////////////////////////-->
			<jsp:include page="/layout/leftUser.jsp" />
			<!--  Menu 구성 end ///////////////////////////////////////-->
			<div class="col-md-10">
			
			<div class="page-header">
				<h3 class=" text-info">찾은 비밀번호 조회</h3>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<strong>${user.userName}</strong>님의 비밀번호는 [<strong>${user.password}</strong>] 입니다.
				</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12 text-center ">
					<a href="#" class="btn btn-primary">로그인 하러가기</a>
					<a href="#" class="btn btn-default">이전</a>
				</div>
			</div>
			
			<!-- 관리자단, 유저 레이아웃 구조 -->
			</div>
			
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>