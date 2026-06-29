<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 공통 헤더 include (컴파일 타임 정적 합성) --%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<main class="dashboard-grid" style="grid-template-columns: 1fr; gap: 2.5rem;">
    
    <%-- 상단 웰컴 카드 --%>
    <section class="card" style="background: linear-gradient(135deg, rgba(30,41,59,0.8) 0%, rgba(15,23,42,0.9) 100%);">
        <h1 style="font-size: 2.2rem; font-weight: 800; margin-bottom: 0.5rem; background: linear-gradient(90deg, #ffffff 0%, #f59e0b 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            JSP &amp; Servlet MVC 실습 교안 대시보드
        </h1>
        <p style="color: var(--text-secondary); font-size: 1.1rem; max-width: 800px; margin-bottom: 1.5rem;">
            본 예제는 서블릿(Servlet)과 JSP(JavaServer Pages)의 상호보완적 연동, MVC 아키텍처 패턴의 데이터 전달 방식, 
            그리고 현대 웹 아키텍처의 트렌드 변화를 직접 코드로 실행해 보며 이해할 수 있도록 설계되었습니다.
        </p>
        <a href="${pageContext.request.contextPath}/users" class="btn" style="width: auto; padding: 0.75rem 2rem; display: inline-flex; border-radius: 50px;">
            MVC 실습 실행하기 (회원 관리) &rarr;
        </a>
    </section>

    <%-- 중간 2열 배치: 학습 체크리스트 vs JSP 보안 주석 및 MVC --%>
    <div style="display: grid; grid-template-columns: 1.2fr 1.8fr; gap: 2rem;">
        
        <%-- 학습 체크리스트 --%>
        <section class="card">
            <h2 class="card-title">학습 체크리스트</h2>
            <ul style="list-style: none; display: flex; flex-direction: column; gap: 1.2rem; margin-top: 1rem;">
                <li style="display: flex; align-items: flex-start; gap: 0.75rem;">
                    <input type="checkbox" checked disabled style="width: 18px; height: 18px; accent-color: var(--success); margin-top: 3px;">
                    <div>
                        <strong>서블릿과 JSP의 상호보완 역할 분담</strong>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);">로직은 서블릿(Java), 화면은 JSP(HTML)가 맡는 분리 설계</p>
                    </div>
                </li>
                <li style="display: flex; align-items: flex-start; gap: 0.75rem;">
                    <input type="checkbox" checked disabled style="width: 18px; height: 18px; accent-color: var(--success); margin-top: 3px;">
                    <div>
                        <strong>JSP 보안 경로와 포워드 메커니즘</strong>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);">WEB-INF 하위 리소스 보호 및 Dispatcher 포워드 활용</p>
                    </div>
                </li>
                <li style="display: flex; align-items: flex-start; gap: 0.75rem;">
                    <input type="checkbox" checked disabled style="width: 18px; height: 18px; accent-color: var(--success); margin-top: 3px;">
                    <div>
                        <strong>include 지시어와 정적 합성</strong>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);">include 지시어(&lt;%@ include file="..." %&gt;)를 통한 컴파일 시점의 소스코드 단일화 및 변수 공유</p>
                    </div>
                </li>
                <li style="display: flex; align-items: flex-start; gap: 0.75rem;">
                    <input type="checkbox" checked disabled style="width: 18px; height: 18px; accent-color: var(--success); margin-top: 3px;">
                    <div>
                        <strong>EL 표현식과 JSTL 태그 라이브러리</strong>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);">${user.name} 객체 매핑 및 의존성 구성(GlassFish 구현체)</p>
                    </div>
                </li>
                <li style="display: flex; align-items: flex-start; gap: 0.75rem;">
                    <input type="checkbox" checked disabled style="width: 18px; height: 18px; accent-color: var(--success); margin-top: 3px;">
                    <div>
                        <strong>현대 웹 아키텍처 위상 변화 분석</strong>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);">Thymeleaf의 강세, CSR(React/Vue) 확산 및 JAR 배포 페널티</p>
                    </div>
                </li>
            </ul>
        </section>

        <%-- 이론 핵심 분석 --%>
        <section class="card">
            <h2 class="card-title">이론 요약 및 핵심 설계 원칙</h2>
            
            <div style="display: flex; flex-direction: column; gap: 1.5rem; margin-top: 1rem;">
                <div>
                    <h3 style="color: var(--accent); font-size: 1.05rem; margin-bottom: 0.3rem;">1. 스파게티 코드 극복 (MVC 책임 분리)</h3>
                    <p style="font-size: 0.9rem; color: var(--text-secondary);">
                        과거 JSP에 자바 코드 스크립틀릿(<code>&lt;% ... %&gt;</code>)을 무분별하게 혼용하면서 유지보수가 불가능해졌습니다.
                        이를 극복하고자 <strong>Controller(Servlet)</strong>가 비즈니스 연산 및 DTO 모델 바인딩을 주도하고, 
                        <strong>View(JSP)</strong>는 EL/JSTL을 활용하여 렌더링에만 집중하도록 역할을 엄격히 단절했습니다.
                    </p>
                </div>
                
                <div>
                    <h3 style="color: var(--accent); font-size: 1.05rem; margin-bottom: 0.3rem;">2. WEB-INF와 포워드(Forward)</h3>
                    <p style="font-size: 0.9rem; color: var(--text-secondary);">
                        JSP를 루트 디렉토리에 두면 브라우저가 다이렉트 URL로 접속할 수 있어 모델이 비어있는 채 에러 화면이 출력되는 보안 결함이 발생합니다.
                        규격상 <code>WEB-INF/views/</code> 하위 경로는 브라우저의 직접 호출이 원천 봉쇄되므로, 
                        오직 서블릿 컨트롤러에서 <code>RequestDispatcher.forward()</code>를 통해서만 안전하게 통제 접근합니다.
                    </p>
                </div>

                <div>
                    <h3 style="color: var(--accent); font-size: 1.05rem; margin-bottom: 0.3rem;">3. JSP 보안 주석 (Security Comment)</h3>
                    <p style="font-size: 0.9rem; color: var(--text-secondary);">
                        일반 HTML 주석(<code>&lt;!-- --&gt;</code>)은 브라우저 렌더링 시점에 소스보기로 노출되어 내부 비즈니스 힌트 등 보안 위협이 될 수 있습니다.
                        반면, JSP 보안 주석(<code>&lt;%-- --%&gt;</code>)은 WAS 컴파일 시점에 자바 소스에서 완전히 제외되어 클라이언트에 단 1바이트도 노출되지 않습니다.
                    </p>
                </div>
            </div>
        </section>
    </div>

    <%-- 하단: 의존성 및 현대적 트렌드 고찰 --%>
    <section class="card">
        <h2 class="card-title">의존성 분석 및 기술 변화 트렌드</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 1rem;">
            <div>
                <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem; color: var(--text-primary);">JSTL 런타임 구현체 의존성</h3>
                <p style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 0.8rem;">
                    EL 파서는 WAS(Tomcat 등)에 내장되어 있어 별도 설정 없이 동작하지만, 
                    <strong>JSTL</strong>은 스펙 API와 이를 파싱해 줄 실제 <strong>GlassFish 구현체 라이브러리</strong>가 필요합니다.
                    이를 누락하면 런타임 시 <code>Absolute uri cannot be resolved</code> 에러가 발생하므로 
                    <code>pom.xml</code>에 명시적으로 두 의존성을 추가해 주었습니다.
                </p>
                <pre style="background: rgba(15, 23, 42, 0.8); padding: 0.8rem; border-radius: 8px; border: 1px solid var(--panel-border); font-size: 0.8rem; color: #fde68a; overflow-x: auto;">
