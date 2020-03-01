<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
//전체선택
function checkAll() {
    if ($("#checkAll").is(':checked')) {
        $("input[type=checkbox]").prop("checked", true);
    } else {
        $("input[type=checkbox]").prop("checked", false);
    }
}
//추가된 행 삭제
function deleteRow(obj) {
	$(obj).closest('#detailView').remove();
}
//중복검사
function idCheck(decode,decodeCheck) {
	$.ajax({
	    url: "./decodeCheck.ino",
	    type: "GET",
	    contentType: "application/json; charset=utf-8;",
	    dataType: "json",
	    async: false,
	    data: {'decode':decode},
	    success: function(data){
	    	if(data == 1){
	    		decodeCheck = true;
	    	}
	    },
	    error: function (request, status, error){
			console.log("code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);
	    }
	});
	return decodeCheck;
}

$(function() {
	$('input[name=FLAG]').remove();
	$.fn.serializeObject = function() {
		var obj = null; 
		try { 
			if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) { 
				var arr = this.serializeArray(); 
				if(arr){ obj = {}; $.each(arr, function() { 
					obj[this.name] = this.value; }); 
				} 
			} 
		}catch(e) { 
			alert(e.message); 
		}finally {
			
		}
		return obj; 
	}
	
	//추가
	$('#btn-add-row').unbind('click').on('click', function() {
		var html = '';
		html += '<div id="detailView" style="width: 700px;">';
		html += '<form id="frm" name="frm" onsubmit="return">';
		
		//FLAG = I
		html += '<input type="hidden" id="FLAG" name="FLAG" value="I">';
		
		html += '<input type="hidden" id="CODE" name="CODE" value="${code}">';
		html += '<input type="checkbox" id="check" name="check" disabled>&emsp;&nbsp;&nbsp;';
		html += '<input type="text" id="DECODE" name="DECODE" maxlength="7" style="width: 100px;">&emsp;&emsp;&emsp;';
		html += '<input type="text" id="DECODE_NAME" name="DECODE_NAME" maxlength="10" style="width: 150px;">&emsp;&emsp;&emsp;';
		html += '<input type="radio" id="USE_YN" name="USE_YN" value="Y" checked>Y <input type="radio" id="USE_YN" name="USE_YN" value="N">N';
		html += '&emsp;&emsp;&emsp;<input type="button" value="삭제" onclick="deleteRow(this)">';
		html += '<hr style="width: 700px">';
		html += '</form>';
		html += '</div>';
	    $("#detailViewList").append(html);
	});
	
	//저장
	var flag = false;
	$('#btn-commit-row').unbind('click').on('click', function() {
		var list =[];
		flag = false;
		if($('input[name=FLAG]').length <= 0){
			alert("저장할 내용이 없습니다.");
			return false;
		}
		var decodeCheck = false;
		$('input:text:enabled').parent('#frm').each(function () {
			flag = false;
			decodeCheck = false;
			if($(this).children('#DECODE').val() == ''){
				alert('DECODE 누락');
				flag = false;
				return false;
			}
			else if($(this).children('#DECODE').val() != '' && $(this).children('#FLAG').val() == 'I'){
				decodeCheck = idCheck($(this).children('#DECODE').val(),decodeCheck);
				if(decodeCheck){
					alert('DECODE 중복');
					flag = false;
					return false;
				}
			}
			else if($(this).children('#DECODE_NAME').val() == ''){
				alert('DECODE_NAME 누락');
				flag = false;
				return false;
			}
			else if($(this).children('#USE_YN').val() == ''){
				alert('USE_YN 누락');
				flag = false;
				return false;
			}
			list.push($(this).serializeObject());
			flag = true;
		});
		
		//유효성 검사를 마친 flag = true 
		if(flag){
			$.ajax({
			    url: "./commit.ino",
			    type: "POST",
			    contentType: "application/json; charset=utf-8;",
			    data: JSON.stringify(list),
			    success: function(){
			    	alert(list.length+'건이 저장되었습니다.');
			    	location.href="./commonCodeDetail.ino?code=${code}";
			    },
			    error: function (request, status, error){
					console.log("code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);
			    }
			})
		}
		
		
		
	});
	
	//수정
	$('#btn-update-row').unbind('click').on('click', function() {
		//$("input[type=checkbox]").prop("checked", false);
		var cnt = 0;
		$('input:checkbox:checked').each(function() {
			$(this).parent('#frm').find('input[name=FLAG]').remove();
			$(this).parent('#frm').css('background-color','cyan');
			$(this).parent('#frm').find('input:disabled').removeAttr('disabled');
			$(this).parent('#frm').find('input[name=DECODE]').attr('readonly',true);
	    	$(this).parent('#frm').append('<input type="hidden" id="U" name="FLAG" value="U">');
            cnt++;
		})
		if(cnt == 0){
			alert("하나는 선택해라.");
			return false;
		}
	});
	
	//삭제
	$('#btn-delete-row').unbind('click').on('click', function() {
		//$("input[type=checkbox]").prop("checked", false);
		var cnt = 0;
		$('input:checkbox:checked').each(function() {
			$(this).parent('#frm').find('input[name=FLAG]').remove();
			$(this).parent('#frm').find('input[name=DECODE]').removeAttr('disabled');
			$(this).parent('#frm').find('input[name=DECODE]').attr('readonly',true);
			$(this).parent('#frm').css('background-color','red');
			$(this).parent('#frm').append('<input type="hidden" id="D" name="FLAG" value="D">');
            cnt++;
		})
		if(cnt == 0){
			alert("하나는 선택해라.");
			return false;
		}
		
	});
	
})
</script>
<title>Insert title here</title>
</head>
<body>
	
	<table height="100">
		<tr>
			<th width="50px" align="left">
				<input type="checkbox" id="checkAll" name="checkAll" onclick="checkAll()">
			</th>
			<th width="150px" align="left">DECODE</th>
			<th width="200px" align="left">DECODE_NAME</th>
			<th width="50px" align="left">USE_YN</th>
			<th width="50px"></th>
			<th>
				<button id="btn-add-row" name="btn-add-row">추가</button>&nbsp;
			</th>
			<th>
				<button id="btn-commit-row" name="btn-commit-row">저장</button>&nbsp;
			</th>
			<th>
				<button id="btn-update-row" name="btn-update-row">수정</button>&nbsp;
			</th>
			<th>
				<button id="btn-delete-row" name="btn-delete-row">삭제</button>
			</th>
			<th>
				<a href="./test.ino">test</a>
			</th>
		</tr>
	</table>
		
	<div id="detailViewList">
		<c:forEach var="nRow" items="${list}">
			<div id="detailView" style="width: 700px;">
				<form id="frm" name="frm" onsubmit="return">
					<input type="hidden" name="CODE" id="CODE" value="${nRow.CODE }">
					<input type="checkbox" id="check" name="check">&emsp;
					<input type="text" id="DECODE" name="DECODE" maxlength="7" style="border: 0px; width: 100px;" value="${nRow.DECODE }" disabled>&emsp;&emsp;&emsp;
					<input type="text" id="DECODE_NAME" name="DECODE_NAME" maxlength="10" style="border: 0px;width: 150px;" value="${nRow.DECODE_NAME }" disabled>&emsp;&emsp;&emsp;
					<input type="radio" id="USE_YN" name="USE_YN" value="Y" <c:if test="${nRow.USE_YN == 'Y'}">checked</c:if> disabled>Y
					<input type="radio" id="USE_YN" name="USE_YN" value="N" <c:if test="${nRow.USE_YN == 'N'}">checked</c:if> disabled>N
					<hr style="width: 700px">
				</form>
			</div>
		</c:forEach>
	</div>
	
</body>
</html>