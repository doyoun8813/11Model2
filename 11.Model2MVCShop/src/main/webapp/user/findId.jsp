<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>���̵�ã��</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncFindId() {
		// Form ��ȿ�� ����
		var name = $("input[name='userName']").val();
		var email = $("input[name='email']").val();
		
		if(name == null || name.length<1){
			alert("�̸��� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='userName']").focus();
			return;
		}
		
		if(email == null || email.length<1){
			alert("�̸����� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='email']").focus();
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/user/findId").submit();
		
	}
	
	function check_email(frm) {
		
		var email = $("input[name='email']").val();
	    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
	    	alert("�̸��� ������ �ƴմϴ�.");
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">
		
			<!--  Menu ���� Start /////////////////////////////////////-->
			<jsp:include page="/layout/leftUser.jsp" />
			<!--  Menu ���� end /////////////////////////////////////-->
			<div class="col-md-10">
			
			<div class="page-header">
				<h3 class=" text-info">���̵� ã��</h3>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
			
				<div class="form-group">
					<label for="userName"
						class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userName"
							name="userName" placeholder="�̸�">
					</div>
				</div>
				
				<div class="form-group">
					<label for="email"
						class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="email"
							name="email" placeholder="�̸���">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">ã ��</button>
						<button type="reset" class="btn btn-default">�� ��</button>
					</div>
				</div>
				
			</form>
			
			
			</div>
			
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>
</html>
