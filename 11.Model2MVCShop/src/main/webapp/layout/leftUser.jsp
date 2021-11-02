<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!--  Menu ���� Start /////////////////////////////////////-->
<div class="col-md-2">

	<!--  ȸ������ ��Ͽ� ���� -->
	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-heart"></i> ȸ������
		</div>
		<!--  ȸ������ ������ -->
		<ul class="list-group">
			<li class="list-group-item"><a href="#">����������ȸ</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
			<!-- <li class="list-group-item">
				 	<a href="#">ȸ��������ȸ</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li> -->
		</ul>
	</div>


	<!-- <div class="panel panel-primary">
			<div class="panel-heading">
				<i class="glyphicon glyphicon-briefcase"></i> �ǸŻ�ǰ����
   			</div>
			<ul class="list-group">
				 <li class="list-group-item">
				 	<a href="#">�ǸŻ�ǰ���</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li>
				 <li class="list-group-item">
				 	<a href="#">�ǸŻ�ǰ����</a> <i class="glyphicon glyphicon-ban-circle"></i>
				 </li>
			</ul>
       </div> -->


	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-shopping-cart"></i> ��ǰ����
		</div>
		<ul class="list-group">
			<li class="list-group-item"><a href="#">��ǰ�˻�</a></li>
			<li class="list-group-item"><a href="#">�����̷���ȸ</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
			<li class="list-group-item"><a href="#">�ֱٺ���ǰ</a> <i
				class="glyphicon glyphicon-ban-circle"></i></li>
		</ul>
	</div>

</div>
<!--  Menu ���� end /////////////////////////////////////-->



<script type="text/javascript">

	//==> �߰��� �κ� : "listProduct" Event ����
	$("a[href='#']:contains('��ǰ�˻�')").on("click", function() {
		$(this).attr("href", "/product/listProduct?menu=search");
	});

	console.log("user : ${user}");
	if ("${user}") {
		//alert("�α��� ��");
		
		//==> ���� glipycon �α��ν� ���ֱ�
		$(".list-group-item").children("i").hide();
		
		//==> �߰��� �κ�: "getUser" Event ����
		$("a[href='#']:contains('����������ȸ')").on("click", function() {
			$(this).attr("href", "/user/getUser?userId=${user.userId}");
		});
		
		//==> �߰��� �κ�: "listPurchase" Event ����
		$("a[href='#']:contains('�����̷���ȸ')").on("click", function() {
			$(this).attr("href", "/purchase/listPurchase");
		});
		
	} else {
		//alert("�α��� ����");
	}
</script>
