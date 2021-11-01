<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">

	<div class="container">

		<a class="navbar-brand" href="#">Model2 MVC Shop</a>

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

		<div class="collapse navbar-collapse" id="target">
			<ul class="nav navbar-nav navbar-right">
				
				<li><a href="#">ȸ������</a></li>
				<!-- <li><a href="#">�� �� ��</a></li> -->
				<li><a href="#">${ !empty user ? "�α׾ƿ�" : "�α���" }</a></li>
			</ul>
		</div>

	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->



<script type="text/javascript">
	//============= ȸ�������� ȭ���̵� =============
	$(function() {
		//==> �߰��Ⱥκ� : "addUser"  Event ����
		$("a[href='#' ]:contains('ȸ������')").on("click", function() {
			self.location = "/user/addUser"
		});
	});

	//============= �α��� ȭ���̵� =============
	$(function() {
		function history(){
			popWin = window.open("../history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
		
		//==> �߰��� �κ�: "listPurchase" Event ����
		$("a[href='#']:contains('�ֱٺ���ǰ')").on("click", function() {
			history();
		});
		
		//==> �߰��Ⱥκ� : "login"  Event ����
		$("a[href='#' ]:contains('�α���')").on("click", function() {
			self.location = "/user/login"
		});

		//==> �߰��� �κ� : "logout" Event ����
		$("a[href='#']:contains('�α׾ƿ�')").on("click", function() {
			self.location = "/user/logout";
		});
	});
</script>
