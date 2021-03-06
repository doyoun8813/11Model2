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
	//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/listUser")
				.submit();
	}

	//============= "검색"  Event  처리 =============	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".search-btn").on("click", function() {
			fncGetList(1);
		});
	});

	//============= userId 에 회원정보보기  Event  처리(Click) =============	
	$(function() {

		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td:nth-child(2)").on(
				"click",
				function() {
					self.location = "/user/getUser?userId="
							+ $(this).text().trim() + "&paramRole=admin";
				});

		//==> userId LINK Event End User 에게 보일수 있도록 
		$("td:nth-child(2)").css("color", "red");

	});

	//============= userId 에 회원정보보기  Event  처리 (double Click)=============
	$(function() {

		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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

							var displayValue = "<h6>" + "아이디 : "
									+ JSONData.userId + "<br/>" + "이  름 : "
									+ JSONData.userName + "<br/>" + "이메일 : "
									+ JSONData.email + "<br/>" + "ROLE : "
									+ JSONData.role + "<br/>" + "등록일 : "
									+ JSONData.regDateString + "<br/>"
									+ "</h6>";
							$("h6").remove();
							$("#" + userId + "").html(displayValue);
						}
					});
					////////////////////////////////////////////////////////////////////////////////////////////

				});

		//==> userId LINK Event End User 에게 보일수 있도록 
		$("h7").css("color", "red");

		//==> 아래와 같이 정의한 이유는 ??
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

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header text-info">
			<h3>회원목록조회</h3>
		</div>

		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">

			<div class="col-md-6 text-left">
				<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>

			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm">

					<div class="form-group">
						<select class="form-control" name="searchCondition">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
						</select>
					</div>

					<div class="form-group">
						<label class="sr-only" for="searchKeyword">검색어</label> <input
							type="text" class="form-control" id="searchKeyword"
							name="searchKeyword" placeholder="검색어" autocomplete="off"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>

					<button type="button" class="btn btn-default search-btn">검색</button>

					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value="" />

				</form>
			</div>

		</div>
		<!-- table 위쪽 검색 End /////////////////////////////////////-->


		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">회원 ID</th>
					<th align="left">회원명</th>
					<th align="left">이메일</th>
					<th align="left">간략정보</th>
				</tr>
			</thead>

			<tbody>

				<c:set var="i" value="0" />
				<c:forEach var="user" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${user.rowNum}</td>
						<td align="left" title="Click : 회원정보 확인">${user.userId}</td>
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
	<!--  화면구성 div End /////////////////////////////////////-->


	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp" />
	<!-- PageNavigation End... -->

</body>

</html>