<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>资源页_个人博客 - 一个在Java道路上的技术员个人博客网站</title>
<meta name="keywords" content="个人博客,罗廷方个人博客,罗廷方" />
<meta name="description" content="罗廷方个人博客，是一个在Java道路上的技术员个人博客网站" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
</head>
<body>
<%@ include file="top.jsp" %>
  <article>
    <div class="leftbox">
      <div class="newblogs">
      <h2 class="hometitle">
	      <span class="tagTitle">
	      	<a href="javascript:void(0);">学习视频</a>
	      	<a href="javascript:void(0);">项目源码</a>
	      	<a href="javascript:void(0);">笔记</a>
	      	<a href="javascript:void(0);">开发工具</a>
	      </span>
	     资源分享
	     </h2>
        <div class="row">
            <div class="col-sm-12">
                <div class="wrapper wrapper-content ">
                     
                </div>
                <div class="pagelist ">
      
     		    </div>
            </div>
        </div>

      </div>
    </div>

    <div class="rightbox ">
      <div class="search1">
        <form name="searchform" id="searchform">
          <input id="keyword" class="input_text" value="请输入关键字" style="color: rgb(153, 153, 153);" onfocus="if(value=='请输入关键字'){this.style.color='#000';value=''}" onblur="if(value==''){this.style.color='#999';value='请输入关键字'}" type="text">
          <input  class="input_submit" value="搜索" type="button" onclick="selectResource()">
        </form>
      </div>
      <div class="paihang ">
        <h2 class="ab_title"><a href="/">本栏推荐</a></h2>
        <ul class="like animated fadeInDown">
         
        </ul>
        <div class="ad"></div>
      </div>
    </div>
  </article>



    

    <!-- 全局js -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/js/content.js?v=1.0.0"></script>
    
    <script>
	$(document).ready(function() {
		//初始化类别信息
		 initResource(1);
		 initBlogByLike();
	});
	var initResource=function(pageNum){
		var keyword=$("#keyword").val();
		if(keyword=="请输入关键字")
			keyword="";
		 var params={
				 pageSize: 12,
		         page:pageNum,
   				 title:keyword,
   				 content:keyword,
   				 status:1    //1 表示已发布
   			 };
              	$.ajax({
	            url:'../admin/selectLikeResourceListByPage',    
	            type:'get',
	            data:params,
	            dataType:'json',    
	            success:function (date) {
	            	var resourceList='';
	            	var page=date.pageInfo;
	            	var data=date.resourceList;
	            	if(data.length>0){
	            		for (var i = 0; i < data.length; i++) {
	            			resourceList+='<div class="col-sm-4 animated fadeInDown" ><div class="panel panel-info"><div class="panel-heading">'+data[i].title+'</div><div class="panel-body"><p style="word-break:break-word;height: 40px;">'+data[i].content+'</p></div><div class="panel-footer"><b>密码：'+data[i].password+'</b></span><a href="'+data[i].link+'" target="_blank"><span class="label label-danger pull-right">Go</span></a> </div></div></div>';
	            		}
	            	}else{
	            		resourceList="无查询结果";
	            	}
	            	$(".newblogs").find(".wrapper").html(resourceList);
	            	
	            	if(page.total>12){
	            		 var allTotal='<a title="Total record">&nbsp;<b>'+page.total+'</b> </a>&nbsp;&nbsp;';
	            		 var pagesNum='';
	            		 var fristPage='';
	            		 var prePage='';
	            		 var nextPage='';
	            		 var lastPage='';
	            		 var num='';
	            		 var currNum=1;
	            		 var maxNum=page.pages;
	            		 if(page.pageNum>=3){
	             			currNum=page.pageNum-2;
	             		}
	             		 if(page.pageNum>=page.pages-2){
	             			 currNum=page.pages-4;
	             		 }
	            		 if(maxNum>5){
	            			 maxNum=currNum+4;
	            		 }else{
	            			 currNum=1;
	            		 }
	            		 for(var i=currNum;i<=maxNum;i++){
	            			 if(i>page.pages){
	            				 break;
	            			 }
	            			 if(page.pageNum==i){
	            				 num='<a href="javascript:void(0);"><b>'+i+'</b></a>&nbsp;'
	            			 }else{
	            				 num='<a href="javascript:void(0);" onclick="pageNav('+i+')">'+i+'</a>&nbsp;';
	            			 }
	            			 pagesNum+=num;
	            		 }
	            		 var pre=page.pageNum-1;
	            		 var next=page.pageNum+1;
	            		 if(page.pageNum==1){
	            			 prePage='<a href="javascript:void(0);">上一页</a>&nbsp;';
	            			 fristPage='<a href="javascript:void(0);">首页</a>&nbsp;';
	            		 }else{
	            			 prePage='<a href="javascript:void(0);" onclick="pageNav('+pre+')">上一页</a>&nbsp;';
	            			 fristPage='<a href="javascript:void(0);" onclick="pageNav(1)">首页</a>&nbsp;';
	            		 }
	            		 if(page.pageNum==page.pages){
	            			 nextPage='<a href="javascript:void(0);">下一页</a>&nbsp;';
	            			 lastPage='<a href="javascript:void(0);">尾页</a>&nbsp;';
	            		 }else{
	            			 nextPage='<a href="javascript:void(0);" onclick="pageNav('+next+')">下一页</a>&nbsp;';
	            			 lastPage='<a href="javascript:void(0);" onclick="pageNav('+page.pages+')">尾页</a>&nbsp;';
	            		 }
	            		 $(".pagelist").html(allTotal+fristPage+prePage+pagesNum+nextPage+lastPage);
	            		
	            	 }else{
	            		 $(".pagelist").html("");
	            	 }
	            	
	            },
			    error:function(){
			    	alert("失败");
			    }	
	        });
	};
	
	var pageNav=function(pageNum){
		var index ='';
		 layer.ready(function(){
		   index=layer.load(2, {
			  shade: [0.1,'#eee'] //0.1透明度的白色背景
		    });
		  }); 
		 initResource(pageNum);
		setTimeout(function () {
		 window.scrollTo(0,0);   //滑动到浏览器顶部
		 layer.close(index);
	},200);
	};
	
	//初始化推荐
	var initBlogByLike=function(){
		var params ={
				 pageSize: 5,
		         page:1,
		         isrecommend:1  //1 表示推荐
		};
		$.ajax({
            url:'../admin/selectGroupLikeBlogListByPage',    
            type:'get',
            data:params,
            dataType:'json',    
            success:function (data) {
            	var likeBlog='';
            	var data=data.blogList;
            	
                for (var i = 0; i < data.length; i++) {
                	 if(data[i].introduction.length>35){
                		data[i].introduction=data[i].introduction.substring(0,34)+"...";
                	}
                	var id=data[i].id.toString(8)*data[i].id;
                	likeBlog+='<li><b><a href="find/'+id+'.html">'+data[i].title+'</a></b><p>'+data[i].introduction+'</p></li>';
                }
                // 初始化数据
                $(".paihang").find(".like").html(likeBlog);
                var ad='<img src="${pageContext.request.contextPath}/images/ad300x100.jpg">';
				$(".ad").html(ad);
				
            },    
		    error:function(){
		    	layer.msg('出错啦', {icon: 2});
		    }	
        });
	};
	
	var selectResource=function(){
		var index ='';
	     layer.ready(function(){
	    	index=layer.load(2, {
				  shade: [0.1,'#eee'] //0.1透明度的白色背景
	    	});
	    }); 
	     initResource(1);
		setTimeout(function () {
			layer.close(index);
		},200);
	};
	</script>
</body>
</html>