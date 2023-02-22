<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<style type="text/css">
table th,
table td {
	border: 1px black solid;

}
table td.center {
	text-align: center;
}
table th:first-child,
table td:first-child {
	border-left: 0;
}
table th:last-child,
table td:last-child {
	border-right: 0;
}
</style>

<!-- 현재년도 -->
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 

<script type="text/javascript">
function check() {
	if ($("input:checkbox[name=skill_code]").is(":checked")==false) {
		alert("기술은 하나 이상 선택해주세요.");
		return false;
	}
	return true;
}

function checkSSN(strJumin) {
    this.strJumin = strJumin;
    let jumin = this.strJumin.replace('-', '').split('');
    const bits = [2,3,4,5,6,7,8,9,2,3,4,5];
    let sum = 0;
    for (let i =0; i<bits.length; i++){
        sum += Number(jumin[i])*bits[i];
    }
    let lastNum = Number(jumin[jumin.length-1]);
    let resultNum = (11-(sum%11))%10;

    if (lastNum == resultNum){
    	return true;
    }
    return false;
}
function checkform() {
	var tagSelect = $('select');
	for (let i=0; i<tagSelect.length; i++) {
		if($(tagSelect.get(i)).val() == '') {
			alert('부서 또는 졸업일을 입력해주세요.');
			return false;
		}
	}
	
	if ($("input:checkbox[name=skill_code]").is(":checked")==false) {
		alert("기술은 하나 이상 선택해주세요.");
		return false;
	}
	
	var juminNo = $('form [name=n1]').val() + "-" + $('form [name=n2]').val()
	console.log(juminNo);
	
	
	if(!checkSSN(juminNo)){
		alert('유효하지 않은 주민번호입니다.');
		return false;
	}
	
	var gDate = $('select[name=sYear]').val()+'-'+$('select[name=sMonth]').val().padStart(2,'0')+'-'+$('select[name=sDay]').val().padStart(2,'0');
	var startDate = $('select[name=fYear]').val()+'-'+$('select[name=fMonth]').val().padStart(2,'0')+'-'+$('select[name=fDay]').val().padStart(2,'0');
	var gd= new Date(gDate);
	var sd= new Date(startDate);
	if(sd >= gd) {
		alert('올바른 졸업일을 입력해주세요.')
		return false;
	}
	
	var jbResult = confirm( '정말 저장 하시겠습니까?' );
	if(!jbResult) {
		return false;
	}
	
	$('form[name=insertForm]').prepend('<input type="hidden" name="graduate_day" value="'+gDate+'">')
	$('form[name=insertForm]').prepend('<input type="hidden" name="jumin_no" value="'+juminNo+'">')
	
	console.log($('.delBtn'))
	for(var i=0; i < $('.delBtn').length; i++ ) {
		console.log($('.delBtn')[i]);
		$('form[name=insertForm]').prepend('<input type="hidden" name="skills" value="'+$('.delBtn')[i].value+'">');
	}
	//console.log($('#insertForm').serialize())
	
	return true;
}
</script>
<!-- 년도와 월을가지고 일수계산 -->
<script>
function getLastDay(n) {
	console.log($("select[name="+n+"Year]").val());
	if($("select[name="+n+"Year]").val() != '' && $("select[name="+n+"Month]").val() != ''){
	var leapday = new Date($("select[name="+n+"Year]").val(), $("select[name="+n+"Month]").val(), 0).getDate();
	console.log(leapday);
	 var str = '<option value="" selected hidden="true"></option>';
	 for(var i=1; i<=leapday; i++){
	 	str += `<option value="`+i+`">`+i+`</option>`;
	 }
	
	 $("select[name="+n+"Day]").html('');
	 $("select[name="+n+"Day]").html(str);
	}
}

function other() {
	const skill = $('#otherSkill').val() ?? '';
	if(skill == '') {
		alert('기술을 입력해주세요.');
		return false;
	}
	var str = `<input type="button" class="delBtn" name="skills" value=`+skill+`> `;
	
	$('#otherSkill').val('');
	$('#addSkill').append(str);
	
}
function delOther() {
	$(this).remove();
}

$(function(){
	var chkStyle = /^[0-9]+$/; //체크 방식(숫자)
	
	   $("input[name=n1]").on("keyup", function() {
		   if($(this).val().length>0 && !chkStyle.test($(this).val())){
			    alert("숫자만 입력하세요.");
			}
	      $(this).val($(this).val().replace(/[^0-9]/g,""));
	   });
	
	   $("input[name=n2]").on("keyup", function() {
		   if($(this).val().length>0 && !chkStyle.test($(this).val())){
			    alert("숫자만 입력하세요.");
			}
	      $(this).val($(this).val().replace(/[^0-9]/g,""));
	   });
	   
	$(document).on('click', ".delBtn" ,delOther);
	
	$('input[name="otherSkill"]').keydown(function() {
		  if (event.keyCode === 13) {
			  event.preventDefault(); // 엔터시 서브밋 방지
			  $('#plus').trigger("click");  // 추가클릭
			  //또는 other() 사용
		  };
		});
	
	$(document).on('click', "#reset" ,function (){
		$('.delBtn').trigger('click');
	});	
	
});
</script>
</head>
<body>

