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
	//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/listUser")
				.submit();
	}

	//============= "�˻�"  Event  ó�� =============	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".search-btn").on("click", function() {
			fncGetList(1);
		});
	});

	//============= userId �� ȸ����������  Event  ó��(Click) =============	
	$(function() {

		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td:nth-child(2)").on(
				"click",
				function() {
					self.location = "/user/getUser?userId="
							+ $(this).text().trim() + "&paramRole=admin";
				});

		//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$("td:nth-child(2)").css("color", "red");

	});

	//============= userId �� ȸ����������  Event  ó�� (double Click)=============
	$(function() {

		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td:nth-child(5) > i").on(
				"click",
				function() {

					var userId = $(this).next().val();

					$.ajax({
						url : "/user/json/getUser/" + userId,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {

							var displayValue = "<h6>" + "���̵� : "
									+ JSONData.userId + "<br/>" + "��  �� : "
									+ JSONData.userName + "<br/>" + "�̸��� : "
									+ JSONData.email + "<br/>" + "ROLE : "
									+ JSONData.role + "<br/>" + "����� : "
									+ JSONData.regDateString + "<br/>"
									+ "</h6>";
							$("h6").remove();
							$("#" + userId + "").html(displayValue);
						}
					});
					////////////////////////////////////////////////////////////////////////////////////////////

				});

		//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$("h7").css("color", "red");

		//==> �Ʒ��� ���� ������ ������ ??
		$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
		
		//autocomplete
		
		$("#searchKeyword").autocomplete({
			source: function(request, response){
				console.log($("select[name='searchCondition']").val());
				console.log($("input[name='searchKeyword']").val());
				var searchCondition = $("select[name='searchCondition']").val();
				var searchKeyword = $("input[name='searchKeyword']").val();
				console.log(request);
				console.log(response);
				searchKeyword = escape(encodeURIComponent(searchKeyword));
				
				$.ajax({
					url:"/user/json/listUserAutocomplete/searchCondition="+searchCondition+"&searchKeyword="+searchKeyword,
					method: "GET",
					dataType: "json",
					headers: {
						"Accept": "application/json",
						"contentType": "application/json; charset=euc-kr"
					},
					success: function(JSONData, status){
						console.log(JSONData.list);
						response(
							$.map(JSONData.list, function(item){
								if(searchCondition == 0){
									return{
										label: item.userId,
										value: item.userId
									}
								}else if(searchCondition == 1){
									return{
										label: item.userName,
										value: item.userName
									}
								}
								
							})
						);
					},
					error: function(e){
						alert(e.responseText);
					}
				});
			},
			minLength: 1
		});
		
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header text-info">
			<h3>ȸ�������ȸ</h3>
		</div>

		<!-- table ���� �˻� Start /////////////////////////////////////-->
		<div class="row">

			<div class="col-md-6 text-left">
				<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�, ����
					${resultPage.currentPage} ������</p>
			</div>

			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm">

					<div class="form-group">
						<select class="form-control" name="searchCondition">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ȸ��ID</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>ȸ����</option>
						</select>
					</div>

					<div class="form-group">
						<label class="sr-only" for="searchKeyword">�˻���</label> <input
							type="text" class="form-control" id="searchKeyword"
							name="searchKeyword" placeholder="�˻���" autocomplete="off"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>

					<button type="button" class="btn btn-default search-btn">�˻�</button>

					<!-- PageNavigation ���� ������ ���� ������ �κ� -->
					<input type="hidden" id="currentPage" name="currentPage" value="" />

				</form>
			</div>

		</div>
		<!-- table ���� �˻� End /////////////////////////////////////-->


		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">ȸ�� ID</th>
					<th align="left">ȸ����</th>
					<th align="left">�̸���</th>
					<th align="left">��������</th>
				</tr>
			</thead>

			<tbody>

				<c:set var="i" value="0" />
				<c:forEach var="user" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${user.rowNum}</td>
						<td align="left" title="Click : ȸ������ Ȯ��">${user.userId}</td>
						<td align="left">${user.userName}</td>
						<td align="left">${user.email}</td>
						<td align="left"><i class="glyphicon glyphicon-ok"
							id="${user.userId}"></i> <input type="hidden"
							value="${user.userId}"></td>
					</tr>
				</c:forEach>

			</tbody>

		</table>
		<!--  table End /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->


	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp" />
	<!-- PageNavigation End... -->

</body>

</html>