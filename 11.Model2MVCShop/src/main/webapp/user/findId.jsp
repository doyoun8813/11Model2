<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>아이디찾기</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncFindId() {
		// Form 유효성 검증
		var name = $("input[name='userName']").val();
		var email = $("input[name='email']").val();
		
		if(name == null || name.length<1){
			alert("이름은 반드시 입력하여야 합니다.");
			$("input[name='userName']").focus();
			return;
		}
		
		if(email == null || email.length<1){
			alert("이메일은 반드시 입력하여야 합니다.");
			$("input[name='email']").focus();
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/user/findId").submit();
		
	}
	
	function check_email(frm) {
		
		var email = $("input[name='email']").val();
	    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
	    	alert("이메일 형식이 아닙니다.");
			return false;
	    }
	    return true;
	}
	
	$(function() {
		$("#email").on("change", function(){
			check_email(this.form);
		});
		
		$("button.btn-primary").on("click" , function() {
			fncFindId();
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
				<h3 class=" text-info">아이디 찾기</h3>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
			
				<div class="form-group">
					<label for="userName"
						class="col-sm-offset-1 col-sm-3 control-label">이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userName"
							name="userName" placeholder="이름">
					</div>
				</div>
				
				<div class="form-group">
					<label for="email"
						class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="email"
							name="email" placeholder="이메일">
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
