package com.model2.mvc.web.user;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping( value="json/logout", method=RequestMethod.GET )
	public String logout( HttpSession session ) throws Exception{
		
		System.out.println("/user/json/logout : GET");
		
		session.invalidate();
		
		return "로그아웃";
		
	}
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public Map addUser( @RequestBody User user ) throws Exception {

		System.out.println("/user/json/addUser : POST");
		//Business Logic
		System.out.println("::"+user);
		userService.addUser(user);

		Map map = new HashMap();
		map.put("user", user);
		return map;
		
	}
	
	@RequestMapping( value="json/listUser" )
	public Map listUser( @RequestBody Search search, HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("UserRestController search : " + search);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId ) throws Exception{

		System.out.println("/user/json/updateUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public Map updateUser( @RequestBody User user , HttpSession session) throws Exception{

		System.out.println("/user/json/updateUser : POST");
		
		System.out.println("userRestController updateUer Post user Before : " + user);

		//Business Logic
		userService.updateUser(user);
		System.out.println("userRestController updateUer Post user After : " + user);
		
		Map map = new HashMap();
		map.put("user", user);
		return map;
	}
	
	@RequestMapping( value="/json/checkDuplication", method=RequestMethod.POST )
	public Map checkDuplication(
			/* @RequestBody String userId, */ @RequestBody User user, HttpSession session ) throws Exception{
		
		System.out.println("/user/json/checkDuplication : POST");
		
		//System.out.println("1111111111111111111 : " + userId);
		
		//System.out.println("22222222222222222222 : " + userId.getClass().getName());
		
		//userId = userId.replaceAll("\\\"","");
		
		//System.out.println("3333333333333333333333 : " + userId);
		System.out.println("RequestBody user.userId : " + user.getUserId());
		
		//Business Logic
		//boolean result = userService.checkDuplication(userId);
		boolean result = userService.checkDuplication(user.getUserId());
		
		Map map = new HashMap();
		map.put("result", new Boolean(result));
		
		return map;
	}
	
	@RequestMapping( value="/json/checkDuplication/{userId}", method=RequestMethod.GET )
	public Boolean checkDuplication( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/checkDuplication : GET");
		
		System.out.println("1111111111111111111 : " + userId);
		
		System.out.println("22222222222222222222 : " + userId.getClass().getName());
		
		//Business Logic
		boolean result = userService.checkDuplication(userId);
		
		return result;
	}
	
	@RequestMapping( value="json/findId", method=RequestMethod.POST )
	public Map findId( @RequestBody User user ) throws Exception{
	
		System.out.println("/user/json/findId : POST");
		//Business Logic
		System.out.println("::"+user);
		Map<String , Object> map = userService.findId(user.getUserName(), user.getEmail());
		
		return map;
	}
	
	@RequestMapping( value="json/findPassword", method=RequestMethod.POST )
	public Map findPassword( @RequestBody User user ) throws Exception{
	
		System.out.println("/user/json/findPassword : POST");
		//Business Logic
		System.out.println("::"+user);
		Map<String , Object> map = userService.findPassword(user.getUserId(), user.getUserName());
		
		return map;
	}
	
	@RequestMapping( value="json/listUserAutocomplete/searchCondition={searchCondition}&searchKeyword={searchKeyword}", method = RequestMethod.GET )
	public Map listUserAutocomplete( @ModelAttribute("search") Search search, HttpServletRequest request) throws Exception{
		
		System.out.println("listProduct request menu : " + search.getSearchCondition());
		System.out.println("listProduct request menu : " + search.getSearchKeyword());
		
		String searchCondition2 = search.getSearchCondition();
		String searchKeyword2 = search.getSearchKeyword();
		
		search.setSearchCondition(null);
		search.setSearchKeyword(null);
		
		System.out.println("/user/json/listUserAutocomplete : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		// Business logic 수행
		Map<String , Object> map = userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage" + resultPage);
		
String decText= URLDecoder.decode(searchKeyword2,"UTF-8");
		
		System.out.println(decText);
		search.setPageSize(((Integer) map.get("totalCount")).intValue());
		search.setSearchCondition(searchCondition2);
		search.setSearchKeyword(decText);
		Map<String , Object> map2 = userService.getUserList(search);
		
		// Model 과 View 연결
		map2.put("list", map2.get("list"));
		map2.put("resultPage", resultPage);
		map2.put("search", search);
		
		return map2;
	}
}