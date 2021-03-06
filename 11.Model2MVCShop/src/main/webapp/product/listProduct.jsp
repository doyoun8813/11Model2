<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

	<title>상품 목록조회</title>
	
	<jsp:include page="/layout/head.jsp" />
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

	</style>
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
		   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
		}
		
		$(function(){
			//==> 검색 Event 연결처리부분
			$(".search-btn").on("click", function(){
				fncGetList(1);
			});
			
			//==> 현재 페이지 menu 파라미터 가져오기
			var page_menu = "${param.menu}";
			//==> 현재 페이지 유저 정보 가져오기
			var user_role = "${user.role}";
			
			//==> prodNo LINK Event 연결처리
			$("td:nth-child(2)").on("click", function(){
				var prodNo = $(this).attr("data-product").trim();
				
				if(user_role != null && user_role != "" && user_role.length != 0){
					if(page_menu == "manage"){
						self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}else if(page_menu == "search"){
						self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}
				}else{
					alert("회원이 아니시군요!\n로그인 후에 상세페이지를 보실 수 있습니다.");
				}
			});
			
			$(".thumbnail h4 span").on("click", function(){
				var prodNo = $(this).parents(".caption").attr("data-product").trim();
				
				if(user_role != null && user_role != "" && user_role.length != 0){
					if(page_menu == "manage"){
						self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}else if(page_menu == "search"){
						self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}
				}else{
					alert("회원이 아니시군요!\n로그인 후에 상세페이지를 보실 수 있습니다.");
				}
			});
			
			$(".btn.btn-primary:contains('상세보기')").on("click", function(e){
				e.preventDefault();
				var prodNo = $(this).parents(".caption").attr("data-product").trim();
				
				if(user_role != null && user_role != "" && user_role.length != 0){
					if(page_menu == "manage"){
						self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}else if(page_menu == "search"){
						self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}
				}else{
					alert("회원이 아니시군요!\n로그인 후에 상세페이지를 보실 수 있습니다.");
				}
			});
			
			$(".btn.btn-primary:contains('상품수정')").on("click", function(e){
				e.preventDefault();
				var prodNo = $(this).parents(".caption").attr("data-product").trim();
				
				if(user_role != null && user_role != "" && user_role.length != 0){
					if(page_menu == "manage"){
						self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}else if(page_menu == "search"){
						self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}
				}else{
					alert("회원이 아니시군요!\n로그인 후에 상세페이지를 보실 수 있습니다.");
				}
			});
			
			//==> 아이콘에 상품정보 간단보기 Ajax 처리
			$("td:nth-child(6) > i").on("click", function(){
				var prodNo = $(this).attr("id").trim();
				$(this).parent(".data_con").attr("id","dataCon"+prodNo);
				$.ajax({
					url: "/product/json/getProduct/"+prodNo,
					method: "GET",
					dataType: "json",
					headers: {
						"Accept": "application/json",
						"Content-Type": "application/json"
					},
					success: function(JSONData, status){
						console.log(JSONData.prodNo);
						var displayValue = 
							"<ul class='data_list'>"
							+"<li><strong>상품번호</strong> : "+JSONData.prodNo+"</li>"
							+"<li><strong>상품명</strong> : "+JSONData.prodName+"</li>"
							+"<li><strong>상품이미지</strong> : <img width='80' src='/images/uploadFiles/"+JSONData.fileName+"'></li>"
							+"</ul>";
						$(".data_list").remove();
						$("#dataCon"+JSONData.prodNo).append(displayValue);
					}
				});
			});
			/*$("td:nth-child(3)").on("click", function(){
				var prodNo = $(this).attr("data-product").trim();
				$(this).parent(".ct_list_pop").next(".data_con").children("td").attr("id","dataCon"+prodNo);
				//console.log(prodNo);
				//console.log("${param.menu}");
				//console.log(user_role);
				//console.log(user_role.length);
				if(page_menu == "manage"){
					self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
				}else if(page_menu == "search"){
					if(user_role != null && user_role != "" && user_role.length != 0){
						//self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
						$.ajax({
							url: "/product/json/updateProduct/"+prodNo,
							method: "GET",
							dataType: "json",
							headers: {
								"Accept": "application/json",
								"Content-Type": "application/json"
							},
							success: function(JSONData, status){
								console.log(JSONData.prodNo);
								var displayValue = 
									"<ul class='data_list'>"
									+"<li><strong>상품번호</strong> : "+JSONData.prodNo+"</li>"
									+"<li><strong>상품명</strong> : "+JSONData.prodName+"</li>"
									+"<li><strong>상품이미지</strong> : "+JSONData.fileName+"</li>"
									+"<li><strong>상품상세정보</strong> : "+JSONData.prodDetail+"</li>"
									+"<li><strong>제조일자</strong> : "+JSONData.manuDate+"</li>"
									+"<li><strong>가격</strong> : "+JSONData.price+"</li>"
									+"<li><strong>등록일자</strong> : "+JSONData.regDate+"</li>"
									+"<li><a href='/purchase/addPurchase?prod_no="+JSONData.prodNo+"'>구매하기</a></li>"
									+"</ul>";
								$(".data_list").remove();
								$("#dataCon"+JSONData.prodNo).html(displayValue);
							}
						});
					}else{
						alert("회원이 아니시군요!\n로그인 후에 상세페이지를 보실 수 있습니다.");
					}
				}
			});*/
			
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$("td:nth-child(2)").css("color" , "red");
			$("h7").css("color" , "red");
			
			var obj = $("td:nth-child(5)");
			
			// 판매상태 변경 jQuery 처리
			obj.each(function(index, elem){
				var prod_no = $(this).attr("data-product");
				var page_menu = "${param.menu}";
				if($(this).attr("data-trancode") == 1){
					var strDelivery = " <a href='/purchase/updateTranCodeByProd?prodNo="+prod_no+"&tranCode=2&page=${ !empty resultPage.currentPage ? search.currentPage : '' }'>배송하기</a>";
					$(this).text("구매완료");
					if(page_menu == "manage"){
						$(this).append(strDelivery);
					}
					//console.log($(this).children("a").attr("href"));
					//self.location = $(this).children("a").attr("href");
				}else if($(this).attr("data-trancode") == 2){
					$(this).text("배송중");
				}else if($(this).attr("data-trancode") == 3){
					$(this).text("배송완료");
				}else{
					$(this).text("판매중");
				}
			});
			
			var obj2 = $(".thumbnail .caption");
			
			obj2.each(function(index, elem){
				var prod_no = $(this).attr("data-product");
				var page_menu = "${param.menu}";
				if($(this).attr("data-trancode") == 1){
					var strDelivery = "<a href='/purchase/updateTranCodeByProd?prodNo="+prod_no+"&tranCode=2&page=${ !empty resultPage.currentPage ? search.currentPage : '' }' class='btn btn-default' role='button'>배송하기</a>";
					$(this).find(".delivery-label").text("구매완료");
					$(this).find(".delivery-label").attr("class","label label-success delivery-label");
					if(page_menu == "manage"){
						$(this).find(".delivery_div").append(strDelivery);
					}
					//console.log($(this).children("a").attr("href"));
					//self.location = $(this).children("a").attr("href");
				}else if($(this).attr("data-trancode") == 2){
					$(this).find(".delivery-label").text("배송중");
					$(this).find(".delivery-label").attr("class","label label-info delivery-label");
				}else if($(this).attr("data-trancode") == 3){
					$(this).find(".delivery-label").text("배송완료");
					$(this).find(".delivery-label").attr("class","label label-warning delivery-label");
				}else{
					$(this).find(".delivery-label").text("판매중");
					$(this).find(".delivery-label").attr("class","label label-primary delivery-label");
				}
			});
			
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
						url:"/product/json/listProductAutocomplete/searchCondition="+searchCondition+"&searchKeyword="+searchKeyword,
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
											label: item.prodNo,
											value: item.prodNo
										}
									}else if(searchCondition == 1){
										return{
											label: item.prodName,
											value: item.prodName
										}
									}else if(searchCondition == 2){
										return{
											label: item.price,
											value: item.price
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
			
			<div class="page-header text-info">
				<h3>${param.menu == "manage" ? "상품관리" : "상품목록조회"}</h3>
	    	</div>
		    	
			<!-- table 위쪽 검색 Start /////////////////////////////////////-->
	   		<div class="row">
		    	<div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
			    	</p>
			    </div>
			    
			    <div class="col-md-6 text-right">
				    <form class="form-inline" name="detailForm">
				    
					  <div class="form-group">
					    <select class="form-control" name="searchCondition" >
							<option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
							<option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
						</select>
					  </div>
					  
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <button type="button" class="btn btn-default search-btn">검색</button>
					  
					  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  
					</form>
		    	</div>
		    </div>
		    <!-- table 위쪽 검색 End /////////////////////////////////////-->
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" style="display:none;">
		    	<thead>
		    		<tr>
		    			<th align="center">No</th>
						<th align="left">상품명</th>
						<th align="left">가격</th>
						<th align="left">등록일</th>	
						<th align="left">현재상태</th>
						<th align="left">간략정보</th>
		          	</tr>
		        </thead>
		       
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="product" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">${product.rowNum}</td>
							<td align="left" title="Click : 제품정보 확인" data-product="${product.prodNo}">
								${product.prodName}
							</td>
							<td align="left">${product.price}</td>
							<td align="left">${product.regDate}</td>
							<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}"><!-- 판매상태 jQuery 구현 --></td>
							<td align="left" class="data_con">
			  					<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  					<input type="hidden" value="${product.prodNo}">
			  				</td>
						</tr>
					</c:forEach>
		        </tbody>
		    </table>
			<!--  table End /////////////////////////////////////-->
			
			<!-- row Start!! -->
			<div class="row prod-list-wrap">
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<div class="col-sm-6 col-md-4">
						<div class="thumbnail">
							<div class="img-wrap">
								<img src="/images/uploadFiles/${product.fileName}">
							</div>
							<div class="caption" data-trancode="${product.proTranCode}" data-product="${product.prodNo}">
								<span class="label label-default">No.${product.rowNum}</span> <span class="label label-primary delivery-label"></span>
						        <h4><span title="Click : 제품정보 확인">${product.prodName}</span></h4>
						        <div class="row">
						        	<p class="col-sm-8 col-md-6">가격 : ${product.price}</p>
						        	<p class="col-sm-4 col-md-6 text-right">${product.regDate}</p>
						        </div>
						        <div class="row">
						        	<div class="col-md-6"><a href="#" class="btn btn-primary" role="button">${param.menu == "manage" ? "상품수정" : "상세보기"}</a> </div>
						        	<div class="col-md-6 text-right delivery_div" ><!-- <a href="#" class="btn btn-default" role="button">배송하기</a> --></div>
						        </div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- row End!! -->
			
			<!-- PageNavigation Start... -->
			<jsp:include page="../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->
	    	
	    	<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->

</body>
</html>
