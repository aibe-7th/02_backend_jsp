# JSP & Servlet MVC 실습 교안

본 프로젝트는 서블릿(Servlet)과 JSP(JavaServer Pages)의 상호보완적 역할 분담 및 MVC 아키텍처 패턴을 실습하기 위해 제작된 웹 애플리케이션 교안입니다. Jakarta EE 10 (Servlet 6.0) 스펙과 Java 17 이상 버전으로 구성되어 있으며, 현대 웹 아키텍처의 트렌드 변화에 따른 JSP 기술의 한계와 실무 유지보수 관점까지 모두 다룹니다.

---

## 📂 프로젝트 구조 및 매칭 핵심 파일

학습 내용과 연관된 핵심 소스코드 구조는 다음과 같습니다.

1. **빌드 설정 및 JSTL 라이브러리 탑재**
   - `pom.xml`: Java 17 버전 설정, JSTL API 및 GlassFish JSTL 구현체 의존성 세팅.
2. **DTO (JavaBeans Model)**
   - `User.java`: EL(Expression Language) 표현식이 백그라운드에서 필드 매핑 시 참조하는 JavaBeans Getter/Setter 규격을 따르는 데이터 객체.
3. **Controller (Servlet)**
   - `UserServlet.java`: 클라이언트 요청 가공, 비즈니스 데이터 모델 바인딩(`request.setAttribute`), 보안 경로로의 포워딩(`forward`), 새로고침에 따른 중복 등록 방지를 위한 **PRG(Post-Redirect-Get)** 패턴 처리.
4. **View (JSP)**
   - `user-list.jsp`: `WEB-INF/` 하위에 배치되어 외부 직접 호출이 봉쇄된 보안 뷰 페이지. EL 및 JSTL 제어 태그(`<c:if>`, `<c:forEach>`)로 구성.
5. **정적 복사 페이지 모듈화 (Include Fragment)**
   - `header.jsp`: 공통 CSS 링크 및 상단 내비게이션 바.
   - `footer.jsp`: 공통 하단 영역 표시 및 톰캣이 내부 컴파일 시 합치게 되는 물리적 결합부.
6. **메인 요약 대시보드 및 학습 체크리스트**
   - `index.jsp`: 학습 체크리스트와 핵심 이론 요약이 담긴 랜딩 페이지.
7. **세련된 UI 디자인 스타일링**
   - `style.css`: 다크 테마 및 글래스모피즘(Glassmorphism) 스타일을 적용한 스타일시트.

---

## 🎯 학습 핵심 포인트 및 접근법

### 1. 서블릿(Servlet)과 JSP의 상호보완적 분담
- **서블릿의 역할 (Controller)**: 자바 언어를 활용하여 비즈니스 연산, 데이터베이스 통신, 데이터 가공(DTO 생성)을 처리합니다. 자바 코드 안에서 HTML을 출력하는 극심한 유지보수 결함을 해결합니다.
- **JSP의 역할 (View)**: HTML 코드 중심의 레이아웃 안에서 EL과 JSTL만을 사용하여 화면을 렌더링합니다. 비즈니스 로직 및 DB 연동 코드는 절대 작성하지 않습니다.

### 2. JSP 보안 경로(WEB-INF)와 포워드(Forward)
- JSP 파일을 웹 루트 디렉토리(예: `src/main/webapp/`)에 배치하면 브라우저가 다이렉트 URL로 접속할 수 있습니다. 이는 서버 내부 데이터 바인딩을 생략하여 NullPointerException 등의 에러 페이지를 유발하고 비즈니스 흐름을 깹니다.
- `WEB-INF/` 디렉토리는 클라이언트(브라우저)에서 어떠한 다이렉트 URL로도 접근이 원천 차단됩니다.
- 오직 서버 사이드 컨트롤러인 `HttpServlet.doGet` 등에서 `request.getRequestDispatcher("/WEB-INF/views/...").forward(...)`를 실행할 때만 내부적으로 제어권을 받아 화면을 출력합니다.

### 3. include 지시어와 컴파일 타임 정적 합성
- `<%@ include file="..." %>` 방식은 WAS(Tomcat 등)가 JSP 파일을 자바 서블릿 코드로 변환할 때, 지정된 조각 파일의 소스코드를 그대로 읽어와서 병합합니다.
- 변환 결과는 단 하나의 자바 클래스로 합쳐지기 때문에, 동일한 변수명과 스타일시트, 요청 범위를 에러 없이 가볍고 안전하게 공유할 수 있습니다.

### 4. EL과 JSTL의 관계 및 의존성
- **EL(Expression Language)**: `${user.name}` 형식으로 사용하며, WAS(Tomcat 등) 내부에 자체 파서가 내장되어 있어 별도의 `pom.xml` 의존성 없이 즉시 기동됩니다.
- **JSTL(JSP Standard Tag Library)**: `<c:if>`, `<c:forEach>` 등 조건/반복 제어를 담당하며, 톰캣 스펙 자체에는 **구현체가 없습니다**. 따라서 `pom.xml`에 API 규격(api)과 실제 컴파일 및 파싱을 수행해 줄 **GlassFish 구현체(implementation)** 라이브러리를 둘 다 설정해 주어야 런타임 404/500 에러를 방지할 수 있습니다.

