<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>��ǰ����ȸ</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= ȸ���������� Event  ó�� =============	
	$(function() {
		$("a:contains('����')	").on("click",function(){
			history.go(-1);
		});
		
		$("a:contains('����')	").on("click",function(){
			self.location = "/purchase/addPurchase?prod_no=${product.prodNo}&menu=${param.menu}";
		});
		
		$("a:contains('Ȯ��')	").on("click",function(){
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
				<h3 class=" text-info">��ǰ����ȸ</h3>
			</div>
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��ǰ��ȣ</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodNo}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��ǰ��</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodName}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��ǰ�̹���</strong>
				</div>
				<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${product.fileName}"></div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��ǰ������</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>��������</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.manuDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>����</strong>
				</div>
				<div class="col-xs-8 col-md-4">${product.price}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�������</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.regDate}</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12 text-center ">
					<c:if test="${!empty param.menu && param.menu=='search'}">
						<c:choose>
							<c:when test="${user.role == 'admin'}">
									<a href="#" class="btn btn-default">����</a>
							</c:when>
							<c:otherwise>
									<a href="#" class="btn btn-primary">����</a>
									<a href="#" class="btn btn-default">����</a>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${!empty param.menu && param.menu=='manage'}">
							<a href="#" class="btn btn-primary">Ȯ��</a>
					</c:if>
				</div>
			</div>
			
			
			<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if test="${ param.paramRole != 'admin' }">
				</div>
			</c:if>	
			
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>
</html>