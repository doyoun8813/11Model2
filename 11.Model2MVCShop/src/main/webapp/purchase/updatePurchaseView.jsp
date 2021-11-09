<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>구매정보 수정</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncUpdatePurchase(){
		$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
	}
	
	$(function(){
		
		//==> Form Submit 처리
		$("button:contains('수 정')").on("click", function() {
			fncUpdatePurchase();
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
				<h3 class="text-info">구매정보 수정</h3>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
				<input type="hidden" name="buyerId" value="${purchase.buyer.userId}">
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
					<div class="col-sm-4">
						<p class="form-control-static">${purchase.buyer.userId}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label for="paymentOption"
						class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
					<div class="col-sm-4">
						<select name="paymentOption" id="paymentOption"	class="form-control">
							<c:choose>
								<c:when test="${purchase.paymentOption=='1  '}">
								<option value="1" selected>현금구매</option>
								<option value="2">신용구매</option>
								</c:when>
								<c:otherwise>
								<option value="1">현금구매</option>
								<option value="2" selected>신용구매</option>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label for="receiverName"
						class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName"
							name="receiverName" placeholder="구매자이름" value="${purchase.receiverName}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="receiverPhone"
						class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone"
							name="receiverPhone" placeholder="구매자연락처" value="${purchase.receiverPhone}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="divyAddr"
						class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr"
							name="divyAddr" placeholder="구매자주소" value="${purchase.divyAddr}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyRequest"
						class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest"
							name="divyRequest" placeholder="구매요청사항" value="${purchase.divyRequest}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyDate"
						class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate"
							name="divyDate" placeholder="배송희망일자" readonly="readonly">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">수 정</button>
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
