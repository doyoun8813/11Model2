<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= 회원정보수정 Event  처리 =============	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button").on("click", function() {
			self.location = "/user/updateUser?userId=${user.userId}&paramRole=${param.paramRole}"
		});
		
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if test="${ param.paramRole == 'admin' || user.role == 'admin' || user.role == 'manager' }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
	<c:if test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		<jsp:include page="/layout/toolbarUser.jsp" />
	</c:if>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu 구성 Start /////////////////////////////////////-->    
			<c:if test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>	
			<!--  Menu 구성 end /////////////////////////////////////-->
			
			<div class="page-header">
				<h3 class=" text-info">회원정보조회</h3>
				<h5 class="text-muted">
					내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.
				</h5>
			</div>

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>아 이 디</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.userId}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>이 름</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.userName}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>주소</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.addr}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>휴대전화번호</strong>
				</div>
				<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}
				</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>이 메 일</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.email}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>가입일자</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.regDate}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-md-12 text-center ">
					<button type="button" class="btn btn-primary">회원정보수정</button>
				</div>
			</div>

			<br />
			
			<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>