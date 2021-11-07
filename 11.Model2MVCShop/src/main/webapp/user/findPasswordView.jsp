<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>ã�� ��й�ȣ ��ȸ</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		//============= ȸ���������� Event ó�� =============	
		$(function() {
			
			$("a:contains('�α��� �Ϸ�����')	").on("click",function(){
				self.location = "/user/login";
			});
			
			$("a:contains('����')	").on("click",function(){
				history.go(-1);
			});
			
		});
	</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbarUser.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu ���� Start /////////////////////////////////////-->
			<jsp:include page="/layout/leftUser.jsp" />
			<!--  Menu ���� end ///////////////////////////////////////-->
			<div class="col-md-10">
			
			<div class="page-header">
				<h3 class=" text-info">ã�� ��й�ȣ ��ȸ</h3>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<strong>${user.userName}</strong>���� ��й�ȣ�� [<strong>${user.password}</strong>] �Դϴ�.
				</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12 text-center ">
					<a href="#" class="btn btn-primary">�α��� �Ϸ�����</a>
					<a href="#" class="btn btn-default">����</a>
				</div>
			</div>
			
			<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			</div>
			
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>
</html>