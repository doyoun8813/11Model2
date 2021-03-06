<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Doyoun Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근본상품</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
   		
	    function cookieRemove() {
	
	        // 변수를 선언한다.
	        var date = new Date();
	        date.setDate(date.getDate() - 1);
	
	        var willCookie = "";
	        willCookie += "CookieName=Value;";
	        willCookie += "Expires=" + date.toUTCString();
	
	        // 쿠키를 집어넣는다.
	        document.cookie = willCookie;
	    }
	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
		 		cookieRemove();
				$(this).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			function history(){
				popWin = window.open("../history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
			}
			
			//==> 추가된 부분: "listPurchase" Event 연결
			$("a[href='#']:contains('최근본상품')").on("click", function() {
				history();
			});
				
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				$(this).attr("href", "/user/listUser");
			}); 
		 
			//=============  개인정보조회회 Event  처리 =============	
		 	$( "a:contains('개인정보조회')" ).on("click" , function() {
		 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$(this).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
			});
			
		 	//=============  판매상품등록 Event  처리 =============	
		 	$( "a:contains('판매상품등록')" ).on("click" , function() {
		 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$(this).attr("href","/product/addProductView.jsp");
			});
		 	
		 	//=============  판매상품관리 Event  처리 =============	
		 	$( "a:contains('판매상품관리')" ).on("click" , function() {
		 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$(this).attr("href","/product/listProduct?menu=manage");
			});
		 	
		 	//=============  판매상품관리 Event  처리 =============	
		 	$( "a:contains('상 품 검 색')" ).on("click" , function() {
		 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$(this).attr("href","/product/listProduct?menu=search");
			});
		});
	</script>  