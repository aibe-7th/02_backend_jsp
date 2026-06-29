<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 
  [JSP 뷰 파일 (View)]
  이 파일은 WEB-INF/views 폴더에 숨겨져 있으므로 웹 브라우저가 직접 URL(예: http://localhost:8080/WEB-INF/views/user-list.jsp)로 접근할 수 없습니다.
  오직 서블릿 컨트롤러(UserServlet)가 request.getRequestDispatcher().forward()를 사용해 
  서버 내부적으로 포워딩을 수행했을 때만 렌더링되어 클라이언트에게 반환됩니다.
--%>

<%-- 1. 컴파일 타임 공통 헤더 조각 합성 --%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<main class="dashboard-grid">
    
    <%-- 왼쪽 구역: 신규 회원 등록 폼 --%>
    <section class="card">
        <h2 class="card-title">신규 회원 등록 (Controller POST 처리)</h2>
        
        <%-- 에러 메시지가 있을 경우 출력 (JSTL <c:if> 사용) --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                </svg>
                <span>${errorMessage}</span>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/users" method="post" autocomplete="off">
            <div class="form-group">
                <label for="name">이름 (Name)</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="홍길동" required value="${param.name}">
            </div>
            
            <div class="form-group">
                <label for="email">이메일 (Email)</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="gildong@example.com" required value="${param.email}">
            </div>
            
            <div class="form-group">
                <label for="age">나이 (Age)</label>
                <input type="number" id="age" name="age" class="form-control" placeholder="25" min="1" max="150" value="${param.age}">
            </div>
            
            <div class="form-group">
                <label for="role">역할 (Role)</label>
                <select id="role" name="role" class="form-control">
                    <option value="USER" ${param.role == 'USER' ? 'selected' : ''}>일반 사용자 (USER)</option>
                    <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>관리자 (ADMIN)</option>
                    <option value="GUEST" ${param.role == 'GUEST' ? 'selected' : ''}>방문객 (GUEST)</option>
                </select>
            </div>
            
            <label class="checkbox-group">
                <input type="checkbox" id="active" name="active" ${param.active == 'on' ? 'checked' : 'checked'}>
                계정 활성화 여부 (Active Status)
            </label>
            
            <button type="submit" class="btn" style="margin-top: 1.5rem;">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                </svg>
                등록하기
            </button>
        </form>
    </section>
    
    <%-- 오른쪽 구역: 회원 목록 테이블 --%>
    <section class="card">
        <h2 class="card-title">회원 목록 (EL & JSTL 데이터 바인딩)</h2>
        
        <div class="table-container">
            <%-- 2. 회원 목록이 비어 있는지 여부 확인 (<c:choose>) --%>
            <c:choose>
                <c:when test="${empty users}">
                    <div class="empty-state">
                        <svg width="48" height="48" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.109A11.386 11.386 0 0110.089 21c-2.902 0-5.54-1.088-7.54-2.881M21 8.656c0-1.201-.271-2.34-.756-3.359M11.718 16.65a9.024 9.024 0 01-2.783-.515c-.78-.209-1.402-.822-1.604-1.612a9.027 9.027 0 010-4.048c.202-.79.823-1.403 1.604-1.612a9.014 9.014 0 015.566 0c.78.209 1.402.822 1.604 1.612a9.025 9.025 0 010 4.048c-.202.79-.823 1.403-1.604 1.612a9.02 9.02 0 01-2.783.515zM8.084 9.75V3a.75.75 0 01.75-.75h6c.414 0 .75.336.75.75v6.75M8.084 9.75h7.832m-7.832 0v2.25M15.916 9.75v2.25"/>
                        </svg>
                        <p>등록된 회원이 없습니다. 왼쪽 폼에서 첫 회원을 등록해 보세요.</p>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>이름</th>
                                <th>이메일</th>
                                <th>역할</th>
                                <th>나이</th>
                                <th>상태</th>
                                <th>등록 일시</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- 3. JSTL 반복문 <c:forEach>로 회원 목록 순회 --%>
                            <c:forEach items="${users}" var="user" varStatus="status">
                                <tr>
                                    <%--
                                      EL(Expression Language) 문법 설명:
                                      - ${user.name}은 내부적으로 user.getName() 자바 메소드를 리플렉션하여 실행합니다.
                                      - 변수 보관소 범위(Request Scope)에서 'user'를 탐색한 후 알맞은 프로퍼티를 인쇄합니다.
                                    --%>
                                    <td><strong>${user.name}</strong></td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}">
                                                <span class="badge badge-role-admin">${user.role}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-role">${user.role}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${user.age}세</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.active}">
                                                <span class="badge badge-status">활성</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-status inactive">비활성</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <%-- user.formattedCreatedAt은 user.getFormattedCreatedAt()을 호출함 --%>
                                    <td><small>${user.formattedCreatedAt}</small></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<%-- 4. 컴파일 타임 공통 푸터 조각 합성 --%>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
