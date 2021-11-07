<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>구매 목록조회</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action",
				"/purchase/listPurchase").submit();
	}

	$(function() {
		$("td:nth-child(1)").on("click",function() {
			//self.location = "/purchase/getPurchase?tranNo="+$(this).attr("data-tranno");
		
			var tranNo = $(this).attr("data-tranno").trim();
			$(".ct_list_pop").next(".data_con").children("td")
					.removeAttr("id");
			$(this).parent(".ct_list_pop").next(".data_con")
					.children("td").attr("id",
							"dataCon" + tranNo);
			$.ajax({
				url : "/purchase/json/getPurchase/"	+ tranNo,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {
					//구매 방법 조건식 값 구하기
					var paymendOpt = JSONData.paymentOption == '1  ' ? "현금구매"	: "신용구매";

					// 주문일 날짜 timestemp date형으로 형변환 
					var orderDate = new Date(JSONData.orderDate);
					console.log(orderDate);
					var orderYear = orderDate.getFullYear();
					var orderMonth = ('0' + (orderDate.getMonth() + 1)).slice(-2);
					var orderDay = ('0' + orderDate.getDate()).slice(-2);
					orderDate = orderYear + "-"	+ orderMonth + "-" + orderDay;

					// 배송일 date형 시간 안나오게 변환
					var divyDate = new Date(JSONData.divyDate);
					console.log(divyDate);
					var divyYear = divyDate.getFullYear();
					var divyMonth = ('0' + (divyDate.getMonth() + 1)).slice(-2);
					var divyDay = ('0' + divyDate.getDate()).slice(-2);
					divyDate = divyYear + "-" + divyMonth + "-" + divyDay;

					var displayValue = "<ul class='data_list'>"
							+ "<li><strong>물품번호</strong> : "
							+ JSONData.purchaseProd.prodNo
							+ "</li>"
							+ "<li><strong>구매자아이디</strong> : "
							+ JSONData.buyer.userId
							+ "</li>"
							+ "<li><strong>구매방법</strong> : "
							+ paymendOpt
							+ "</li>"
							+ "<li><strong>구매자이름</strong> : "
							+ JSONData.receiverName
							+ "</li>"
							+ "<li><strong>구매자연락처</strong> : "
							+ JSONData.receiverPhone
							+ "</li>"
							+ "<li><strong>구매자주소</strong> : "
							+ JSONData.divyAddr
							+ "</li>"
							+ "<li><strong>구매요청사항</strong> : "
							+ JSONData.divyRequest
							+ "</li>"
							+ "<li><strong>배송희망일</strong> : "
							+ divyDate
							+ "</li>"
							+ "<li><strong>주문일</strong> : "
							+ orderDate
							+ "</li>"
							+ "<li><a href='/purchase/updatePurchase?tranNo="
							+ JSONData.tranNo
							+ "'>수정하기</a></li>"
							+ "</ul>";
					$(".data_list").remove();
					$("#dataCon" + JSONData.tranNo).html(displayValue);
				}
			});
		
		});

		$("td:nth-child(2)").on("click", function() {
					//self.location="/user/getUser?userId="+$(this).text().trim(); 
					var userId = $(this).text().trim();
					$(".ct_list_pop").next(".data_con").children("td")
							.removeAttr("id");
					$(this).parent(".ct_list_pop").next(".data_con").children(
							"td").attr("id", "dataCon" + userId);
					$.ajax({
						url : "/user/json/getUser/" + userId,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {
							var displayValue = "<ul class='data_list'>"
									+ "<li><strong>아이디</strong> : "
									+ JSONData.userId + "</li>"
									+ "<li><strong>이 름</strong> : "
									+ JSONData.userName + "</li>"
									+ "<li><strong>이메일</strong> : "
									+ JSONData.email + "</li>"
									+ "<li><strong>ROLE</strong> : "
									+ JSONData.role + "</li>"
									+ "<li><strong>등록일</strong> : "
									+ JSONData.regDateString + "</li>"
									+ "<li><a href='/user/updateUser?userId="
									+ JSONData.userId + "'>수정하기</a></li>"
									+ "</ul>";
							$(".data_list").remove();
							$("#dataCon" + JSONData.userId).html(displayValue);
						}
					});
				});

		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$("td:nth-child(1)").css("color", "red");
		$("td:nth-child(3)").css("color", "red");
		$("td:nth-child(11)").css("color", "red");
		$("h7").css("color", "red");

		var obj = $("td:nth-child(7)");

		obj.each(function(index, elem) {
			var tran_code = $(this).attr("data-trancode");
			if (tran_code == 2) {
				$(this).text("물건도착");
				console.log("/purchase/updateTranCode?prodNo="
						+ $(this).attr("data-prodno")
						+ "&tranCode=3&page=${resultPage.currentPage}");
			}
		});

		$("td:nth-child(7):contains('물건도착')").on("click", function() {
			self.location = "/purchase/updateTranCode?prodNo="
					+ $(this).attr("data-prodno")
					+ "&tranCode=3&page=${resultPage.currentPage}";
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
				<h3 class=" text-info">구매이력조회</h3>
			</div>
			
			<div class="row">
		    	<div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지
			    	</p>
			    </div>
		    </div>
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" >
		    	<thead>
		    		<tr>
		    			<th align="center">No</th>
						<th align="left">회원ID</th>
						<th align="left">회원명</th>
						<th align="left">전화번호</th>	
						<th align="left">배송현황</th>
						<th align="left">정보수정</th>
						<th align="left">정보수정</th>
		          	</tr>
		        </thead>
		       
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="purchase" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="left" title="Click : 구매정보 확인" data-tranno="${purchase.tranNo}">
								${purchase.rowNum}
							</td>
							<td align="left">${purchase.buyer.userId}</td>
							<td align="left">${user.userName}</td>
							<td align="left">${purchase.receiverPhone}</td>
							<td align="left">
								현재 <c:choose>
										<c:when test="${purchase.tranCode=='1  '}">
											구매완료
										</c:when>
										<c:when test="${purchase.tranCode=='2  '}">
											배송중
										</c:when>
										<c:when test="${purchase.tranCode=='3  '}">
											배송완료
										</c:when>
										<c:otherwise>
											판매중
										</c:otherwise>
									</c:choose>
								상태 입니다.
							</td>
							<td align="left" class="data_con">
			  					<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  					<input type="hidden" value="${product.prodNo}">
			  				</td>
			  				<td align="left" data-trancode="${purchase.tranCode}"
							data-prodno="${purchase.purchaseProd.prodNo}"
							data-userid="${purchase.buyer.userId}"><!-- jQuery 구현 --></td>
								
						</tr>
					</c:forEach>
		        </tbody>
		    </table>
			<!--  table End /////////////////////////////////////-->
			
			<!-- PageNavigation Start... -->
			<form>
				<input type="hidden" id="currentPage" name="currentPage" value="" />
			</form>
			<jsp:include page="../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->
			
			<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->

</body>
</html>