### 5. 현대 웹 아키텍처에서 JSP의 위상 쇠퇴 요인
- **CSR(Client-Side Rendering) 대중화**: 백엔드는 RESTful API(JSON 응답) 역할에 충족하고, 화면은 React, Vue, Svelte 등 프론트엔드가 브라우저 내부에서 동적으로 렌더링하는 형태로 변경되었습니다.
- **Spring Boot 생태계의 JSP 배제**: 스프링 부트는 기본적으로 Thymeleaf를 표준 뷰 엔진으로 지지하며, JSP 구동 엔진은 기본 빌드에 들어있지 않습니다.
- **JAR 배포 페널티**: 내장 톰캣을 이용해 하나의 파일(`java -jar app.jar`)로 즉시 클라우드 등에 배포하는 현대 웹 환경에서, JSP는 내장 WAS 구동 시 특정 경로 컴파일에 한계가 있어 **JAR 빌드가 원천 불가능(WAR 강제)**합니다.


---

## 📘 레포지토리 파일을 활용한 EL & JSTL 실습 순서 및 방법

본 프로젝트의 소스코드를 직접 수정하고 검증하며 EL과 JSTL의 작동 원리를 체계적으로 학습하는 순서입니다.

### 1단계: JavaBeans 프로퍼티 매핑 및 EL 출력 실습
- **수정 대상 파일**: `src/main/java/com/example/jsp/model/User.java` 및 `src/main/webapp/WEB-INF/views/user-list.jsp`
- **실습 방법**:
  1. `User.java` 파일에 새로운 멤버 변수로 `private String nickname;`을 정의하고, 이에 대응하는 Getter/Setter 메서드인 `getNickname()`과 `setNickname()`을 생성합니다.
  2. `UserServlet.java` 파일의 `init()` 메서드로 이동하여, 초기 생성 데이터에 임의의 닉네임을 설정하는 코드를 채웁니다 (예: `newUser.setNickname("홍길동닉");`).
  3. `user-list.jsp` 파일의 회원 목록 테이블 헤더(`<thead>`) 영역에 `<th>닉네임</th>` 열을 추가하고, 테이블 본문(`<tbody>`)의 반복 루프 내에 `${user.nickname}` 표현식을 사용하여 열을 추가합니다.
  4. 프로젝트를 빌드 및 재배포하여, EL 표현식이 `User.java`에 정의한 `getNickname()` 메서드를 자바 리플렉션으로 자동 매핑하여 화면에 출력하는 구조를 검증합니다.

### 2단계: JSTL 의존성 예외 확인 및 복구 실습
- **수정 대상 파일**: `pom.xml`
- **실습 방법**:
  1. `pom.xml` 파일의 `<dependencies>` 블록에서 Glassfish JSTL 구현체 라이브러리인 `org.glassfish.web:jakarta.servlet.jsp.jstl` 의존성 구문을 찾아서 전체 주석 처리(`<!-- -->`)합니다.
  2. Maven 프로젝트 로드 후 WAR 파일을 빌드 및 재배포합니다.
  3. 웹 브라우저를 통해 `/users` 주소로 접속해 봅니다. JSTL의 실제 구현체가 부재하여 톰캣 엔진이 JSTL 커스텀 태그를 해석하지 못하고 `Absolute uri cannot be resolved` 500 예외 혹은 빈 화면을 뱉어내는 런타임 결함 상황을 직접 관찰합니다.
  4. 관찰이 끝난 후 `pom.xml`에서 주석을 풀고 다시 빌드하여 정상 가동 상태로 복구하면서, 슬라이드에서 배운 **JSTL 구현체 라이브러리 탑재의 중요성**을 체험합니다.

### 3단계: JSTL 지시자 선언 및 커스텀 분기 처리 실습
- **수정 대상 파일**: `src/main/webapp/WEB-INF/views/user-list.jsp`
- **실습 방법**:
  1. `user-list.jsp` 파일의 최상단 2라인에 정의된 `<%@ taglib prefix="c" uri="jakarta.tags.core" %>` 지시자 선언 구문을 임시로 제거해 봅니다.
  2. 브라우저로 재접속하여, JSTL 태그가 WAS에서 해석되지 않고 단순 HTML 텍스트 문자열(예: `<c:if ...>`) 상태 그대로 노출되는 화면을 목격하고 `taglib` 디렉티브 선언의 필수성을 이해합니다.
  3. `taglib`을 복구한 후, 회원 권한(ADMIN, USER, GUEST)에 따라 각기 다른 디자인 색상 뱃지가 적용되는 조건식 로직(`<c:choose>`)을 다른 조건(예: 나이가 30세 이상인 회원에게만 특정 강조 스타일 추가 등)으로 자유롭게 변경/추가해 보며 JSTL 조건 제어의 원리를 습득합니다.

