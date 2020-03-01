<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var url = 'curPage=${curPage}'
	+'&whatColumn=${whatColumn}'
	+'&keyword=${keyword}'
	+'&startDate=${startDate}'
	+'&endDate=${endDate}';
	
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
	location.href = './main.ino?'+url;
}

$(function(){
	$('#btnInsert').click(function(){
		if($("#name").val().trim() == ""){
			alert("이름을 입력해주세요.");
			$("#name").val("");
			$("#name").focus();
			return false;
		}
		if($("#title").val().trim() == ""){
			alert("제목을 입력해주세요.");
			$("#title").val("");
			$("#title").focus();
			return false;
		}
		if($("#content").val().trim() == ""){
			alert("내용을 입력해주세요.");
			$("#content").val("");
			$("#content").focus();
			return false;
		}
		if(Number(byteCheck($("#content"))) > 1000) {
	        alert("글자수 초과(1000byte까지가능)")
	        $("#content").focus();
	        return false;
	    }
		
		$.ajax({
		    url: "./freeBoardInsertPro.ino",
		    type: "POST",
		    dataType: "json",
		    data: $('#frm').serialize(),
		    success: function(data){
		    	if(data.message == 'success'){
			    	alert("삽입성공");
			    	location.href="./main.ino";
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
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href='javascript:void(0);' onclick="goToPage();">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form id="frm" name="frm">
		<input type="hidden" name="curPage" value="${curPage }" />
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" id="name"/></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title" id="title"/></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" id="content" rows="25" cols="65"  ></textarea></div>
		<div align="right">
		<input type="button" id="btnInsert" name="btnInsert" value="글쓰기">
		<input type="button" value="다시쓰기" onclick="reset()">
		<input type="button" value="취소" onclick="history.back()">
		&nbsp;&nbsp;&nbsp;
		</div>
	
	</form>
	
	
	
</body>
</html>