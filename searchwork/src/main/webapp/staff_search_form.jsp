<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<!-- 현재년도 -->
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
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
<script type="text/javascript">
var endDate;
var startDate;

function getLastDay(n) {
	console.log($("select[name="+n+"Year]").val());
	if($("select[name="+n+"Year]").val() != '' && $("select[name="+n+"Month]").val() != ''){
	var leapday = new Date($("select[name="+n+"Year]").val(), $("select[name="+n+"Month]").val(), 0).getDate();
	console.log(leapday);
	 var str = '<option value="" selected hidden="true"></option>';
	 for(var i=1; i<=leapday; i++){
	 	str += `<option value="`+i+`">`+String(i).padStart(2,'0')+`</option>`;
	 }
	
	 $("select[name="+n+"Day]").html('');
	 $("select[name="+n+"Day]").html(str);
	}
}

function checkform() {
	
	
	var tagSelect = $('select');
	var gflag = false;
	for (let i=1; i<tagSelect.length; i++) {
		if($(tagSelect.get(i)).val() != '') {
			gflag = true;
			break;
		}
	}
	if (gflag) {
			for (let i = 1; i < tagSelect.length; i++) {
				if ($(tagSelect.get(i)).val() == '') {
					alert('날짜를 전부 입력해주세요.');
					return false;
				}
			}
		}

		endDate = $('select[name=sYear]').val() + '-'
				+ $('select[name=sMonth]').val().padStart(2, '0') + '-'
				+ $('select[name=sDay]').val().padStart(2, '0');
		startDate = $('select[name=fYear]').val() + '-'
				+ $('select[name=fMonth]').val().padStart(2, '0') + '-'
				+ $('select[name=fDay]').val().padStart(2, '0');
		var gd = new Date(endDate);
		var sd = new Date(startDate);
		if (sd >= gd) {
			alert('올바른 날짜를 입력해주세요.')
			return false;
		}

		console.log(startDate);
		console.log(endDate);

		$('form[name=searchForm]').prepend(
				'<input type="hidden" name="startDate" value="'+startDate+'">')
		$('form[name=searchForm]').prepend(
				'<input type="hidden" name="endDate" value="'+endDate+'">')
				

		//$('form[name=searchForm]').prepend('<input type="hidden" name="jumin_no" value="'+juminNo+'">')
		for(var i=0; i < $('.delBtn').length; i++ ) {
		console.log($('.delBtn')[i]);
		$('form[name=searchForm]').prepend('<input type="hidden" name="skills" value="'+$('.delBtn')[i].value+'">');
		}
		
		
		return true;
	}
</script>
<script type="text/javascript">
function ajaxtest(){ 
	var formData = new FormData(); //formData 객체 생성
	//formData.append("sort", "no");
	$.ajax({
		url : "/ajaxSearch.do",
		type : "get",
		dataType : "text",
		data : formData,
		contentType: false,
	    processData: false,
		cache : false
    }).done(function(result) {
		  console.log("결과확인");
		  $('#reset').trigger('click');
		  $('#ajaxjstl').html(result);
		//$('#jstlTest').html(result);		
		
	}).fail(function (jqXHR, textStatus, errorThrown) {
		console.log("에러");
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	});
}