### 4단계: 스크립틀릿 완전 배제 및 MVC 구조의 완성형 흐름 검증
- **수정 대상 파일**: `src/main/java/com/example/jsp/servlet/UserServlet.java` 및 `src/main/webapp/WEB-INF/views/user-list.jsp`
- **실습 방법**:
  1. `user-list.jsp` 내부를 면밀히 분석하며 `<% ... %>`(스크립틀릿), `<%= ... %>`(표현식), `<%! ... %>`(선언문) 등 가독성을 해치고 스파게티 코드를 유발하는 자바 문법 코드가 완전히 차단된 상태를 점검합니다.
  2. `UserServlet.java`에서 비즈니스 로직과 컬렉션 리스트 연산을 완결한 후 `request.setAttribute("users", userList);`를 통해 request 스코프 보관소에 Model 데이터를 적재하는 컨트롤러 코드를 확인합니다.
  3. 이렇게 가공된 데이터를 전달받은 `user-list.jsp`가 오직 EL `${users}`와 JSTL `<c:forEach>` 조합만으로 화면 레이아웃에 맞게 최종 렌더링을 마치는 MVC 분리의 완성형 파이프라인을 최종 분석하고 점검합니다.

---

## 🚀 실습 진행 순서

### 1단계: 빌드 및 Tomcat 배포 설정
1. 프로젝트를 빌드하여 WAR 파일을 생성합니다.
   ```bash
   ./mvnw clean package
   ```
2. IntelliJ IDEA 상단 메뉴에서 **[Run] -> [Edit Configurations...]**를 클릭합니다.
3. **[+] (Add New Configuration)** -> **[Tomcat Server] -> [Local]**을 선택합니다.
4. Application Server에 본인의 **Tomcat 10.1 이상** 버전을 연결해 줍니다.
5. **[Deployment]** 탭으로 이동하여 **[+] -> [Artifact...]**를 누르고 `jsp:war` 또는 `jsp:war exploded`를 추가합니다.
6. Application context 경로를 `/` 혹은 원하는 경로(예: `/jsp`)로 지정한 뒤 설정을 저장합니다.
7. 실행 버튼(Run/Debug)을 눌러 톰캣 서버를 시작합니다.

### 2단계: 메인 학습 대시보드 분석
- 서버가 켜지면 브라우저를 열고 `http://localhost:8080/` (설정한 포트와 컨텍스트 경로에 맞게 접속)로 들어갑니다.
- 메인 화면에 출력된 **학습 체크리스트**와 **이론 요약**을 읽고 학습 가이드를 숙지합니다.

### 3단계: 회원 관리 MVC 실습 페이지로 이동
- 상단 내비게이션 바의 **[회원 관리 (MVC 실습)]**를 클릭하거나 주소창에 `/users`를 추가하여 이동합니다.
- 이미 서블릿의 `init()` 메서드를 통해 기본 탑재된 초기 사용자(김철수, 이영희, 박민수) 테이블을 확인할 수 있습니다.
- 브라우저의 소스보기(`Cmd + Option + U` 또는 마우스 우클릭 -> 페이지 소스 보기)를 실행하여, JSP 보안 주석(`<%-- --%>`) 및 컨트롤러의 로직 힌트가 클라이언트에게 노출되지 않는 것을 직접 검증합니다.

### 4단계: 신규 회원 추가 실습 (POST -> Redirect -> GET 검증)
- 왼쪽 카드 영역의 폼(Form)에 이름, 이메일, 나이, 역할, 활성화 상태를 입력하고 **[등록하기]** 버튼을 클릭합니다.
- 데이터가 즉각 회원 목록 테이블에 반영되는 것을 확인합니다.
- **PRG 패턴 검증**: 회원이 등록된 후 브라우저 화면에서 새로고침(`Cmd + R`)을 연달아 수행해 봅니다. GET 요청으로만 리다이렉트되어 있으므로 양식 재전송 경고창이 뜨지 않고 회원 중복 추가가 발생하지 않습니다.
- **유효성 검증 테스트**: 필수 값인 이름이나 이메일을 비워두거나 나이 칸에 부적절한 값을 적고 서버에 보내봅니다. 서블릿 유효성 검사기에 걸려 오류 알림(errorMessage)이 출력되고, 기존 입력폼에 상태가 고스란히 남아있는 포워드(Forward) 보존 기능을 확인합니다.

### 5단계: WEB-INF 외부 직접 접근 차단 검증
- 주소창에 `http://localhost:8080/WEB-INF/views/user-list.jsp`를 직접 입력하여 접근을 시도해 봅니다.
- 브라우저에 **404 Not Found** 또는 접근 제한 에러가 표시되는지 관찰하며 보안 디렉토리 설계의 핵심을 습득합니다.
