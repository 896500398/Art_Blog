package com.luotf.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.luotf.model.RResource;
import com.luotf.service.ResourceService;



@Controller
@RequestMapping(value = "/admin")
public class ResourceController {

	@Resource(name = "resourceServiceImpl")
	private ResourceService resourceService;
	
	/**
	  * 实现添加资源功能
	  * @param resource
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/addResource",method = RequestMethod.POST)
	 @ResponseBody
	 public Map addResource(RResource resource) throws Exception{
		 Map map=new HashMap();
		 resource.setAddtime(new Date());
		 if(resourceService.insert(resource)!=0){
			 map.put("status", 200);
		}else{
			 //0表示：插入失败
			 map.put("status", 0);
		 }
		 return map;
	 }
	 
	 /**
	  * 更新资源功能
	  * @param resource
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/updateResource",method = RequestMethod.POST)
	 @ResponseBody
	 public Map updateResource(RResource resource) throws Exception{
		 Map map=new HashMap();
		 if(resourceService.updateByPrimaryKeySelective(resource)!=0){
			 map.put("status", 200);
		 }else{
			 //0表示：更新失败
			 map.put("status", 0);
		 }
		 return map;
	 }
	 
	 /**
	  * 实现删除资源功能
	  * @param id
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/deleteResource",method = RequestMethod.POST)
	 @ResponseBody
	 public Map deleteResource(Integer id) throws Exception{
		 Map map=new HashMap();
		 if(resourceService.deleteByPrimaryKey(id)!=0){
			 map.put("status", 200);
		 }else{
			 //0表示：删除失败
			 map.put("status", 0);
		 }
		 return map;
	 }
	 
	 /**
	  * 按博客id查询资源信息
	  * @param id
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/selectResourcecById",method = RequestMethod.POST)
	 @ResponseBody
	 public Map selectResourceById(Integer id) throws Exception{
		 Map map=new HashMap();
		 RResource resource=resourceService.selectByPrimaryKey(id);
		 if(resource!=null){
			 map.put("status", 200);
		 }else{
			 //500表示：返回值为Null
			 map.put("status", 500);
		 }
		 map.put("resource", resource);
		 return map;
	 }
	 
	 
	 
	 /**
	  * 模糊组合分页查询资源信息
	  * @param id，resource
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/selectLikeResourceListByPage")
	 @ResponseBody
	 public Map selectLikeResourceListByPage(RResource resource,@RequestParam(value="page", required=true,defaultValue="1") Integer page,@RequestParam(value="pageSize", required=true,defaultValue="9") Integer pageSize) throws Exception{
		 Map map=new HashMap();
		 if(resource.getTitle()!=null&&resource.getTitle()!=""){
			 map.put("title", resource.getTitle());
		 }
		 if(resource.getContent()!=null&&resource.getContent()!=""){
			 map.put("content", resource.getContent());
		 }
		 if(resource.getStatus()!=null){
			 map.put("status", resource.getStatus());
		 }
		 //分页显示：第1页开始，每页显示9条记录
		 PageHelper.startPage(page, pageSize);
		 List<RResource> resourceList=resourceService.selectLikeResourceListByPage(map);
		 PageInfo<RResource> pageInfo=new PageInfo<RResource>(resourceList);
		 Map returnMap=new HashMap();
		 if(resourceList.size()>0){
			 returnMap.put("status", 200);
		 }else{
			 //500表示：返回值为Null
			 returnMap.put("status", 500);
		 }
		 returnMap.put("resourceList", resourceList);
		 returnMap.put("pageInfo", pageInfo);
		 return returnMap;
	 }
	 
	 /**
	  * 通过类别typeId查询博客信息
	  * @param id
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value = "/selectResourceListByStatus",method = RequestMethod.POST)
	 @ResponseBody
	 public Map selectResourceListByStatus() throws Exception{
		 Map map=new HashMap();
		 List list=resourceService.selectResourceListByStatus();
		 if(list.size()>0){
			 map.put("status", 200);
		 }else{
			 //500表示：返回值为Null
			map.put("status", 500);
		 }
		 map.put("list", list);
		 return map;
	 }
	
}