function ajaxSearch(page = 1, sort = "s.staff_no desc") {
	if( !checkform()) {
		return false;
	}
	
	var formData = $('#searchForm').serialize()// serialize 사용 
    
	formData += "&page="+page;
	formData += "&startDate="+(startDate ?? '');
	formData += "&endDate="+(endDate ?? '');
	formData += "&sort=" + sort;
	
	var str1 = '';
	for(var i=0; i < $('.delBtn').length; i++ ) {
		str1 += "&skills=" + $('.delBtn')[i].value;
	}
	formData += str1;
	
	
	console.log(formData);
	
	$.ajax({
		url : "/ajaxSearch.do",
		type : "get",
		dataType : "text",
		data : formData,
		contentType: false,
	    processData: false,
		cache : false
    }).done(function(result) {
		//  console.log("결과확인");
		//  console.log(result);
		  $('#ajaxjstl').html(result);
		//$('#jstlTest').html(result);		
		
	}).fail(function (jqXHR, textStatus, errorThrown) {
		console.log("에러");
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	});
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

function reset() {
	$('.delBtn').trigger('click');
}

$(function(){
	
	$(document).on('click', ".delBtn" ,delOther);
	$(document).on('click', "#reset" ,reset);	
	$('input[name="otherSkill"]').keydown(function() {
		  if (event.keyCode === 13) {
			  event.preventDefault(); // 엔터시 서브밋 방지
			  $('#plus').trigger("click");  // 추가클릭
			  //또는 other() 사용
		  };
		});

})
</script>

</head>
<body>

<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
<hr>
<h2 align="center"></h2>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype="multipart/form-data" 값을 지정해야함
-->
<form id="searchForm" action="search.do" method="get" onsubmit="return checkform();">

<table align="center" width="800"  cellspacing="0" cellpadding="5">
	<tr><th colspan="6" >사원 정보 검색</th></tr>
	<tr>
		<th>이름</th><td class="center" ><input type="text" name="staff_keyword"></td>
		<th>성별</th><td class="center" >
					<input type="checkbox" name="gender" value="M">남 &nbsp;
					<input type="checkbox" name="gender" value="F">여
					</td>
		<th>부서</th><td class="center" >
					<select name="department_code">
						<option value="0"></option>
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
		<th>학력</th><td class="center" >
						<input type="checkbox" name="school_code" value="1"> 고졸
						<input type="checkbox" name="school_code" value="2"> 전문대졸
						<input type="checkbox" name="school_code" value="3"> 일반대졸
					</td>
		<th>기술</th><td colspan="4">
						<input type="checkbox" name="skill_code" value="1">Java &nbsp;
						<input type="checkbox" name="skill_code" value="2">JSP &nbsp;
						<input type="checkbox" name="skill_code" value="3">ASP &nbsp;
						<input type="checkbox" name="skill_code" value="4">PHP &nbsp;
						<input type="checkbox" name="skill_code" value="5">Delphi
						</td>
	</tr>
	<tr>
		<th>졸업일</th><td colspan="5" align="center">
					<select draggable="false" name="fYear" onchange="getLastDay('f');">
						<option value="" selected hidden="true"></option>
				        <c:forEach var="yy" begin="1950" end="${sysYear }" step="1" varStatus="status">
				        	<option value="${ yy}"><fmt:formatNumber value="${yy}" pattern="00"/></option>
				        </c:forEach>
				    </select> 년 &nbsp;
				    <select name="fMonth" onchange="getLastDay('f');">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="mm" begin="1" end="12" step="1" varStatus="status">
				        	<option value="${ mm}"><fmt:formatNumber value="${mm}" pattern="00"/></option>
				        </c:forEach>
				    </select> 월 &nbsp;
				    <select name="fDay">
			    		<option value="" selected hidden="true"></option>
			    		<c:forEach var="dd" begin="1" end="30" step="1" varStatus="status">
			        		<option value="${ dd}"><fmt:formatNumber value="${dd}" pattern="00"/></option>
				        </c:forEach>
				    </select> 일 &nbsp; &nbsp; ~ &nbsp; &nbsp;
				    <select name="sYear" onchange="getLastDay('s');">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="yy" begin="1950" end="${sysYear }" step="1" varStatus="status">
				        	<option value="${yy}"><fmt:formatNumber value="${yy}" pattern="00"/></option>
				        </c:forEach>
				    </select> 년 &nbsp;
				    <select name="sMonth" onchange="getLastDay('s');">
				       <option value="" selected hidden="true"></option>
				       <c:forEach var="mm" begin="01" end="12" step="1" varStatus="status">
				        	<option value="${mm}"><fmt:formatNumber value="${mm}" pattern="00"/></option>
				        </c:forEach>
				    </select> 월 &nbsp;
				    <select name="sDay">
				        <option value="" selected hidden="true"></option>
				        <c:forEach var="dd" begin="1" end="30" step="1" varStatus="status">
			        		<option value="${dd}"><fmt:formatNumber value="${dd}" pattern="00"/></option>
				        </c:forEach>
				    </select> 일 

					</td>
	</tr>
										<tr>
					<th>추가 기술</th>
					<td id="addSkill" colspan="4"> 
					</td>
					<td>
					<input  id="otherSkill"  name="otherSkill" style="width:100px;" type="text" placeholder="...">
					<input id="plus" type="button" onclick="other()" value="추가"><br>				
					</td>
					</tr>
					
	<tr><td align="right" colspan="3" style="border: none;">
<!-- 		<input type="submit" value="검색"> -->
		<input type="button" onclick="ajaxSearch()" value="검색">
		</td>

		<td align="right" colspan="3" style="border: none;">
		<input type="button" onclick="ajaxtest()" value="전부검색">
		<!-- <input type="button" onclick="javascript:location.href='/search.do'" value="전부검색"> -->
		<input id="reset" type="reset" value="초기화">
		<button type="button" onclick="javascript:location.href='/staff_input_form.jsp';">등록</button>
		</td>
		</tr>
		<c:if test="${ list ne null  }">
		<tr><td colspan="6" align="right" style="border: none;">검색건수 -> ${ listCount }건</td></tr>
		</c:if>
</table>

</form>
<div id="ajaxjstl">
<c:if test="${ list ne null  }">

<table id="jstlTest" align="center" width="800"  cellspacing="0" cellpadding="5">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>성별</th>
		<th>부서</th>
		<th>졸업일</th>
		<th></th>
	</tr>

	<c:forEach items="${ list }" var="s" varStatus="status"> 
	<tr>
		<%-- <td class="center">${status.count + limit * (currentPage-1)}</td> --%>
		<td class="center">${ s.staff_no }</td>
		<td class="center">${ s.staff_name }</td>
		<td class="center">
		<c:if  test="${ fn:substring(s.jumin_no,7,8 ) eq '1' || fn:substring(s.jumin_no,7,8 ) eq '3' }">
		남
		</c:if>
		<c:if test="${ fn:substring(s.jumin_no,7,8 ) eq '2' || fn:substring(s.jumin_no,7,8 ) eq '4' }">
		여
		</c:if>
		</td>
		<td class="center">
			<c:forEach items="${ dlist }" var="d" varStatus="status2"> 
				<c:if test="${ d.department_code eq s.department_code }">
					${ d.department_name }
				</c:if>
			</c:forEach>
		</td>
		<td class="center">${ s.graduate_day }</td>
		<td class="center"><input type="button" onclick="javascript:location.href='/staffDetail.do/${s.staff_no}'" value="수정/삭제"></td>
	</tr>
	</c:forEach>
	

</table>

<!-- pc 페이징 표시 영역-->
			<div class="paginate" align="center">
				<!-- 이전 페이지그룹으로 이동 처리 -->
				<c:if test="${ (currentPage - limit) <= startPage and (currentPage - limit) >= 1 }">
					<c:url var="ql2" value="/myQuestionListView.do">
						<c:param name="page" value="${ startPage - limit }" />
					</c:url>
					<a class='prev' href='${ ql2 }' style='cursor:default' title='이전그룹'></a>
				</c:if>
				<c:if test="${ !((currentPage - limit) <= startPage and (currentPage - limit) >= 1) }">
					<a class='prev' href='#' style='cursor:default' title='이전그룹'></a>
				</c:if>
				
				<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
				<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1" >
					<c:if test="${ p eq currentPage }">
						<a class='curr' href='#'>[${ p }]</a>&nbsp;
					</c:if>
					<c:if test="${ p ne currentPage }">
						<c:url var="ql" value="/search.do">
							<c:param name="page" value="${ p }" />
							<c:param name="staff_keyword" value="${ staff_keyword }"/>
							
							<c:forEach items="${ gender }" var="g">
								<c:param name="gender" value="${ g }"/>
							</c:forEach>
							
							<c:forEach items="${ school_code }" var="s">
								<c:param name="school_code" value="${ s }"/>
							</c:forEach>
							
							<c:forEach items="${ skill_code}"  var="sCode">
								<c:param name="skill_code" value="${ sCode }"/>
							</c:forEach>
							
							<c:param name="department_code" value="${ department_code }"/>
							<c:param name="startDate" value="${ startDate }" />
							<c:param name="endDate" value="${ endDate }"/>
						</c:url>
						<a href='${ ql }'>${ p }</a>&nbsp;
					</c:if>
				</c:forEach>

			</div>
			</c:if>
</div>
<hr>
</body>
</html>