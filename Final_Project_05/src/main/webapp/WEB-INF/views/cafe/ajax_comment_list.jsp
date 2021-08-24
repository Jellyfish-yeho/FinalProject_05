<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="tmp" items="${commentList }">
	<c:choose>
		<c:when test="${tmp.deleted eq 'yes' }">
			<li>삭제된 댓글입니다.</li>
		</c:when>
		<c:otherwise>
			 <c:if test="${tmp.num eq tmp.comment_group }">
	            <li id="reli${tmp.num }" class="page-${pageNum }">
	         </c:if>
	         <c:if test="${tmp.num ne tmp.comment_group }">
	            <li id="reli${tmp.num }" class="page-${pageNum }" style="padding-left:50px;">
	               <svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
	                    <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
	               </svg>
	         </c:if>
	         <dl>
	         	<dt>
	         		<c:if test="${ empty tmp.profile }">
                         <svg class="profile-image me-2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
	                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
	                          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
	                     </svg>
                     </c:if>
                     <c:if test="${not empty tmp.profile }">
                        <img class="profile-image me-2" src="${pageContext.request.contextPath}${tmp.profile }"/>
                     </c:if>
                     <span class="fw-bold">${tmp.writer }</span>
					<span class="fw-light text-muted mx-1">${tmp.regdate }</span>
	         	</dt>
	         	<dd>
	         		<c:if test="${tmp.num ne tmp.comment_group }">
                         <span class="p-1 m-1 text-muted" style="font-size:.875rem;">
	                     	@<i>${tmp.target_id }</i>
	                     </span>
                     </c:if>
                     <pre id="pre${tmp.num }">${tmp.content }</pre>  
			         <a data-num="${tmp.num }" href="javascript:" class="reply-link text-decoration-none"
		                     style="padding-left:9.5px; color:#198754;">댓글</a>
                     <c:if test="${ (id ne null) and (tmp.writer eq id) }">
                        <a data-num="${tmp.num }" class="update-link text-decoration-none link-dark px-2" href="javascript:">수정</a>
                        <a data-num="${tmp.num }" class="delete-link text-decoration-none link-dark" href="javascript:">삭제</a>
                     </c:if>
	         	</dd>
	         	<dd>
	         		<%--대댓글 폼 --%>
	         		<form id="reForm${tmp.num }" class="animate__animated comment-form re-insert-form" 
					action="private/comment_insert.jsp" method="post">
						<input type="hidden" name="ref_group"
						value="${num }"/>
						<input type="hidden" name="target_id"
	 					value="${tmp.writer }"/>
	 					<input type="hidden" name="comment_group"
						value="${tmp.comment_group }"/>
						<textarea name="content"></textarea>
						<div align="right">
						<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
						</div>
					</form> 
	         	</dd>
	         	<dd>
	         		<%--대댓글 수정 폼 --%>
	         		<c:if test="${tmp.writer eq id }">
		               <form id="updateForm${tmp.num }" class="comment-form update-form" action="comment_update.do" method="post">
		                  <input type="hidden" name="num" value="${tmp.num }" />
		                  <textarea name="content">${tmp.content }</textarea>
		                  <div align="right">
							<button class="btn btn-sm btn-outline-success" type="submit">수정</button>
						  </div>
		               </form>
		            </c:if>
	         	</dd>
	         </dl>
		</c:otherwise>
	</c:choose>
</c:forEach>