<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
<hr>
<h2 align="center">등록 페이지</h2>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype="multipart/form-data" 값을 지정해야함
-->
<form id="insertForm" name="insertForm" action="input.do" method="post" onSubmit="return checkform();">

<table  align="center" width="800" cellspacing="0" cellpadding="5" >
	<tr><th colspan="6" >사원 정보 등록</th></tr>
	<tr>
		<th>이름</th><td class="center" >
				<input required type="text" name="staff_name"></td>
		<th>주민번호</th><td class="center">
					<input required style="width: 60px;" maxlength="6" type="text" name="n1"  > - <input required style="width: 60px;" type="password" maxlength="7" name="n2">
					</td>
		<th>부서</th><td class="center" >
					<select name="department_code">
						<option value="" selected hidden="true"></option>
				        <option value="1">ICT사업부</option>
				        <option value="2">디지털트윈사업부</option>
				        <option value="3">SI사업부</option>
				        <option value="4">반도체사업부</option>
				        <option value="5">기업부설연구소</option>
				        <option value="6">전략기획팀</option>
				        <option value="7">경영지원팀</option>
				    </select>
					</td>
	</tr>
	<tr>
		<th>학력</th><td class="center">
						<input type="radio" name="school_code" value="1" required> 고졸
						<input type="radio" name="school_code" value="2"> 전문대졸
						<input type="radio" name="school_code" value="3"> 일반대졸
					</td>
		<th>기술</th><td colspan="4">
						<input type="checkbox" name="skill_code" value="1">Java
						<input type="checkbox" name="skill_code" value="2">JSP
						<input type="checkbox" name="skill_code" value="3">ASP
						<input type="checkbox" name="skill_code" value="4">PHP
						<input type="checkbox" name="skill_code" value="5">Delphi
						</td>
	</tr>
	<tr>
	
		<th>졸업일</th><td class="center" colspan="5" align="center">
		 			
				    
					<select draggable="false" name="fYear" onchange="getLastDay('f');">
						<option value="" selected hidden="true"></option>
				        <c:forEach var="yy" begin="1950" end="${sysYear }" step="1" varStatus="status">
				        	<option value="${ yy}"><fmt:formatNumber value="${yy}" pattern="00"/></option>
				        </c:forEach>
				    </select> 년 
				    <select name="fMonth" onchange="getLastDay('f');">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="mm" begin="1" end="12" step="1" varStatus="status">
				        	<option value="${ mm}"><fmt:formatNumber value="${mm}" pattern="00"/></option>
				        </c:forEach>
				    </select> 월
				    <select name="fDay">
			    		<option value="" selected hidden="true"></option>
			    		<c:forEach var="dd" begin="1" end="30" step="1" varStatus="status">
			        		<option value="${ dd}"><fmt:formatNumber value="${dd}" pattern="00"/></option>
				        </c:forEach>
				    </select> 일 ~ 
				    <select name="sYear" onchange="getLastDay('s');">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="yy" begin="1950" end="${sysYear }" step="1" varStatus="status">
				        	<option value="${yy}"><fmt:formatNumber value="${yy}" pattern="00"/></option>
				        </c:forEach>
				    </select> 년 
				    <select name="sMonth" onchange="getLastDay('s');">
				       <option value="" selected hidden="true"></option>
				       <c:forEach var="mm" begin="01" end="12" step="1" varStatus="status">
				        	<option value="${mm}"><fmt:formatNumber value="${mm}" pattern="00"/></option>
				        </c:forEach>
				    </select> 월
				    <select name="sDay">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="dd" begin="1" end="30" step="1" varStatus="status">
			        		<option value="${dd}"><fmt:formatNumber value="${dd}" pattern="00"/></option>
				        </c:forEach>
				    </select> 일

					</td></tr>	
					<tr>
					<th>추가 기술</th>
					<td id="addSkill" colspan="4"> 
					</td>
					<td>
					<input  id="otherSkill"  name="otherSkill" style="width:100px;" type="text" placeholder="...">
					<input id="plus" type="button" onclick="other()" value="추가"><br>				
					</td>
					</tr>
	
		<tr><td align="right" colspan="2" style="border: none;">
		<input type="submit" value="등록">
		</td>

		<td align="right" colspan="4" style="border: none;">
		<input id="reset" type="reset" value="초기화">
		</td>
		</tr>
</table>

</form>

<hr>
</body>
</html>