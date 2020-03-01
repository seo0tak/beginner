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
		    return this.replace(/^\s+|\s+$/g, "");//���ڸ� �ԷµǴ� ���Խ�
		}
		var form = document.insertForm;
		if(form.title.value.trim() == ""){
			alert("������ �Է����ּ���");
			form.title.value = form.title.value.trim();
			form.title.focus();
			return false;
		}
		if(form.regdate.value.trim() == ""){
			alert("��¥�� �Է����ּ���");
			form.regdate.value = form.title.value.trim();
			form.regdate.focus();
			return false;
		}
		if(form.content.value.trim() == ""){
			alert("������ �Է����ּ���");
			form.content.value = form.title.value.trim();
			form.content.focus();
			return false;
		}
		if(Number(byteCheck($("#content"))) > 1000) {
	        alert("���ڼ� �ʰ�(1000byte��������)")
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
			    	alert("��������");
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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href='javascript:void(0);' onclick="goToPage();">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	
	<form name="insertForm" id="insertForm">
		<input type="hidden" name="num" value="${list.NUM }" />
		<input type="hidden" name="curPage" value="${curPage }" />
		
		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${list.NAME }" readonly/></div>
		
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${list.TITLE }"/></div>
	
		<div style="width: 150px; float: left;">�ۼ�����</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${list.REGDATE }"/></div>
	
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" id="content" rows="25" cols="65"  >${list.CONTENT }</textarea></div>
		<div align="right">
		<input type="button" id="btnUpdate" name="btnUpdate" value="����">
		<input type="button" value="����" onclick="boardDelte()">
		<input type="button" value="���" onclick="javascript:history.go(-1);">
		&nbsp;&nbsp;&nbsp;
		</div>
		
	</form>
	
</body>
</html>