<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">

	<div class="container">

		<a class="navbar-brand" href="/index.jsp">Doyoun Shop</a>

		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse"
				data-target="#target">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
		<div class="collapse navbar-collapse navbar-right" id="target">
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${ empty user }">
				<li><a href="#">ȸ������</a></li>
				</c:if>
				
				<!-- <li><a href="#">�� �� ��</a></li> -->
				<li><a href="#">${ !empty user ? "�α׾ƿ�" : "�α���" }</a></li>
			</ul>
		</div>
		
	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->



<script type="text/javascript">
	
	function cookieRemove() {
		
	    // ������ �����Ѵ�.
	    var date = new Date();
	    date.setDate(date.getDate() - 1);
	
	    var willCookie = "";
	    willCookie += "CookieName=Value;";
	    willCookie += "Expires=" + date.toUTCString();
	
	    // ��Ű�� ����ִ´�.
	    document.cookie = willCookie;
	}
	//============= ȸ�������� ȭ���̵� =============
	$(function() {
		//==> �߰��Ⱥκ� : "addUser"  Event ����
		$("a[href='#' ]:contains('ȸ������')").on("click", function() {
			self.location = "/user/addUser"
		});
	});

	//============= �α��� ȭ���̵� =============
	$(function() {
		
		//==> �߰��Ⱥκ� : "login"  Event ����
		$("a[href='#' ]:contains('�α���')").on("click", function() {
			self.location = "/user/login"
		});

		//==> �߰��� �κ� : "logout" Event ����
		$("a[href='#']:contains('�α׾ƿ�')").on("click", function() {
			cookieRemove();
			self.location = "/user/logout";
		});
	});
</script>
