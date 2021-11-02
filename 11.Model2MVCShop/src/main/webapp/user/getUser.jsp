<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= ȸ���������� Event  ó�� =============	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button").on("click", function() {
			self.location = "/user/updateUser?userId=${user.userId}"
		});
		
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<div class="page-header">
				<h3 class=" text-info">ȸ��������ȸ</h3>
				<h5 class="text-muted">
					�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.
				</h5>
			</div>

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�� �� ��</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.userId}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>�� ��</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.userName}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>�ּ�</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.addr}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>�޴���ȭ��ȣ</strong>
				</div>
				<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}
				</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>�� �� ��</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.email}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2 ">
					<strong>��������</strong>
				</div>
				<div class="col-xs-8 col-md-4">${user.regDate}</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-md-12 text-center ">
					<button type="button" class="btn btn-primary">ȸ����������</button>
				</div>
			</div>

			<br />
			
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>