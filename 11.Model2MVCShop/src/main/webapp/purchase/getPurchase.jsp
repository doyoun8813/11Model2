<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>구매상세조회</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		$( "a.btn-primary:contains('수 정')" ).on("click" , function() {
			self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
		});
		$( "a.btn-default:contains('목록보기')" ).on("click" , function() {			
			self.location = "/purchase/listPurchase";
		});
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if test="${ user.role == 'admin' || user.role == 'manager' }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
	<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
		<jsp:include page="/layout/toolbarUser.jsp" />
	</c:if>
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu 구성 Start /////////////////////////////////////-->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu 구성 end /////////////////////////////////////-->
			
			<div class="page-header">
				<h3 class=" text-info">구매상세조회</h3>
			</div>
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>물품번호</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매자아이디 </strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매방법</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.paymentOption=='1  '  ? "현금구매" : "신용구매" }</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매자이름</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매자연락처</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매자주소</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>구매요청사항</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>배송희망일</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>주문일</strong>
				</div>
				<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
			</div>
			
			<hr />

			<div class="row">
				<div class="col-md-12 text-center ">
					<a href="#" class="btn btn-primary">수 정</a>
					<a href="#" class="btn btn-default">목록보기</a>
				</div>
			</div>
			
			
			<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ param.paramRole != 'admin' }">
				</div>
			</c:if>	
			
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>
