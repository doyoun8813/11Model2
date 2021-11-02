<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
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
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<jsp:include page="/layout/leftUser.jsp" />
			<div class="col-md-10">
			<!--  Menu 구성 end /////////////////////////////////////-->   

		 	 	<!--  Main start /////////////////////////////////////-->
		 	 	<c:if test="${ !empty user }">
		 	 	환영합니다 .
		 	 	</c:if>
		 	 	<c:if test="${ empty user }">	
					<div class="jumbotron">
				  		<h1>Model2 MVC Shop</h1>
				  		<p>로그인 후 사용가능...</p>
				  		<p>로그인 전 검색만 가능합니다.</p>
				  		<p>회원가입 하세요.</p>
				  		
				  		<div class="text-center">
				  			<a class="btn btn-info btn-lg" href="#" role="button">회원가입</a>
				  			<a class="btn btn-info btn-lg" href="#" role="button">로그인</a>
				  		</div>
				  	
				  	</div>
		        </c:if>
		   	 	<!--  Main end /////////////////////////////////////-->  
	   	 	
	   	 	</div>		
	 	 	
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>