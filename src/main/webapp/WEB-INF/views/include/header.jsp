<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP & Servlet MVC 실습교안</title>
    <!-- 
      JSP의 정적 컴파일타임 include 기법을 실습하기 위해 공통 헤더를 분리했습니다.
      이 파일은 include 지시어(include 지시자)를 통해 호출하는 JSP 파일의 본문에
      소스코드 수준에서 그대로 복사되어 병합됩니다. 단 하나의 서블릿 클래스로 합쳐지기 때문에
      CSS 링크나 변수 선언 등을 공유하여 사용할 수 있습니다.
    -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="nav-container">
                <a href="${pageContext.request.contextPath}/" class="logo-link">
                    <div class="logo">
                        JSP MVC Study <span>Servlet 6.0 + JSTL 3.0</span>
                    </div>
                </a>
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/" class="${pageContext.request.requestURI.endsWith('index.jsp') || pageContext.request.requestURI == pageContext.request.contextPath ? 'active' : ''}">학습 체크리스트</a></li>
                        <li><a href="${pageContext.request.contextPath}/users" class="${pageContext.request.requestURI.contains('/users') ? 'active' : ''}">회원 관리 (MVC 실습)</a></li>
                    </ul>
                </nav>
            </div>
        </header>
