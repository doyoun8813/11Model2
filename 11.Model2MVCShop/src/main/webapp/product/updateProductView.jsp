<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<title>상품정보수정</title>

<jsp:include page="/layout/head.jsp" />

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

function fncUpdateProduct(){
	
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
	$("form").attr("method", "POST").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
}

$(function(){
	
	//==> Form Submit 처리
	$("button.btn-primary").on("click", function(){
		fncUpdateProduct();
	});
	
	//==> manuDate datepicker 
	$("#manuDate").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	/*
	//==> manuDate '/' CSV change '-'
	$("#manuDate").on("change", function(){
		var manuVal = $(this).val();
		//alert(manuVal);
		var manuValChg = manuVal.replaceAll("/", "-");
		//alert(manuValChg);
		$(this).val(manuValChg);
	});
	*/
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
				<h3 class=" text-info">상 품 수 정</h3>
				<h5 class="text-muted">
					기존의 <strong class="text-danger">제품을 수정</strong>해 주세요.
				</h5>
			</div>
			
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
				<input type="hidden" name="prodNo" value="${product.prodNo}"/>

				<div class="form-group">
					<label for="prodName"
						class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodName"
							name="prodName" placeholder="상품명" value="${product.prodName}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="prodDetail"
						class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodDetail"
							name="prodDetail" placeholder="상품상세정보" value="${product.prodDetail}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="manuDate"
						class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="manuDate"
							name="manuDate" readonly="readonly" placeholder="상품제조일자" value="${product.manuDate}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="price"
						class="col-sm-offset-1 col-sm-3 control-label">가격</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="price" name="price" placeholder="상품가격" value="${product.price}">
					</div>
				</div>
				
				<div class="form-group">
					<label for="fileName"
						class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
					<div class="col-sm-4">
						<input type="file" id="fileName" name="fileName" placeholder="상품이미지">
						<p class="help-block">기존 이미지 : ${product.fileName}</p>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4  col-sm-4 text-center">
						<button type="button" class="btn btn-primary">수 정</button>
						<button type="button" class="btn btn-default">이 전</button>
					</div>
				</div>
			
			</form>
			
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>

</div>