<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>상품등록</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncAddProduct(){
		
		//==> 유효성 체크
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			$("input[name='prodName']").focus();
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			$("input[name='prodDetail']").focus();
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			$("input[name='manuDate']").focus();
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			$("input[name='price']").focus();
			return;
		}
		
		//==> submit 기능
		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	}
	
	$(function() {
		
		//==> Form Submit 처리
		$("button.btn-primary").on("click", function(){
			fncAddProduct();
		});
		
		//==> manuDate datepicker 
		$("#manuDate").datepicker({
		});
		
		//==> manuDate '/' CSV change '-'
		$("#manuDate").on("change", function(){
			var manuVal = $(this).val();
			//alert(manuVal);
			var manuValChg = manuVal.replaceAll("/", "-");
			//alert(manuValChg);
			$(this).val(manuValChg);
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
	
		<div class="row">
		
			<div class="page-header text-center">
				<h3 class=" text-info">상 품 등 록</h3>
				<h5 class="text-muted">
					새로운 <strong class="text-danger">제품을 등록</strong>해 주세요.
				</h5>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">

				<div class="form-group">
					<label for="prodName"
						class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodName"
							name="prodName" placeholder="상품명">
					</div>
				</div>
				
				<div class="form-group">
					<label for="prodDetail"
						class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodDetail"
							name="prodDetail" placeholder="상품상세정보">
					</div>
				</div>
				
				<div class="form-group">
					<label for="manuDate"
						class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="manuDate"
							name="manuDate" readonly="readonly" placeholder="상품제조일자">
					</div>
				</div>
				
				<div class="form-group">
					<label for="price"
						class="col-sm-offset-1 col-sm-3 control-label">가격</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="price"
							name="price" placeholder="상품가격">
					</div>
				</div>
				
				<div class="form-group">
					<label for="fileName"
						class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
					<div class="col-sm-4">
						<input type="file" id="fileName"
							name="fileName" placeholder="상품이미지">
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">등 록</button>
						<button type="reset" class="btn btn-default">취 소</button>
					</div>
				</div>
			
			</form>
		
		</div>
		
	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</form>
</body>
</html>
