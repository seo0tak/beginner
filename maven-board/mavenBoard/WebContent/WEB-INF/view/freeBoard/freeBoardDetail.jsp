<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
var url ='curPage=${curPage}'
	+'&whatColumn=${list.whatColumn}'
	+'&keyword=${list.keyword}'
	+'&startDate=${list.startDate}'
	+'&endDate=${list.endDate}';

function byteCheck(el){
    var codeByte = 0;
    for (var idx = 0; idx < el.val().length; idx++) {
        var oneChar = escape(el.val().charAt(idx));
        if ( oneChar.length == 1 ) {
            codeByte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            codeByte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            codeByte ++;
        }
    }
    return codeByte;
}

function goToPage() {
	location.href = './main.ino?'
			+'curPage=${curPage}'
			+'&whatColumn=${list.whatColumn}'
			+'&keyword=${list.keyword}'
			+'&startDate=${list.startDate}'
			+'&endDate=${list.endDate}';
}

function boardDelte() {
	location.href = './freeBoardDelete.ino?num=${list.NUM}&'
			+'curPage=${curPage}'
			+'&whatColumn=${list.whatColumn}'
			+'&keyword=${list.keyword}'
			+'&startDate=${list.startDate}'
			+'&endDate=${list.endDate}';
}

$(function(){
	console.log('${list.whatColumn}');
	
	$('#btnUpdate').click(function(){
		
		String.prototype.trim = function() {
		    return this.replace(/^\s+|\s+$/g, "");//숫자만 입력되는 정규식
		}
		var form = document.insertForm;
		if(form.title.value.trim() == ""){
			alert("제목을 입력해주세요");
			form.title.value = form.title.value.trim();
			form.title.focus();
			return false;
		}
		if(form.regdate.value.trim() == ""){
			alert("날짜를 입력해주세요");
			form.regdate.value = form.title.value.trim();
			form.regdate.focus();
			return false;
		}
		if(form.content.value.trim() == ""){
			alert("내용을 입력해주세요");
			form.content.value = form.title.value.trim();
			form.content.focus();
			return false;
		}
		if(Number(byteCheck($("#content"))) > 1000) {
	        alert("글자수 초과(1000byte까지가능)")
	        $("#content").focus();
	        return false;
	    }
		
		$.ajax({
		    url: "./freeBoardModify.ino",
		    type: "POST",
		    dataType: "json",
		    data: $('#insertForm').serialize(),
		    success: function(data){
		    	if(data.message == 'success'){
			    	alert("수정성공");
			    	location.href = './main.ino?' + url;
		    	}
		    	else{
		    		return;
		    	}
		    },
		    error: function (request, status, error){    
		    	cosole.log("code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);
		    }
 		 });
	});
})
	
</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href='javascript:void(0);' onclick="goToPage();">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form name="insertForm" id="insertForm">
		<input type="hidden" name="num" value="${list.NUM }" />
		<input type="hidden" name="curPage" value="${curPage }" />
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${list.NAME }" readonly/></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${list.TITLE }"/></div>
	
		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${list.REGDATE }"/></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" id="content" rows="25" cols="65"  >${list.CONTENT }</textarea></div>
		<div align="right">
		<input type="button" id="btnUpdate" name="btnUpdate" value="수정">
		<input type="button" value="삭제" onclick="boardDelte()">
		<input type="button" value="취소" onclick="javascript:history.go(-1);">
		&nbsp;&nbsp;&nbsp;
		</div>
		
	</form>
	
</body>
</html>