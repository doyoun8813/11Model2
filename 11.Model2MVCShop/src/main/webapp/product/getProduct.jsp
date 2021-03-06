<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>상품상세조회</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= 회원정보수정 Event  처리 =============	
	$(function() {
		$("a:contains('이전')	").on("click",function(){
			history.go(-1);
		});
		
		$("a:contains('구매')	").on("click",function(){
			self.location = "/purchase/addPurchase?prod_no=${product.prodNo}&menu=${param.menu}";
		});
		
		$("a:contains('확인')	").on("click",function(){
			self.location = "/product/listProduct?menu=${param.menu}";
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
				<h3 class=" text-info">상품상세조회</h3>
			</div>
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>상품번호</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodNo}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>상품명</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodName}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>상품이미지</strong>
				</div>
				<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${product.fileName}"></div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>상품상세정보</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>제조일자</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.manuDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>가격</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.price}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>등록일자</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.regDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12 text-center ">
					<c:if test="${!empty param.menu && param.menu=='search'}">
						<c:choose>
							<c:when test="${user.role == 'admin'}">
									<a href="#" class="btn btn-default">이전</a>
							</c:when>
							<c:otherwise>
									<a href="#" class="btn btn-primary">구매</a>
									<a href="#" class="btn btn-default">이전</a>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${!empty param.menu && param.menu=='manage'}">
							<a href="#" class="btn btn-primary">확인</a>
					</c:if>
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