<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!-- 
          [JSP 정적 include 푸터 영역]
          헤더에서 열린 div.container 및 body, html 태그를 여기서 닫아 마크업의 완결성을 확보합니다.
          하나의 컴파일 단위(서블릿 자바 파일)로 묶이기 때문에, 헤더에서 로드한 변수나 컨텍스트를 동일하게 사용 가능합니다.
        -->
        <footer>
            <p>&copy; 2026 JSP &amp; Servlet MVC 실습 교재. All Rights Reserved.</p>
            <div class="footer-info">
                <span><strong>요청 URI:</strong> <%= request.getRequestURI() %></span>
                <span><strong>서블릿 컨텍스트:</strong> ${pageContext.request.contextPath}</span>
                <span><strong>WAS 엔진:</strong> Tomcat 10.1+ (Jakarta EE 10 / Servlet 6.0)</span>
            </div>
        </footer>
    </div> <!-- .container 종료 -->
</body>
</html>
