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
			//$("td.ct_btn01:contains('검색')").on("click", function(){
			//	fncGetList(1);
			//});
			
			//==> 현제 페이지 menu 파라미터 가져오기
			var page_menu = "${param.menu}";
			
			//==> prodNo LINK Event 연결처리
			$("td:nth-child(2)").on("click", function(){
				var prodNo = $(this).attr("data-product").trim();
				
				if(page_menu == "manage"){
					self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
				}else if(page_menu == "search"){
					self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
				}
			});
			
			//==> 아이콘에 상품정보 간단보기 Ajax 처리
			$("td:nth-child(6) > i").on("click", function(){
				var prodNo = $(this).attr("id").trim();
				$.ajax({
					url: "/product/json/updateProduct"
				})
			});
			$(".ct_list_pop td:nth-child(3)").on("click", function(){
				var prodNo = $(this).attr("data-product").trim();
				var page_menu = "${param.menu}";
				$(this).parent(".ct_list_pop").next(".data_con").children("td").attr("id","dataCon"+prodNo);
				//console.log(prodNo);
				//console.log("${param.menu}");
				var user_role = "${user.role}";
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
			});
			
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$(".ct_list_pop td:nth-child(3)").css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)").css("background-color" , "whitesmoke");
			
			var obj = $(".ct_list_pop td:nth-child(9)");
			
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
			
			<!-- table 위쪽 검색 Start /////////////////////////////////////-->
				<div class="page-header text-info">
					<h3>${param.menu == "manage" ? "상품관리" : "상품목록조회"}</h3>
		    	</div>
		    	
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
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <button type="button" class="btn btn-default">검색</button>
					  
					  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  
					</form>
		    	</div>
		    </div>
		    <!-- table 위쪽 검색 End /////////////////////////////////////-->
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" >
		    	<thead>
		    		<tr>
		    			<td align="center">No</td>
						<td align="left">상품명</td>
						<td align="left">가격</td>
						<td align="left">등록일</td>	
						<td align="left">현재상태</td>
		          	</tr>
		        </thead>
		       
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="product" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">${ i }</td>
							<td align="left" title="Click : 제품정보 확인" data-product="${product.prodNo}">
								${product.prodName}
							</td>
							<td align="left">${product.price}</td>
							<td align="left">${product.regDate}</td>
							<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}">
							<td align="left">
			  					<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  					<input type="hidden" value="${product.prodNo}">
			  				</td>
								<!-- 판매상태 jQuery 구현 -->
							</td>
						</tr>
					</c:forEach>
		        </tbody>
		    </table>
			<!--  table End /////////////////////////////////////-->
	    	
	    	<!-- 관리자단, 유저 레이아웃 구조 -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->
	
	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->



<div style="display:none;">

<div style="width:98%; margin-left:10px;">

<!-- <form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">-->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${param.menu == "manage" ? "상품관리" : "상품목록조회"}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select>
			<input type="text" name="searchKeyword" value="${ !empty search.searchKeyword ? search.searchKeyword : '' }" class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left" data-product="${product.prodNo}">
				${product.prodName}
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
			<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}">
				<!-- 판매상태 jQuery 구현 -->
			</td>
		</tr>
		<tr class="data_con">
			<td colspan="9" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<!-- PageNavigation Start -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!-- PageNavigation End -->


</form>

</div>
</div>
</body>
</html>
