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
		<c:when test="${ sort == 'gender asc' }">
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
			<td class="center">${ s.staff_name }</td>
			<td class="center"><c:if
					test="${ fn:substring(s.jumin_no,7,8 ) eq '1' || fn:substring(s.jumin_no,7,8 ) eq '3' }">
		남
		</c:if> <c:if
					test="${ fn:substring(s.jumin_no,7,8 ) eq '2' || fn:substring(s.jumin_no,7,8 ) eq '4' }">
		여
		</c:if></td>
			<td width="225" class="center"><c:forEach items="${ dlist }" var="d"
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
	</c:forEach>


</table>

<!-- pc 페이징 표시 영역-->
<div class="paginate" align="center">
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<a class='curr' href='#'>[${ p }]</a>&nbsp;
					</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="ql" value="/ajaxSearch.do">
				<c:param name="page" value="${ p }" />
				<c:param name="staff_keyword" value="${ staff_keyword }" />

				<c:forEach items="${ gender }" var="g">
					<c:param name="gender" value="${ g }" />
				</c:forEach>

				<c:forEach items="${ school_code }" var="s">
					<c:param name="school_code" value="${ s }" />
				</c:forEach>

				<c:forEach items="${ skill_code}" var="sCode">
					<c:param name="skill_code" value="${ sCode }" />
				</c:forEach>

				<c:param name="department_code" value="${ department_code }" />
				<c:param name="startDate" value="${ startDate }" />
				<c:param name="endDate" value="${ endDate }" />
			</c:url>
			<a href="javascript:void(0);" onclick="ajaxSearch(${ p }, '${ sort }')">${ p }</a>&nbsp;
					</c:if>
	</c:forEach>

</div>