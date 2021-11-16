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
			$(".search-btn").on("click", function(){
				fncGetList(1);
			});
			
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
			
			$(".thumbnail h4 span").on("click", function(){
				var prodNo = $(this).parents(".caption").attr("data-product").trim();
				
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
			
			$(".btn.btn-primary:contains('�󼼺���')").on("click", function(e){
				e.preventDefault();
				var prodNo = $(this).parents(".caption").attr("data-product").trim();
				
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
			
			var obj2 = $(".thumbnail .caption");
			
			obj2.each(function(index, elem){
				var prod_no = $(this).attr("data-product");
				var page_menu = "${param.menu}";
				if($(this).attr("data-trancode") == 1){
					var strDelivery = "<a href='/purchase/updateTranCodeByProd?prodNo="+prod_no+"&tranCode=2&page=${ !empty resultPage.currentPage ? search.currentPage : '' }' class='btn btn-default' role='button'>����ϱ�</a>";
					$(this).find(".delivery-label").text("���ſϷ�");
					$(this).find(".delivery-label").attr("class","label label-success delivery-label");
					if(page_menu == "manage"){
						$(this).find(".delivery_div").append(strDelivery);
					}
					//console.log($(this).children("a").attr("href"));
					//self.location = $(this).children("a").attr("href");
				}else if($(this).attr("data-trancode") == 2){
					$(this).find(".delivery-label").text("�����");
					$(this).find(".delivery-label").attr("class","label label-info delivery-label");
				}else if($(this).attr("data-trancode") == 3){
					$(this).find(".delivery-label").text("��ۿϷ�");
					$(this).find(".delivery-label").attr("class","label label-warning delivery-label");
				}else{
					$(this).find(".delivery-label").text("�Ǹ���");
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			
			<!--  Menu ���� Start /////////////////////////////////////-->    
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				<jsp:include page="/layout/leftUser.jsp" />
				<div class="col-md-10">
			</c:if>	
			<!--  Menu ���� end /////////////////////////////////////-->
			
			<div class="page-header text-info">
				<h3>${param.menu == "manage" ? "��ǰ����" : "��ǰ�����ȸ"}</h3>
	    	</div>
		    	
			<!-- table ���� �˻� Start /////////////////////////////////////-->
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
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <button type="button" class="btn btn-default search-btn">�˻�</button>
					  
					  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  
					</form>
		    	</div>
		    </div>
		    <!-- table ���� �˻� End /////////////////////////////////////-->
		    
		    <!--  table Start /////////////////////////////////////-->
		    <table class="table table-hover table-striped" style="display:none;">
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
							<td align="center">${product.rowNum}</td>
							<td align="left" title="Click : ��ǰ���� Ȯ��" data-product="${product.prodNo}">
								${product.prodName}
							</td>
							<td align="left">${product.price}</td>
							<td align="left">${product.regDate}</td>
							<td align="left" data-trancode="${product.proTranCode}" data-product="${product.prodNo}"><!-- �ǸŻ��� jQuery ���� --></td>
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
			<div class="row">
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
						        <h4><span title="Click : ��ǰ���� Ȯ��">${product.prodName}</span></h4>
						        <div class="row">
						        	<p class="col-sm-8 col-md-6">���� : ${product.price}</p>
						        	<p class="col-sm-4 col-md-6 text-right">${product.regDate}</p>
						        </div>
						        <div class="row">
						        	<div class="col-md-6"><a href="#" class="btn btn-primary" role="button">�󼼺���</a> </div>
						        	<div class="col-md-6 text-right delivery_div" ><a href="#" class="btn btn-default" role="button">����ϱ�</a></div>
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
	    	
	    	<!-- �����ڴ�, ���� ���̾ƿ� ���� -->
			<c:if test="${ user.role != 'admin' && user.role != 'manager' }">
				</div>
			</c:if>	
			
		</div>
	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

</body>
</html>
