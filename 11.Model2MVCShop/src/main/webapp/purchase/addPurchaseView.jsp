<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>상품 구매</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncAddPurchase() {
		$("form").attr("method", "POST")
				.attr("action", "/purchase/addPurchase").submit();
	}

	$(function() {

		//==> Form Submit 처리
		$("button:contains('구 매')").on("click", function() {
			fncAddPurchase();
		});
		$("button:contains('취 소')").on("click", function() {
			history.go(-1);
		});

		//==> divyDate datepicker 
		$("#divyDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if
		test="${ param.paramRole == 'admin' || user.role == 'admin' || user.role == 'manager' }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
	<c:if
		test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		<jsp:include page="/layout/toolbarUser.jsp" />
	</c:if>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">

			<!--  Menu 구성 Start /////////////////////////////////////-->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu 구성 end /////////////////////////////////////-->

			<div class="page-header text-center">
				<h3 class=" text-info">상 품 구 매</h3>
			</div>

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
				<input type="hidden" name="prodNo" value="${product.prodNo}" />
				<input type="hidden" name="menu" value="${param.menu}" />
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodNo}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodName}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodDetail}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.manuDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">가격</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.price}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.regDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
					<div class="col-sm-4">
						<p class="form-control-static">${user.userId}</p>
						<input type="hidden" name="buyerId" value="${user.userId}" />
					</div>
				</div>

				<div class="form-group">
					<label for="paymentOption"
						class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
					<div class="col-sm-4">
						<select name="paymentOption" id="paymentOption"
							class="form-control">
							<option value="1">현금구매</option>
							<option value="2">신용구매</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="receiverName"
						class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName"
							name="receiverName" placeholder="구매자이름" value="${user.userName}">
					</div>
				</div>

				<div class="form-group">
					<label for="receiverPhone"
						class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone"
							name="receiverPhone" placeholder="구매자연락처" value="${user.phone}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyAddr"
						class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr"
							name="divyAddr" placeholder="구매자주소" value="${user.addr}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyRequest"
						class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest"
							name="divyRequest" placeholder="구매요청사항">
					</div>
				</div>

				<div class="form-group">
					<label for="divyDate"
						class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate"
							name="divyDate" placeholder="배송희망일자">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">구 매</button>
						<button type="reset" class="btn btn-default">취 소</button>
					</div>
				</div>

			</form>
			<!-- form End /////////////////////////////////////-->

			<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		</div>
		</c:if>

	</div>
	<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>