<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>비밀번호찾기</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncFindPassword() {
		// Form 유효성 검증
		var id = $("input[name='userId']").val();
		var name = $("input[name='userName']").val();
		
		if(id == null || id.length <1){
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		}
		if(name == null || name.length <1){
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/user/findPassword").submit();
	}
	
	$(function() {
		
		$("button.btn-primary").on("click" , function() {
			fncFindPassword();
		});
		
		$("button.btn-default").on("click" , function() {
			history.go(-1);
		});
	});

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbarUser.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu 구성 Start /////////////////////////////////////-->
			<jsp:include page="/layout/leftUser.jsp" />
			<!--  Menu 구성 end /////////////////////////////////////-->
			<div class="col-md-10">
			
			<div class="page-header">
				<h3 class=" text-info">비밀번호 찾기</h3>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
			
				<div class="form-group">
					<label for="userId"
						class="col-sm-offset-1 col-sm-3 control-label">아이디</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userId"
							name="userId" placeholder="아이디">
					</div>
				</div>
				
				<div class="form-group">
					<label for="userName"
						class="col-sm-offset-1 col-sm-3 control-label">이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userName"
							name="userName" placeholder="이름">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">찾 기</button>
						<button type="reset" class="btn btn-default">취 소</button>
					</div>
				</div>
				
			</form>
			
			
			</div>
			
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>
