<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>惑前 备概</title>

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

		//==> Form Submit 贸府
		$("button:contains('备 概')").on("click", function() {
			fncAddPurchase();
		});
		$("button:contains('秒 家')").on("click", function() {
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

	<!--  拳搁备己 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">

			<!--  Menu 备己 Start /////////////////////////////////////-->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu 备己 end /////////////////////////////////////-->

			<div class="page-header text-center">
				<h3 class=" text-info">惑 前 备 概</h3>
			</div>

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
				<input type="hidden" name="prodNo" value="${product.prodNo}" />
				<input type="hidden" name="menu" value="${param.menu}" />
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">惑前锅龋</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodNo}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">惑前疙</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodName}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">惑前惑技沥焊</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.prodDetail}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">力炼老磊</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.manuDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">啊拜</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.price}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">殿废老磊</label>
					<div class="col-sm-4">
						<p class="form-control-static">${product.regDate}</p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-offset-1 col-sm-3 control-label">备概磊酒捞叼</label>
					<div class="col-sm-4">
						<p class="form-control-static">${user.userId}</p>
						<input type="hidden" name="buyerId" value="${user.userId}" />
					</div>
				</div>

				<div class="form-group">
					<label for="paymentOption"
						class="col-sm-offset-1 col-sm-3 control-label">备概规过</label>
					<div class="col-sm-4">
						<select name="paymentOption" id="paymentOption"
							class="form-control">
							<option value="1">泅陛备概</option>
							<option value="2">脚侩备概</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="receiverName"
						class="col-sm-offset-1 col-sm-3 control-label">备概磊捞抚</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName"
							name="receiverName" placeholder="备概磊捞抚" value="${user.userName}">
					</div>
				</div>

				<div class="form-group">
					<label for="receiverPhone"
						class="col-sm-offset-1 col-sm-3 control-label">备概磊楷遏贸</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone"
							name="receiverPhone" placeholder="备概磊楷遏贸" value="${user.phone}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyAddr"
						class="col-sm-offset-1 col-sm-3 control-label">备概磊林家</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr"
							name="divyAddr" placeholder="备概磊林家" value="${user.addr}">
					</div>
				</div>

				<div class="form-group">
					<label for="divyRequest"
						class="col-sm-offset-1 col-sm-3 control-label">备概夸没荤亲</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest"
							name="divyRequest" placeholder="备概夸没荤亲">
					</div>
				</div>

				<div class="form-group">
					<label for="divyDate"
						class="col-sm-offset-1 col-sm-3 control-label">硅价锐噶老磊</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate"
							name="divyDate" placeholder="硅价锐噶老磊">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">备 概</button>
						<button type="reset" class="btn btn-default">秒 家</button>
					</div>
				</div>

			</form>
			<!-- form End /////////////////////////////////////-->

			<!-- 包府磊窜, 蜡历 饭捞酒眶 备炼 -->
			<c:if
				test="${ param.paramRole != 'admin' && user.role != 'admin' && user.role != 'manager' }">
		</div>
		</c:if>

	</div>
	<!-- 促窜饭捞酒眶  end /////////////////////////////////////-->

	</div>
	<!--  拳搁备己 div Start /////////////////////////////////////-->

</body>

</html>