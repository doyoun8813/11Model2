<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="../javascript/utilScript.js"></script>

<script type="text/javascript">
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
	}
	
	$(function(){
		$(".ct_list_pop td:nth-child(1)").on("click", function(){
			//self.location = "/purchase/getPurchase?tranNo="+$(this).attr("data-tranno");
			
			var tranNo = $(this).attr("data-tranno").trim();
			$(".ct_list_pop").next(".data_con").children("td").removeAttr("id");
			$(this).parent(".ct_list_pop").next(".data_con").children("td").attr("id","dataCon"+tranNo);
			$.ajax({
				url: "/purchase/json/getPurchase/"+tranNo,
				method: "GET",
				dataType: "json",
				headers: {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success: function(JSONData, status){
					//���� ��� ���ǽ� �� ���ϱ�
					var paymendOpt = JSONData.paymentOption=='1  ' ? "���ݱ���" : "�ſ뱸��";
					
					// �ֹ��� ��¥ timestemp date������ ����ȯ 
					var orderDate = new Date(JSONData.orderDate);
					console.log(orderDate);
					var orderYear = orderDate.getFullYear();
					var orderMonth = ('0' + (orderDate.getMonth() + 1)).slice(-2);
					var orderDay = ('0' + orderDate.getDate()).slice(-2);
					orderDate = orderYear + "-" + orderMonth + "-" + orderDay;
					
					// ����� date�� �ð� �ȳ����� ��ȯ
					var divyDate = new Date(JSONData.divyDate);
					console.log(divyDate);
					var divyYear = divyDate.getFullYear();
					var divyMonth = ('0' + (divyDate.getMonth() + 1)).slice(-2);
					var divyDay = ('0' + divyDate.getDate()).slice(-2);
					divyDate = divyYear + "-" + divyMonth + "-" + divyDay;
					
					var displayValue =
						"<ul class='data_list'>"
						+"<li><strong>��ǰ��ȣ</strong> : " + JSONData.purchaseProd.prodNo + "</li>" 
						+"<li><strong>�����ھ��̵�</strong> : " + JSONData.buyer.userId + "</li>" 
						+"<li><strong>���Ź��</strong> : " + paymendOpt + "</li>" 
						+"<li><strong>�������̸�</strong> : " + JSONData.receiverName + "</li>" 
						+"<li><strong>�����ڿ���ó</strong> : " + JSONData.receiverPhone + "</li>"
						+"<li><strong>�������ּ�</strong> : " + JSONData.divyAddr + "</li>"
						+"<li><strong>���ſ�û����</strong> : " + JSONData.divyRequest + "</li>"
						+"<li><strong>��������</strong> : " + divyDate + "</li>"
						+"<li><strong>�ֹ���</strong> : " + orderDate + "</li>"
						+"<li><a href='/purchase/updatePurchase?tranNo="+JSONData.tranNo+"'>�����ϱ�</a></li>"
						+"</ul>";
					$(".data_list").remove();
					$("#dataCon"+JSONData.tranNo).html(displayValue);
				}
			});
			
			
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			//self.location="/user/getUser?userId="+$(this).text().trim(); 
			var userId = $(this).text().trim();
			$(".ct_list_pop").next(".data_con").children("td").removeAttr("id");
			$(this).parent(".ct_list_pop").next(".data_con").children("td").attr("id","dataCon"+userId);
			$.ajax({
				url: "/user/json/getUser/"+userId,
				method: "GET",
				dataType: "json",
				headers: {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success: function(JSONData, status){
					var displayValue =
						"<ul class='data_list'>"
						+"<li><strong>���̵�</strong> : " + JSONData.userId + "</li>" 
						+"<li><strong>�� ��</strong> : " + JSONData.userName + "</li>" 
						+"<li><strong>�̸���</strong> : " + JSONData.email + "</li>" 
						+"<li><strong>ROLE</strong> : " + JSONData.role + "</li>" 
						+"<li><strong>�����</strong> : " + JSONData.regDateString + "</li>"
						+"<li><a href='/user/updateUser?userId="+JSONData.userId+"'>�����ϱ�</a></li>"
						+"</ul>";
					$(".data_list").remove();
					$("#dataCon"+JSONData.userId).html(displayValue);
				}
			});
		});
		
		//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$( ".ct_list_pop td:nth-child(11)" ).css("color" , "red");
		$("h7").css("color" , "red");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		var obj = $(".ct_list_pop td:nth-child(11)");
		
		obj.each(function(index, elem){
			var tran_code = $(this).attr("data-trancode");
			if(tran_code == 2){
				$(this).text("���ǵ���");
				console.log("/purchase/updateTranCode?prodNo="+$(this).attr("data-prodno")+"&tranCode=3&page=${resultPage.currentPage}");
			}
		});
		
		$(".ct_list_pop td:nth-child(11):contains('���ǵ���')").on("click", function(){
			self.location="/purchase/updateTranCode?prodNo="+$(this).attr("data-prodno")+"&tranCode=3&page=${resultPage.currentPage}";
		});
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:forEach var="purchase" items="${list}">
		<tr class="ct_list_pop">
			<td align="center" data-tranno="${purchase.tranNo}">
				<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${purchase.rowNum}</a>-->
				${purchase.rowNum}
			</td>
			<td></td>
			<td align="left">
				<!-- <a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a> -->
				${purchase.buyer.userId}
			</td>
			<td></td>
			<td align="left">${purchase.receiverName}</td>
			<td></td>
			<td align="left">${purchase.receiverPhone}</td>
			<td></td>
			<td align="left">
				����
				<c:choose>
					<c:when test="${purchase.tranCode=='1  '}">
					���ſϷ� ���� �Դϴ�.
					</c:when>
					<c:when test="${purchase.tranCode=='2  '}">
					����� ���� �Դϴ�.
					</c:when>
					<c:when test="${purchase.tranCode=='3  '}">
					��ۿϷ� ���� �Դϴ�.
					</c:when>
					<c:otherwise>
					�Ǹ��� ���� �Դϴ�.
					</c:otherwise>
				</c:choose>
			</td>
			<td></td>
			<td align="left" data-trancode="${purchase.tranCode}" data-prodno="${purchase.purchaseProd.prodNo}" data-userid="${purchase.buyer.userId}">
				<!-- jQuery ���� -->
				<!--<c:choose>
					<c:when test="${purchase.tranCode=='2  '}">
					<a href="/purchase/updateTranCode?prodNo=${purchase.purchaseProd.prodNo}&tranCode=3&page=${resultPage.currentPage}">���ǵ���</a>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>-->
			</td>
		</tr>
		<tr class="data_con">
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<!-- PageNavigation Start -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!-- PageNavigation End -->

</form>

</div>

</body>
</html>