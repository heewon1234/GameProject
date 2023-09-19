package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.members")
public class MembersController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		
		try {
			if(cmd.equals("/insert.members")) { // 회원가입
				
			} else if(cmd.equals("/goToLogin.members")) { // 로그인 창으로 이동
				
			} else if(cmd.equals("/login.members")){ // 로그인 버튼 클릭 시
				
			} else if(cmd.equals("/logout.members")) { // 로그아웃 버튼 클릭 시
				
			} else if(cmd.equals("/goToSignUp")) { // 회원 가입 페이지 창으로 이동
				
			} else if(cmd.equals("/memberOut.members")) { // 회원 탈퇴 버튼 클릭 시 
				
			} else if(cmd.equals("/idSearch.members")) { // 아이디 찾기 
				
			} else if(cmd.equals("/goToIdSearch.members")) {
				
			} else if(cmd.equals("/pwSearch.members")) { // 비밀번호 찾기
				
			} else if(cmd.equals("/goToPwSearch.members")) {
				
			} else if(cmd.equals("/update.members")) { // 마이페이지 - 내 정보 수정
				
			} else if(cmd.equals("/goToMyPage.members")) { // 마이페이지로 이동
				
			}
			
		} catch(Exception e) {
			
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
