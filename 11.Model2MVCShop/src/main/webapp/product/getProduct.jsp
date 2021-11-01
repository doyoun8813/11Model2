<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%@page import="com.model2.mvc.service.domain.User"%>

<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
--%>

<%-- <%
	Product product = (Product)request.getAttribute("product");
	String prodNo = request.getParameter("prodNo");
	String menu = request.getParameter("menu");
	System.out.println("menu : " + menu);
%> --%>	

<%-- <%
	/* �Ǵ°�
	String history = (String)session.getAttribute("history");
	System.out.println("history : "+ history);

	if(history == null){
		session.setAttribute("history", prodNo);
		Cookie cookie = new Cookie("history", prodNo);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		System.out.println("��Ű ���� �Ϸ�");
	}else{
		String changeHistory = history+","+request.getParameter("prodNo");
		System.out.println("changeHistory : " + changeHistory);
		session.setAttribute("history", changeHistory);
		Cookie cookie = new Cookie("history", changeHistory);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		System.out.println("��Ű ���� �Ϸ�");
	}
	*/
	
	String history = (String)session.getAttribute("history");
	System.out.println("history : "+ history);

	if(history == null){
		session.setAttribute("history", prodNo);
		Cookie cookie = new Cookie("history", prodNo);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		System.out.println("��Ű ���� �Ϸ�");
	}else{
		String changeHistory = history+","+request.getParameter("prodNo");
		String[] historyArr = changeHistory.split(",");
		Set<String> hashSet = new HashSet<String>(Arrays.asList(historyArr));
		System.out.println("hashSet : " + hashSet);
		String[] resultArr = hashSet.toArray(new String[0]);
		System.out.println("resultArr.length : " + resultArr.length);
		System.out.println("Arrays.toString(resultArr) : "+Arrays.toString(resultArr));
		//String arrArr = Arrays.toString(resultArr);
		//System.out.println("��Ʈ����Ʈ�� ��ȯ??��ȯ??" + arrArr);
		String changeHistoryArr = "";
		for(int i=0; i<resultArr.length; i++){
			if(i == resultArr.length-1){
				changeHistoryArr += resultArr[i];				
			}else{
				changeHistoryArr += resultArr[i]+",";				
			}
		}
		System.out.println("changeArr : " + changeHistoryArr);
		session.setAttribute("history",changeHistoryArr);
		Cookie cookie = new Cookie("history",changeHistoryArr);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		System.out.println("��Ű ���� �Ϸ�");
	}
%> --%>

<%-- <%
	User user = (User)session.getAttribute("user");
	
	String role="";
	System.out.println("user : " + user);
	if(user != null) {
		role=user.getRole();
		System.out.println(role);
	}
	
	System.out.println("getProduct role : " + role);
	
%> --%>

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>��ǰ����ȸ</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<%-- <td width="105"><%=product.getProdNo() %></td> --%>
					<td width="105">${product.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�̹��� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${product.fileName}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<c:if test="${!empty param.menu && param.menu=='search'}">
					<c:choose>
						<c:when test="${user.role == 'admin'}">
							<td width="30"></td>					
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:history.go(-1)">����</a>
							</td>
						</c:when>
						<c:otherwise>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="/purchase/addPurchase?prod_no=${product.prodNo}">����</a>
							</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							<td width="30"></td>					
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:history.go(-1)">����</a>
							</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${!empty param.menu && param.menu=='manage'}">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a href='/product/listProduct?menu=${param.menu=="search" ? "search" : "manage" }'>Ȯ��</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>

</body>
</html>