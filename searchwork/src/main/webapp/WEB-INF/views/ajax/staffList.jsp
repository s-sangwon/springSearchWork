<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<table align="center" width="800"  cellspacing="0" cellpadding="5">
	<tr><td colspan="6" align="right" style="border: none;">검색건수 -> ${ listCount }건</td></tr>
</table>

<table id="jstlTest" align="center" width="800" cellspacing="0"
	cellpadding="5">
	<tr>
		<th>번호 
		<c:choose>
		<c:when test="${ sort == 's.staff_no asc' }">
		<img onclick="ajaxSearch(1, 's.staff_no desc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:when>
		<c:otherwise>
		<img onclick="ajaxSearch(1, 's.staff_no asc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:otherwise>
		</c:choose>
		</th>
		<th>이름 
		<c:choose>
		<c:when test="${ sort == 's.staff_name asc' }">
		<img onclick="ajaxSearch(1, 's.staff_name desc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:when>
		<c:otherwise>
		<img onclick="ajaxSearch(1, 's.staff_name asc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:otherwise>
		</c:choose>
		</th>
		<th>성별 
		<c:choose>
		<c:when test="${ sort eq 'gender asc' }">
		<img onclick="ajaxSearch(1, 'gender desc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:when>
		<c:otherwise>
		<img onclick="ajaxSearch(1, 'gender asc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:otherwise>
		</c:choose>
		</th>
		<th>부서 
		<c:choose>
		<c:when test="${ sort == 'department_name asc' }">
		<img onclick="ajaxSearch(1, 'department_name desc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:when>
		<c:otherwise>
		<img onclick="ajaxSearch(1, 'department_name asc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:otherwise>
		</c:choose>
		</th>
		<th>졸업일 
		<c:choose>
		<c:when test="${ sort == 'graduate_day asc' }">
		<img onclick="ajaxSearch(1, 'graduate_day desc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:when>
		<c:otherwise>
		<img onclick="ajaxSearch(1, 'graduate_day asc' )" style="cursor:pointer;" width="10px" height="12px" src="/resources/images/sort.png">
		</c:otherwise>
		</c:choose>
		</th>
		<th></th>
	</tr>

	<c:forEach items="${ list }" var="s" varStatus="status">
		<tr>
			<%-- <td class="center">${status.count + limit * (currentPage-1)}</td> --%>
			<td class="center">${ s.staff_no }</td>
			<td class="center" width="115">${ s.staff_name }</td>
			<td class="center" width="50"><c:if
					test="${ fn:substring(s.jumin_no,7,8 ) eq '1' || fn:substring(s.jumin_no,7,8 ) eq '3' }">
		남
		</c:if> <c:if
					test="${ fn:substring(s.jumin_no,7,8 ) eq '2' || fn:substring(s.jumin_no,7,8 ) eq '4' }">
		여
		</c:if></td>
			<td width="250" class="center"><c:forEach items="${ dlist }" var="d"
					varStatus="status2">
					<c:if test="${ d.department_code eq s.department_code }">
					${ d.department_name }
				</c:if>
				</c:forEach></td>
			<td class="center">${ s.graduate_day }</td>
			<td class="center"><input type="button"
				onclick="javascript:location.href='/staffDetail.do/${s.staff_no}'"
				value="수정/삭제"></td>
		</tr>
		<c:set var="contain_flag" value="false" />
		<c:forEach items="${ otherSkills }" var="k">
		    <c:if test="${s.skill_code.contains(k) && !contain_flag}">
		        <c:set var="contain_flag" value="true" />
		    </c:if>
		</c:forEach>
		
		<c:if test="${ contain_flag }">
		<tr ><td colspan="6">&nbsp;&nbsp;&nbsp;↳
		<c:forEach items="${ otherSkills }" var="k">
		    <c:if test="${s.skill_code.contains(k)}">
		        ${ smap[k] }&nbsp;
		    </c:if>
		</c:forEach>
		이(가) 포함된 직원
		</td></tr>
		</c:if>
	</c:forEach>
	

</table>

<!-- pc 페이징 표시 영역-->
<div class="paginate" align="center">
	<!-- 1페이지로 이동 처리 -->
	<a class="first" href="javascript:void(0);" title='처음' onclick="ajaxSearch(1, '${ sort }')"></a>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - limit) <= startPage and (currentPage - limit) >= 1 }">
	    <a class="prev" href="javascript:void(0);" title='이전그룹' onclick="ajaxSearch('${ startPage - limit }', '${ sort }')"></a>
	</c:if>
	<c:if test="${ !((currentPage - limit) <= startPage and (currentPage - limit) >= 1) }">
	    <a class='prev' href='#' style='cursor:default' title='이전그룹'></a>
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<a class='curr' href='#'>${ p }</a>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<a href="javascript:void(0);" onclick="ajaxSearch(${ p }, '${ sort }')">${ p }</a>
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + limit) > endPage and (endPage + 1 ) < maxPage }">
	    <a class='next' href="javascript:void(0);" title='다음그룹' onclick="ajaxSearch(${ endPage+1 }, '${ sort }')"></a>
	</c:if>
	<c:if test="${ !((currentPage + limit) > endPage and (endPage + 1) < maxPage) }">
	    <a class='next' href='#' style='cursor:default' title='다음그룹'></a>
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<a class="last" href="javascript:void(0);" title='끝'onclick="ajaxSearch(${ maxPage }, '${ sort }')"></a>
</div>