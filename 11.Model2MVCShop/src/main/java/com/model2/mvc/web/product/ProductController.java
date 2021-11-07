package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.user.UserService;


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	/* @RequestMapping("/addProductView.do") */ 
	@RequestMapping(value="addProduct", method=RequestMethod.GET) 
	public String addProductView() throws Exception {

		System.out.println("/product/addProductView : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	/* @RequestMapping("/addProduct.do") */
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, HttpServletRequest request ) throws Exception {
		
		if(FileUpload.isMultipartContent(request)) {
			/*String temDir = "G:\\bitcamp\\C_drive\\workspace_kdy\\01.Model2MVCShop(stu)\\src\\main\\webapp\\images\\uploadFiles\\";*/
			String temDir = "C:\\gitRepository\\11Model2\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
			
			String applicationPath = request.getServletContext().getRealPath("");
			String applicationPath2 = request.getServletContext().getRealPath("/");
			String applicationPath3 = request.getServletContext().getRealPath(request.getRequestURI());
			String uploadFilePath = applicationPath + "\\images\\uploadFiles\\";
			
			System.out.println("applicationPath : " + applicationPath);
			System.out.println("applicationPath2 : " + applicationPath2);
			System.out.println("applicationPath3 : " + applicationPath3);
			System.out.println("uploadFilePath : " + uploadFilePath);
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				System.out.println("fileupload fileItemList : " + fileItemList);
				System.out.println("fileupload Size : " + Size);
				for(int i = 0; i < Size; i++) {
					FileItem fileItem = (FileItem) fileItemList.get(i);
					System.out.println("fileupload fileItem : " + fileItem);
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							System.out.println("token ::" + token);
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							System.out.println("manuDate : " + manuDate);
							product.setManuDate(manuDate);
						}else if(fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}else if(fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}else if(fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					} else {
						//out.print("파일 : " + fileItem.getFieldName() + " = " + fileItem.getName());
						//out.pring("(" + fileItem.getSize() + " byte)<br>");
						
						if(fileItem.getSize() > 0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							}catch(IOException e) {
								System.out.println(e);
							}
						}else {
							product.setFileName("../../images/empty.GIF");
						}
					}// else
				}// for
				
				// RegDate 현재 날짜 구해서 임의로 넣기
				LocalDate now = LocalDate.now();
				Date sqlRegDate = java.sql.Date.valueOf(now);
				product.setRegDate(sqlRegDate);
				
				System.out.println("여기 product :: " + product);
					
				productService.addProduct(product);
			} else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alert('파일의 크기는 1MB까지입니다. 올리신 파일 용량은 " + overSize + "MB입니다.");
				System.out.println("history.back();</script>");
			}
			
		}else {
			System.out.println("인코딩 타입이 multipart/form-data가 아닙니다.");
		}
		
		/*
		 * 기존 소스
		System.out.println("/product/addProduct : POST");
		String manuDate = product.getManuDate();
		System.out.println("addProduct manuDate : " + manuDate);		
		String replaceManuDate = manuDate.replace("-", "");
		replaceManuDate = manuDate.replace("/", "");
		product.setManuDate(replaceManuDate);
		System.out.println("addProduct replaceManuDate : " + replaceManuDate);		
		
		//Business Logic
		productService.addProduct(product);
		*/
		
		return "forward:/product/addProduct.jsp";
	}
	
	/* @RequestMapping("/getProduct.do") */
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		// 최근 본 상품 시작
		
		String history = (String)session.getAttribute("history");
		System.out.println("history : "+ history);
		
		String strProdNo = Integer.toString(prodNo);

		if(history == null){
			session.setAttribute("history", strProdNo);
			Cookie cookie = new Cookie("history", strProdNo);
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
			System.out.println("쿠키 저장 완료");
		}else{
			String changeHistory = history+","+strProdNo;
			String[] historyArr = changeHistory.split(",");
			Set<String> hashSet = new HashSet<String>(Arrays.asList(historyArr));
			System.out.println("hashSet : " + hashSet);
			String[] resultArr = hashSet.toArray(new String[0]);
			System.out.println("resultArr.length : " + resultArr.length);
			System.out.println("Arrays.toString(resultArr) : "+Arrays.toString(resultArr));
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
			cookie.setPath("/");
			response.addCookie(cookie);
			System.out.println("쿠키 저장 완료");
		}
		// 최근 본 상품 끝
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}
	
	/* @RequestMapping("/updateProductView.do") */
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		System.out.println("updateProductView regDate : " + product.getRegDate());
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	/* @RequestMapping("/updateProduct.do") */
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , Model model , HttpSession session, HttpServletRequest request) throws Exception{
		
		int prodNo = 0;
		
		//Business Logic
		if(FileUpload.isMultipartContent(request)) {
			/*String temDir = "G:\\bitcamp\\C_drive\\workspace_kdy\\01.Model2MVCShop(stu)\\src\\main\\webapp\\images\\uploadFiles\\";*/
			String temDir = "C:\\gitRepository\\11Model2\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
			
			String applicationPath = request.getServletContext().getRealPath("");
			String applicationPath2 = request.getServletContext().getRealPath("/");
			String applicationPath3 = request.getServletContext().getRealPath(request.getRequestURI());
			String uploadFilePath = applicationPath + "\\images\\uploadFiles\\";
			
			System.out.println("applicationPath : " + applicationPath);
			System.out.println("applicationPath2 : " + applicationPath2);
			System.out.println("applicationPath3 : " + applicationPath3);
			System.out.println("uploadFilePath : " + uploadFilePath);
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				System.out.println("fileupload fileItemList : " + fileItemList);
				System.out.println("fileupload Size : " + Size);
				for(int i = 0; i < Size; i++) {
					FileItem fileItem = (FileItem) fileItemList.get(i);
					System.out.println("fileupload fileItem : " + fileItem);
					if(fileItem.isFormField()) {
						System.out.println("111111111111");
						if(fileItem.getFieldName().equals("manuDate")) {
							System.out.println("222222222222222");
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							System.out.println("token ::" + token);
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							System.out.println("manuDate : " + manuDate);
							product.setManuDate(manuDate);
						}else if(fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}else if(fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}else if(fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}else if(fileItem.getFieldName().equals("prodNo")) {
							product.setProdNo(Integer.parseInt(fileItem.getString("euc-kr")));
							prodNo = Integer.parseInt(fileItem.getString("euc-kr"));
						}
					} else {
						//out.print("파일 : " + fileItem.getFieldName() + " = " + fileItem.getName());
						//out.pring("(" + fileItem.getSize() + " byte)<br>");
						
						if(fileItem.getSize() > 0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							}catch(IOException e) {
								System.out.println(e);
							}
						}else {
							product.setFileName("../../images/empty.GIF");
						}
					}// else
				}// for
				
				System.out.println("여기 product :: " + product);
					
				productService.updateProduct(product);
			} else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alert('파일의 크기는 1MB까지입니다. 올리신 파일 용량은 " + overSize + "MB입니다.");
				System.out.println("history.back();</script>");
			}
			
		}else {
			System.out.println("인코딩 타입이 multipart/form-data가 아닙니다.");
		}		
		
		System.out.println("updateProduct prodNo : " + prodNo);
		Product productwo = productService.getProduct(prodNo);
		Date regDate = productwo.getRegDate();
		product.setRegDate(regDate);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp?menu=manage";

		/*
		 * 기존 소스
		System.out.println("/product/updateProduct : POST");
		int prodNo = product.getProdNo();
		Product productwo = productService.getProduct(prodNo);
		Date regDate = productwo.getRegDate();
		String strRegDate = regDate.toString();
		System.out.println(product);
		System.out.println("updateProduct strRegDate : " + strRegDate);
		
		//Business Logic
		productService.updateProduct(product);
		
		product.setRegDate(regDate);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp?menu=manage";
		*/
	}
	
	/* @RequestMapping("/listProduct.do") */
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("listProduct request menu : " + request.getParameter("menu"));
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
}