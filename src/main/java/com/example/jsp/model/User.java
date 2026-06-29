package com.example.jsp.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * [DTO / JavaBeans]
 * 사용자 정보를 담는 JavaBeans 규격의 DTO 클래스입니다.
 * 
 * 중요: EL(Expression Language) 표현식(예: ${user.name})은 JavaBeans 규격을 따릅니다.
 * JSP 컴파일러와 EL 서블릿 엔진은 백그라운드에서 해당 필드의 Getter 메서드(getName())를 찾아 호출합니다.
 * 따라서 getter 메서드가 누락되거나 명명 규칙을 따르지 않으면 런타임 에러가 발생합니다.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private String name;
    private String email;
    private String role;
    private int age;
    private boolean active;
    private LocalDateTime createdAt;

    // 1. 기본 생성자 (JavaBeans 규격 필수 사항)
    public User() {
        this.createdAt = LocalDateTime.now();
    }

    // 2. 편의 생성자
    public User(String name, String email, String role, int age, boolean active) {
        this.name = name;
        this.email = email;
        this.role = role;
        this.age = age;
        this.active = active;
        this.createdAt = LocalDateTime.now();
    }

    // 3. Getter / Setter 메서드 (EL 파서가 프로퍼티를 해석하는 기준)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    // boolean 타입의 getter 명명 규칙: isActive() 또는 getActive() 둘 다 가능하나, 보통 isActive() 사용
    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * EL에서 날짜 정보를 포맷팅된 문자열로 다이렉트 출력하기 위한 헬퍼 Getter.
     * JSP에서 ${user.formattedCreatedAt} 으로 편리하게 접근할 수 있습니다.
     */
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}
