<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

	<title>��ǰ �����ȸ</title>
	
	<jsp:include page="/layout/head.jsp" />
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

	</style>
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
		   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
		}
		
		$(function(){
			//==> �˻� Event ����ó���κ�
			//$("td.ct_btn01:contains('�˻�')").on("click", function(){
			//	fncGetList(1);
			//});
			
			//==> ���� ������ menu �Ķ���� ��������
			var page_menu = "${param.menu}";
			//==> ���� ������ ���� ���� ��������
			var user_role = "${user.role}";
			
			//==> prodNo LINK Event ����ó��
			$("td:nth-child(2)").on("click", function(){
				var prodNo = $(this).attr("data-product").trim();
				
				if(user_role != null && user_role != "" && user_role.length != 0){
					if(page_menu == "manage"){
						self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}else if(page_menu == "search"){
						self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
					}
				}else{
					alert("ȸ���� �ƴϽñ���!\n�α��� �Ŀ� ���������� ���� �� �ֽ��ϴ�.");
				}
			});
			
			//==> �����ܿ� ��ǰ���� ���ܺ��� Ajax ó��
			$("td:nth-child(6) > i").on("click", function(){
				var prodNo = $(this).attr("id").trim();
				$(this).parent(".data_con").attr("id","dataCon"+prodNo);
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
							+"<li><strong>��ǰ��ȣ</strong> : "+JSONData.prodNo+"</li>"
							+"<li><strong>��ǰ��</strong> : "+JSONData.prodName+"</li>"
							+"<li><strong>��ǰ�̹���</strong> : <img width='80' src='/images/uploadFiles/"+JSONData.fileName+"'></li>"
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
									+"<li><strong>��ǰ��ȣ</strong> : "+JSONData.prodNo+"</li>"
									+"<li><strong>��ǰ��</strong> : "+JSONData.prodName+"</li>"
									+"<li><strong>��ǰ�̹���</strong> : "+JSONData.fileName+"</li>"
									+"<li><strong>��ǰ������</strong> : "+JSONData.prodDetail+"</li>"
									+"<li><strong>��������</strong> : "+JSONData.manuDate+"</li>"
									+"<li><strong>����</strong> : "+JSONData.price+"</li>"
									+"<li><strong>�������</strong> : "+JSONData.regDate+"</li>"
									+"<li><a href='/purchase/addPurchase?prod_no="+JSONData.prodNo+"'>�����ϱ�</a></li>"
									+"</ul>";
								$(".data_list").remove();
								$("#dataCon"+JSONData.prodNo).html(displayValue);
							}
						});
					}else{
						alert("ȸ���� �ƴϽñ���!\n�α��� �Ŀ� ���������� ���� �� �ֽ��ϴ�.");
					}
				}
			});*/
			
			//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$("td:nth-child(2)").css("color" , "red");
			$("h7").css("color" , "red");
			
			var obj = $("td:nth-child(5)");
			
			// �ǸŻ��� ���� jQuery ó��
			obj.each(function(index, elem){
				var prod_no = $(this).attr("data-product");
				var page_menu = "${param.menu}";
				if($(this).attr("data-trancode") == 1){
					var strDelivery = " <a href='/purchase/updateTranCodeByProd?prodNo="+prod_no+"&tranCode=2&page=${ !empty resultPage.currentPage ? search.currentPage : '' }'>����ϱ�</a>";
					$(this).text("���ſϷ�");
					if(page_menu == "manage"){
						$(this).append(strDelivery);
					}
					//console.log($(this).children("a").attr("href"));
					//self.location = $(this).children("a").attr("href");
				}else if($(this).attr("data-trancode") == 2){
					$(this).text("�����");
				}else if($(this).attr("data-trancode") == 3){
					$(this).text("��ۿϷ�");
				}else{
					$(this).text("�Ǹ���");
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			
			<!--  Menu ���� Start /////////////////////////////////////-->    
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>	
			<!--  Menu ���� end /////////////////////////////////////-->
			
			<!-- table ���� �˻� Start /////////////////////////////////////-->
				<div class="page-header text-info">
					<h3>${param.menu == "manage" ? "��ǰ����" : "��ǰ�����ȸ"}</h3>
		    	</div>
		    	
	   		<div class="row">
		    	<div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
			    	</p>
			    </div>
			    
			    <div class="col-md-6 text-right">
				    <form class="form-inline" name="detailForm">
				    
					  <div class="form-group">
					    <select class="form-control" name="searchCondition" >
							<option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
							<option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
							<option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
						</select>
					  </div>
					  
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">�˻���</label>
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <button type="button" class="btn btn-default">�˻�</button>
					  
					  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  
					</form>
		    	</div>
		    </div>
		    <!-- table ���� �˻� End /////////////////////////////////////-->
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" >
		    	<thead>
		    		<tr>
		    			<th align="center">No</th>
						<th align="left">��ǰ��</th>
						<th align="left">����</th>
						<th align="left">�����</th>	
						<th align="left">�������</th>
						<th align="left">��������</th>
		          	</tr>
		        </thead>
		       
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="product" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">${ i }</td>
							<td align="left" title="Click : ��ǰ���� Ȯ��" data-product="${product.prodNo}">
								${product.prodName}
							</td>
							<td align="left">${product.price}</td>
							<td align="left">${product.regDate}</td>
							<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}">
							<td align="left" class="data_con">
			  					<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  					<input type="hidden" value="${product.prodNo}">
			  				</td>
								<!-- �ǸŻ��� jQuery ���� -->
							</td>
						</tr>
					</c:forEach>
		        </tbody>
		    </table>
			<!--  table End /////////////////////////////////////-->
			
			<!-- PageNavigation Start... -->
			<jsp:include page="../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->
	    	
	    	<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->


</form>

</div>
</div>
</body>
</html>
