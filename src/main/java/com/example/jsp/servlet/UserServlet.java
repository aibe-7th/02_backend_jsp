package com.example.jsp.servlet;

import com.example.jsp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * [Controller - Servlet]
 * 사용자 요청을 수신하여 비즈니스 로직을 처리하고, 데이터를 가공한 뒤 뷰(JSP)로 넘기는 컨트롤러 역할을 수행합니다.
 * 
 * `@WebServlet` 애너테이션을 통해 URL 매핑을 설정합니다.
 */
@WebServlet(name = "userServlet", urlPatterns = {"/users", "/users/add"})
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // 멀티스레드 환경에서 안전하도록 CopyOnWriteArrayList를 사용하여 인메모리 회원 목록을 시뮬레이션합니다.
    private final List<User> userList = new CopyOnWriteArrayList<>();

    @Override
    public void init() throws ServletException {
        // 실습 화면을 처음 열었을 때 볼 수 있도록 기초 샘플 데이터를 삽입합니다.
        userList.add(new User("김철수", "cheolsu@example.com", "ADMIN", 28, true));
        userList.add(new User("이영희", "younghee@example.com", "USER", 24, true));
        userList.add(new User("박민수", "minsu@example.com", "GUEST", 31, false));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Model 가공: 인메모리 목록 데이터를 request 보관소에 저장합니다.
        // request.setAttribute("키", 값) 형식으로 바인딩하며, JSP에서는 EL로 ${키}와 같이 참조합니다.
        request.setAttribute("users", userList);
        
        // 2. View 포워드: 클라이언트가 브라우저 주소창에 직접 입력하여 접근할 수 없는 
        // 보안 경로 '/WEB-INF/views/user-list.jsp'로 포워딩 처리를 합니다.
        // 포워드는 서버 내부에서 이동하므로 웹 브라우저의 URL 주소는 바뀌지 않습니다.
        request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // POST 요청 처리 (신규 사용자 등록)
        // 서블릿 6.0/톰캣 10+ 환경에서는 UTF-8 인코딩이 기본이지만, 레거시 호환을 위해 명시적으로 세팅해 둡니다.
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String ageStr = request.getParameter("age");
        String activeStr = request.getParameter("active"); // 체크박스: 온이면 "on", 해제면 null

        // 간단한 유효성 검사
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "이름과 이메일은 필수 입력 항목입니다.");
            request.setAttribute("users", userList);
            // 오류가 발생한 경우 입력 폼이 있는 JSP로 포워딩하여 기존 입력 상태를 보존하고 경고창을 띄웁니다.
            request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
            return;
        }

        int age = 0;
        try {
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                age = Integer.parseInt(ageStr.trim());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "나이는 올바른 숫자 형식이어야 합니다.");
            request.setAttribute("users", userList);
            request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
            return;
        }

        boolean active = "on".equals(activeStr);

        // 새로운 사용자 생성 및 목록에 추가
        User newUser = new User(name.trim(), email.trim(), role, age, active);
        userList.add(newUser);

        // [PRG 패턴 (Post-Redirect-Get) 적용]
        // POST 요청 완료 후 바로 포워딩을 수행하면 사용자가 브라우저를 '새로고침' 할 때마다 
        // 동일한 POST 요청이 중복되어 회원이 중복 가입되는 결함이 생깁니다.
        // 이를 방지하기 위해 클라이언트에게 GET 방식으로 다시 목록 조회를 요청하도록 Redirect를 지시합니다.
        response.sendRedirect(request.getContextPath() + "/users");
    }
}
