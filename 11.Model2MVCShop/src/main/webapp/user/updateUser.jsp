<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">

<head>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= "수정"  Event 연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-primary").on("click", function() {
			fncUpdateUser();
		});
	});

	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click", function() {
			$("form")[0].reset();
		});
	});

	//=============이메일" 유효성Check  Event 처리 =============
	$(function() {

		$("input[name='email']").on("change",function() {
			var email = $("input[name='email']").val();
			if (email != ""	&& (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
				alert("이메일 형식이 아닙니다.");
			}
		});

	});

	///////////////////////////////////////////////////////////////////////
	function fncUpdateUser() {
		var name = $("input[name='userName']").val();

		if (name == null || name.length < 1) {
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}

		var value = "";
		if ($("input[name='phone2']").val() != ""
				&& $("input[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}

		//Debug...
		//alert("phone : "+value);
		$("input:hidden[name='phone']").val(value);

		$("form").attr("method", "POST").attr("action", "/user/updateUser")
				.submit();
	}
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

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="row">

			<!--  Menu 구성 Start /////////////////////////////////////-->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>
			<!--  Menu 구성 end /////////////////////////////////////-->

			<div class="page-header text-center">
				<h3 class=" text-info">회원정보수정</h3>
				<h5 class="text-muted">
					내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.
				</h5>
			</div>

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아
						이 디</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userId" name="userId"
							value="${user.userId }" placeholder="중복확인하세요" readonly> <span
							id="helpBlock" class="help-block"> <strong
							class="text-danger">아이디는 수정불가</strong>
						</span>
					</div>
				</div>

				<div class="form-group">
					<label for="password"
						class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="password"
							name="password" placeholder="변경비밀번호">
					</div>
				</div>

				<div class="form-group">
					<label for="password2"
						class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="password2"
							name="password2" placeholder="변경비밀번호 확인">
					</div>
				</div>

				<div class="form-group">
					<label for="userName"
						class="col-sm-offset-1 col-sm-3 control-label">이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="userName"
							name="userName" value="${user.userName}" placeholder="변경회원이름">
					</div>
				</div>

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="addr" name="addr"
							value="${user.addr}" placeholder="변경주소">
					</div>
				</div>

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
					<div class="col-sm-2">
						<select class="form-control" name="phone1" id="phone1">
							<option value="010"
								${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  }>010</option>
							<option value="011"
								${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  }>011</option>
							<option value="016"
								${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  }>016</option>
							<option value="018"
								${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  }>018</option>
							<option value="019"
								${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  }>019</option>
						</select>
					</div>
					<div class="col-sm-2">
						<input type="text" class="form-control" id="phone2" name="phone2"
							value="${ ! empty user.phone2 ? user.phone2 : ''}"
							placeholder="변경번호">
					</div>
					<div class="col-sm-2">
						<input type="text" class="form-control" id="phone3" name="phone3"
							value="${ ! empty user.phone3 ? user.phone3 : ''}"
							placeholder="변경번호">
					</div>
					<input type="hidden" name="phone" />
				</div>

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="email" name="email"
							value="${user.email}" placeholder="변경이메일">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">수 &nbsp;정</button>
						<a class="btn btn-primary btn" href="#" role="button">취
							&nbsp;소</a>
					</div>
				</div>
			</form>
			<!-- form Start /////////////////////////////////////-->
			
			<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>

		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>