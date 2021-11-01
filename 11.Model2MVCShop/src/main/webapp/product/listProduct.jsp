<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="../javascript/utilScript.js"></script>

<script type="text/javascript">

// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
function fncGetList(currentPage) {
	$("#currentPage").val(currentPage);
   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
}

$(function(){
	//==> �˻� Event ����ó���κ�
	$("td.ct_btn01:contains('�˻�')").on("click", function(){
		fncGetList(1);
	});
	
	//==> userId LINK Event ����ó��
	$(".ct_list_pop td:nth-child(3)").on("click", function(){
		var prodNo = $(this).attr("data-product").trim();
		var page_menu = "${param.menu}";
		$(this).parent(".ct_list_pop").next(".data_con").children("td").attr("id","dataCon"+prodNo);
		//console.log(prodNo);
		//console.log("${param.menu}");
		var user_role = "${user.role}";
		//console.log(user_role);
		//console.log(user_role.length);
		if(page_menu == "manage"){
			self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
		}else if(page_menu == "search"){
			if(user_role != null && user_role != "" && user_role.length != 0){
				//self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
				$.ajax({
					url: "/product/json/updateProduct/"+prodNo,
					method: "GET",
					dataType: "json",
					headers: {
						"Accept": "application/json",
						"Content-Type": "application/json"
					},
					success: function(JSONData, status){
						console.log(JSONData.prodNo);
						var displayValue = 
							"<ul class='data_list'>"
							+"<li><strong>��ǰ��ȣ</strong> : "+JSONData.prodNo+"</li>"
							+"<li><strong>��ǰ��</strong> : "+JSONData.prodName+"</li>"
							+"<li><strong>��ǰ�̹���</strong> : "+JSONData.fileName+"</li>"
							+"<li><strong>��ǰ������</strong> : "+JSONData.prodDetail+"</li>"
							+"<li><strong>��������</strong> : "+JSONData.manuDate+"</li>"
							+"<li><strong>����</strong> : "+JSONData.price+"</li>"
							+"<li><strong>�������</strong> : "+JSONData.regDate+"</li>"
							+"<li><a href='/purchase/addPurchase?prod_no="+JSONData.prodNo+"'>�����ϱ�</a></li>"
							+"</ul>";
						$(".data_list").remove();
						$("#dataCon"+JSONData.prodNo).html(displayValue);
					}
				});
			}else{
				alert("ȸ���� �ƴϽñ���!\n�α��� �Ŀ� ���������� ���� �� �ֽ��ϴ�.");
			}
		}
	});
	
	//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
	$(".ct_list_pop td:nth-child(3)").css("color" , "red");
	$("h7").css("color" , "red");
	$(".ct_list_pop:nth-child(4n+6)").css("background-color" , "whitesmoke");
	
	var obj = $(".ct_list_pop td:nth-child(9)");
	
	// �ǸŻ��� ���� jQuery ó��
	obj.each(function(index, elem){
		var prod_no = $(this).attr("data-product");
		var page_menu = "${param.menu}";
		if($(this).attr("data-trancode") == 1){
			var strDelivery = " <a href='/purchase/updateTranCodeByProd?prodNo="+prod_no+"&tranCode=2&page=${ !empty resultPage.currentPage ? search.currentPage : '' }'>����ϱ�</a>";
			$(this).text("���ſϷ�");
			if(page_menu == "manage"){
				$(this).append(strDelivery);
			}
			//console.log($(this).children("a").attr("href"));
			//self.location = $(this).children("a").attr("href");
		}else if($(this).attr("data-trancode") == 2){
			$(this).text("�����");
		}else if($(this).attr("data-trancode") == 3){
			$(this).text("��ۿϷ�");
		}else{
			$(this).text("�Ǹ���");
		}
	});
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!-- <form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">-->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
							${param.menu == "manage" ? "��ǰ����" : "��ǰ�����ȸ"}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			</select>
			<input type="text" name="searchKeyword" value="${ !empty search.searchKeyword ? search.searchKeyword : '' }" class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetList('1');">�˻�</a> -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left" data-product="${product.prodNo}">
				${product.prodName}
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
			<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}">
				<!-- �ǸŻ��� jQuery ���� -->
			</td>
		</tr>
		<tr class="data_con">
			<td colspan="9" bgcolor="D6D7D6" height="1"></td>
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
