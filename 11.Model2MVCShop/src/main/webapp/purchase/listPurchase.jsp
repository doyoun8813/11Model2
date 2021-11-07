<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>���� �����ȸ</title>

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
					//���� ��� ���ǽ� �� ���ϱ�
					var paymendOpt = JSONData.paymentOption == '1  ' ? "���ݱ���"	: "�ſ뱸��";

					// �ֹ��� ��¥ timestemp date������ ����ȯ 
					var orderDate = new Date(JSONData.orderDate);
					console.log(orderDate);
					var orderYear = orderDate.getFullYear();
					var orderMonth = ('0' + (orderDate.getMonth() + 1)).slice(-2);
					var orderDay = ('0' + orderDate.getDate()).slice(-2);
					orderDate = orderYear + "-"	+ orderMonth + "-" + orderDay;

					// ����� date�� �ð� �ȳ����� ��ȯ
					var divyDate = new Date(JSONData.divyDate);
					console.log(divyDate);
					var divyYear = divyDate.getFullYear();
					var divyMonth = ('0' + (divyDate.getMonth() + 1)).slice(-2);
					var divyDay = ('0' + divyDate.getDate()).slice(-2);
					divyDate = divyYear + "-" + divyMonth + "-" + divyDay;

					var displayValue = "<ul class='data_list'>"
							+ "<li><strong>��ǰ��ȣ</strong> : "
							+ JSONData.purchaseProd.prodNo
							+ "</li>"
							+ "<li><strong>�����ھ��̵�</strong> : "
							+ JSONData.buyer.userId
							+ "</li>"
							+ "<li><strong>���Ź��</strong> : "
							+ paymendOpt
							+ "</li>"
							+ "<li><strong>�������̸�</strong> : "
							+ JSONData.receiverName
							+ "</li>"
							+ "<li><strong>�����ڿ���ó</strong> : "
							+ JSONData.receiverPhone
							+ "</li>"
							+ "<li><strong>�������ּ�</strong> : "
							+ JSONData.divyAddr
							+ "</li>"
							+ "<li><strong>���ſ�û����</strong> : "
							+ JSONData.divyRequest
							+ "</li>"
							+ "<li><strong>��������</strong> : "
							+ divyDate
							+ "</li>"
							+ "<li><strong>�ֹ���</strong> : "
							+ orderDate
							+ "</li>"
							+ "<li><a href='/purchase/updatePurchase?tranNo="
							+ JSONData.tranNo
							+ "'>�����ϱ�</a></li>"
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
									+ "<li><strong>���̵�</strong> : "
									+ JSONData.userId + "</li>"
									+ "<li><strong>�� ��</strong> : "
									+ JSONData.userName + "</li>"
									+ "<li><strong>�̸���</strong> : "
									+ JSONData.email + "</li>"
									+ "<li><strong>ROLE</strong> : "
									+ JSONData.role + "</li>"
									+ "<li><strong>�����</strong> : "
									+ JSONData.regDateString + "</li>"
									+ "<li><a href='/user/updateUser?userId="
									+ JSONData.userId + "'>�����ϱ�</a></li>"
									+ "</ul>";
							$(".data_list").remove();
							$("#dataCon" + JSONData.userId).html(displayValue);
						}
					});
				});

		//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$("td:nth-child(1)").css("color", "red");
		$("td:nth-child(3)").css("color", "red");
		$("td:nth-child(11)").css("color", "red");
		$("h7").css("color", "red");

		var obj = $("td:nth-child(7)");

		obj.each(function(index, elem) {
			var tran_code = $(this).attr("data-trancode");
			if (tran_code == 2) {
				$(this).text("���ǵ���");
				console.log("/purchase/updateTranCode?prodNo="
						+ $(this).attr("data-prodno")
						+ "&tranCode=3&page=${resultPage.currentPage}");
			}
		});

		$("td:nth-child(7):contains('���ǵ���')").on("click", function() {
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			
			<!--  Menu ���� Start /////////////////////////////////////-->    
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>	
			<!--  Menu ���� end /////////////////////////////////////-->
			
			<div class="page-header">
				<h3 class=" text-info">�����̷���ȸ</h3>
			</div>
			
			<div class="row">
		    	<div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage}  ������
			    	</p>
			    </div>
		    </div>
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" >
		    	<thead>
		    		<tr>
		    			<th align="center">No</th>
						<th align="left">ȸ��ID</th>
						<th align="left">ȸ����</th>
						<th align="left">��ȭ��ȣ</th>	
						<th align="left">�����Ȳ</th>
						<th align="left">��������</th>
						<th align="left">��������</th>
		          	</tr>
		        </thead>
		       
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="purchase" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="left" title="Click : �������� Ȯ��" data-tranno="${purchase.tranNo}">
								${purchase.rowNum}
							</td>
							<td align="left">${purchase.buyer.userId}</td>
							<td align="left">${user.userName}</td>
							<td align="left">${purchase.receiverPhone}</td>
							<td align="left">
								���� <c:choose>
										<c:when test="${purchase.tranCode=='1  '}">
											���ſϷ�
										</c:when>
										<c:when test="${purchase.tranCode=='2  '}">
											�����
										</c:when>
										<c:when test="${purchase.tranCode=='3  '}">
											��ۿϷ�
										</c:when>
										<c:otherwise>
											�Ǹ���
										</c:otherwise>
									</c:choose>
								���� �Դϴ�.
							</td>
							<td align="left" class="data_con">
			  					<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  					<input type="hidden" value="${product.prodNo}">
			  				</td>
			  				<td align="left" data-trancode="${purchase.tranCode}"
							data-prodno="${purchase.purchaseProd.prodNo}"
							data-userid="${purchase.buyer.userId}"><!-- jQuery ���� --></td>
								
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
			
			<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

</body>
</html>