<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// �α��ν� Forward  /////////////////////////////////////// -->
<%--  <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if> --%>
  <c:if test="${ user.role == 'admin' || user.role == 'manager' }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<jsp:include page="/layout/head.jsp" />
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		$( function() {
			
			
		});
		
	</script>	
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbarUser.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu ���� Start /////////////////////////////////////-->     	
			<jsp:include page="/layout/leftUser.jsp" />
			<div class="col-md-10">
			<!--  Menu ���� end /////////////////////////////////////-->   

		 	 	<!--  Main start /////////////////////////////////////-->
		 	 	<c:if test="${ !empty user }">
		 	 	ȯ���մϴ� .
		 	 	</c:if>
		 	 	<c:if test="${ empty user }">	
					<div class="jumbotron">
				  		<h1>Model2 MVC Shop</h1>
				  		<p>�α��� �� ��밡��...</p>
				  		<p>�α��� �� �˻��� �����մϴ�.</p>
				  		<p>ȸ������ �ϼ���.</p>
				  		
				  		<div class="text-center">
				  			<a class="btn btn-info btn-lg" href="#" role="button">ȸ������</a>
				  			<a class="btn btn-info btn-lg" href="#" role="button">�α���</a>
				  		</div>
				  	
				  	</div>
		        </c:if>
		   	 	<!--  Main end /////////////////////////////////////-->  
	   	 	
	   	 	</div>		
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>