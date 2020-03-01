<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var url = '&whatColumn=${whatColumn}'
	+'&keyword=${keyword}'
	+'&startDate=${startDate}'
	+'&endDate=${endDate}';
/*
//ajax 검색 
//1. pom.xml 설정
$.ajax({
  url: "", // 내가 호출하고 하는 URL @RequestMapping("/main.ino")
  type: "", GET, POST
  dataType: "", json
  data: "param = {"key", value , "key", value} ",
  success: function(data){
		// 서버와 정상적으로 소통했을때
  },
  error: function (request, status, error){        
		// 서버와 정상적으로 소통하지 않았을때
  }
});
*/

function auto_date_format(e, oThis){
    
    var num_arr = [ 
        97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    ]
    
    var key_code = ( e.which ) ? e.which : e.keyCode;
    if (num_arr.indexOf( Number( key_code ) ) != -1){
    
        var len = oThis.value.length;
        if( len == 4 ) oThis.value += "-";
        if( len == 7 ) oThis.value += "-";
    
    }
    
}


$(function() {
	//자동 -(하이픈) 넣기
	var startDate = $('#startDate').val();
	var endDate = $('#endDate').val();
	if (startDate != '' && startDate.length == 8){
		var startDateFmt = startDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
		var endDateFmt = endDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
		$('#startDate').val(startDateFmt);
		$('#endDate').val(endDateFmt);
	}

	//엔터키막기
	$(document).keypress(function(e) { 
    	if (e.keyCode == 13) e.preventDefault();
	});
	
 	$('#btnSearch').click(function(){
 		
 		if ($('#whatColumn').val().trim() != ''){
			if ($('#keyword').val().trim() == ""){
				alert("검색어를 입력해주세요.");
				$("#keyword").val("");
				$("#keyword").focus();
				return false;
			}
			
			if ($('whatColumn').val() == 'num'){
				var keyword = $('#keyword').val();
				var regexp = /^[0-9]*$/
				if ( !regexp.test(keyword) ){
					alert("숫자만 입력가능합니다");
					$('#keyword').val('');
					$('#keyword').focus();
					return false;
				}
			}
 		}
 		
 		var datatimeRegexp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		
		if ($('#startDate').val() != ''){
			
			if (!datatimeRegexp.test($('#startDate').val().trim())) {
				alert("년(19xx,20xx),월(1~12),일(1~31) 체크해주세요");
		        $('#startDate').focus();
		        return false;
		    }
			
			if ($('#endDate').val().trim() == '' ){
				alert("종료일을 입력해주세요.");
				$("#endDate").val("");
				$("#endDate").focus();
				return false;
			}
		}
		
		if ($('#endDate').val() != ''){
			
			if (!datatimeRegexp.test($('#endDate').val().trim())) {
		        alert("년(19xx,20xx),월(1~12),일(1~31) 체크해주세요");
		        $('#endDate').focus();
		        return false;
		    }
			
			if ($('#startDate').val().trim() == '' ){
				alert("시작일을 입력해주세요.");
				$("#startDate").val("");
				$("#startDate").focus();
				return false;
			}
			
		}
		
		if ($('#startDate').val() > $('#endDate').val()){
			alert("시작일이 종료일 보다 큽니다.");
			$('#endDate').val('');
			$('#endDate').focus();
			return false;
		}
			
 		
 		$.ajax({
		    url: "./search.ino", // 내가 호출하고 하는 URL @RequestMapping("/main.ino")
		    type: "POST",
		    dataType: "json",
		    data: $('#frm').serialize(),
		    success: function(map){
		    	$("#board").children().remove();
		    	$("#paging").children().remove();
		    	getBoardListCallback(map);
		    	getPageListCallback(map);
				// 서버와 정상적으로 소통했을때
		    },
		    error: function (request, status, error){
				// 서버와 정상적으로 소통하지 않았을때
				cosole.log("code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);
		    }
 		 }); 	
	});
})
	
function getBoardListCallback(map) {
	var list = map.map;
	var listLen = list.length;
	var html = '';
	if(listLen == 0){
		html += '<div style="width: 600px; float: center;">조회된 게시물이 없습니다</div>';
	}
	for(var i=0; i<listLen; i++){
		html += '<div style="width: 50px; float: left;">'+list[i].NUM+'</div>';
	             html += '<div style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?'
	          		   +'num='+list[i].NUM
	          		   +'&curPage=${paging.curPage}'
	          		   +'&whatColumn='+map.whatColumn
	          		   +'&keyword='+map.keyword
	          		   +'&startDate='+map.startDate
	          		   +'&endDate='+map.endDate
	          		   +'">'+list[i].TITLE+'</a></div>';
	             html += '<div style="width: 150px; float: left;">'+list[i].NAME+'</div>';
	             html += '<div style="width: 150px; float: left;">'+list[i].REGDATE+'</div>';
	             html += '<hr style="width: 600px">';
	}
	$("#board").html(html);
}
	
function getPageListCallback(map) {
	var list = map.paging;
	var html = '';
	if(list.curPage > 1){
		html += '<a href="javascript:pageList('+1+')">[처음]</a>'
	}
	if(list.curBlock > 1){
		html += '<a href="javascript:pageList('+list.prePage+')">[이전]</a>'
	}
	for(var i=list.blockBegin; i<=list.blockEnd; i++){
		if(i == list.curPage){
			html += '<span style="color: red">'+i+'</span> &nbsp;';
		}
		else{
			html += '<a href="javascript:pageList('+i+')">'+i+'</a> &nbsp;';
		}
	}
	if(list.curBlock <= list.totBlock){
		html += '<a href="javascript:pageList('+list.nextPage+')">[다음]</a>';
	}
	if(list.curPage < list.totalPage){
		html += '<a href="javascript:pageList('+list.totalPage+')">[끝]</a>';
	}
	$("#paging").html(html);
}

function pageList(page) {
	location.href='./main.ino?'
			+'curPage='+page+url;
}

function goToDetail(num) {
	location.href='./freeBoardDetail.ino?num='+ num
					+'&curPage=${paging.curPage}'+url;
}

function goToPage() {
	location.href = './freeBoardInsert.ino?'
					+'&curPage=${paging.curPage}'+url;
}

</script>
<title>Insert title here</title>
</head>
<body>
	
	<div>
		<h1>자유게시판</h1>
	</div>

	<div align="center" style="width: 650px;">
	
	<div style="width:650px;" align="right" id="write">
		<a href='javascript:void(0);' onclick="goToPage();">글쓰기</a>
	</div>
	<input type="hidden" id="code" name="code" value="${code}" >
	<form id="frm" name="frm">
			<select name="whatColumn" id="whatColumn">
				<option value="" <c:if test="${whatColumn == ''}">selected</c:if>>전체
				<c:forEach items="${selectOption}" var="option" varStatus="status">
					<option value="${option.DECODE}" <c:if test="${whatColumn == option.DECODE}">selected</c:if>>${option.DECODENAME}</option>
				</c:forEach>
			</select>
			<input type="text" id="keyword" name="keyword" value="${keyword }" >
			<input type="button" id="btnSearch" name="btnSearch" value="검색"><br>
			<input type="text" id="startDate" name="startDate" maxlength="10" value="${startDate}" onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)"> ~ 
			<input type="text" id="endDate" name="endDate" maxlength="10" value="${endDate}" onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)"> 
	</form>
	</div>
	<br>
	
	<div id="board">
		<c:forEach items="${freeBoardList}" var="list">
			<div style="width: 50px; float: left;">${list.NUM }</div>
			<div style="width: 300px; float: left;">
				<a href='javascript:void(0);' onclick="goToDetail(${list.NUM});">${list.TITLE}</a>
			</div>
			<div style="width: 150px; float: left;">${list.NAME }</div>
			<div style="width: 150px; float: left;">${list.REGDATE }</div>
			<hr style="width: 600px">
		</c:forEach>
	</div>
	
	<div id="paging">
		<c:if test="${paging.curPage > 1}">
			<a href="javascript:pageList('1')">[처음]</a>
		</c:if>
		
		<c:if test="${paging.curBlock > 1}">
			<a href="javascript:pageList('${paging.prevPage}')">[이전]</a>
		</c:if>
		
		<c:forEach var="num" begin="${paging.blockBegin}" end="${paging.blockEnd}">
			<c:choose>
				<c:when test="${num == paging.curPage}">
					<span style="color: red">${num}</span>&nbsp;
				</c:when>
				<c:otherwise>
					<a href="javascript:pageList('${num}')">${num}</a>&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.curBlock <= paging.totBlock}">
			<a href="javascript:pageList('${paging.nextPage}')">[다음]</a>
		</c:if>
		
		<c:if test="${paging.curPage < paging.totalPage}">
			<a href="javascript:pageList('${paging.totalPage}')">[끝]</a>
		</c:if>
	</div>
</body>
</html>