&lt;!-- JSTL API &amp; GlassFish Implementation --&gt;
&lt;dependency&gt;
    &lt;groupId&gt;jakarta.servlet.jsp.jstl&lt;/groupId&gt;
    &lt;artifactId&gt;jakarta.servlet.jsp.jstl-api&lt;/artifactId&gt;
    &lt;version&gt;3.0.0&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
    &lt;groupId&gt;org.glassfish.web&lt;/groupId&gt;
    &lt;artifactId&gt;jakarta.servlet.jsp.jstl&lt;/artifactId&gt;
    &lt;version&gt;3.0.1&lt;/version&gt;
&lt;/dependency&gt;</pre>
            </div>
            
            <div>
                <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem; color: #fca311;">현대 웹 생태계와 JSP의 한계</h3>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">
                    현재 실무에서 신규 프로젝트에 JSP를 채택하는 경우는 거의 없습니다:
                </p>
                <ul style="padding-left: 1.2rem; font-size: 0.9rem; color: var(--text-secondary); display: flex; flex-direction: column; gap: 0.5rem; margin-top: 0.5rem;">
                    <li><strong>Spring Boot의 JSP 배제:</strong> Spring Boot는 템플릿 엔진으로 Thymeleaf를 권장하며 JSP 기본 설정을 제공하지 않습니다.</li>
                    <li><strong>JAR 배포 불가능:</strong> 내장 WAS를 단일 실행 파일로 배포하는 현대 추세에서, JSP는 WAR 패키징 및 외부 톰캣 세팅이 강제되어 JAR 배포가 불가능합니다.</li>
                    <li><strong>CSR 아키텍처 확산:</strong> 백엔드는 RESTful API(JSON 반환)에 집중하고, 화면은 React, Vue, Svelte 등의 프레임워크가 브라우저에서 동적으로 그리는 CSR(Client-Side Rendering)로 완전히 이동하였습니다.</li>
                </ul>
            </div>
        </div>
    </section>

</main>

<%-- 공통 푸터 include --%>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>