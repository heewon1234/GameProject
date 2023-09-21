package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import commons.EncryptionUtils;
import dao.MembersDAO;
import dto.MembersDTO;


@WebServlet("*.members")
public class MembersController extends HttpServlet {
	// 시작
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		System.out.println(cmd);

		MembersDAO membersDAO = MembersDAO.getInstance();

		try {
			if(cmd.equals("/insert.members")) { // 회원가입

				String id = request.getParameter("id");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");
				int result = membersDAO.insert(new MembersDTO(id,password,name,phone,email,zipcode,address1,address2,null,"Player"));

				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/goToLogin.members")) { // 로그인 창으로 이동
				response.sendRedirect("/members/login.jsp");

			} else if(cmd.equals("/login.members")){ // 로그인 버튼 클릭 시

				String id = request.getParameter("id");
				String pw = EncryptionUtils.getSHA512(request.getParameter("pw"));
				String email = membersDAO.getEmail(id);
				boolean result = membersDAO.isAccountExist(id, pw);

				if(result) { 
					request.getSession().setAttribute("loginID", id); // session scope
					request.setAttribute("email", email); // session scope
				}
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/logout.members")) { // 로그아웃 버튼 클릭 시

				request.getSession().removeAttribute("loginID"); // 사용자의 키로 저장되어 있던 특정 정보 하나 제거
				request.getSession().invalidate(); // 사용자의 키로 저장되어 있던 정보 다 제거
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/goToSignUp")) { // 회원 가입 페이지 창으로 이동
				response.sendRedirect("/members/register.jsp");

			} else if(cmd.equals("/memberOut.members")) { // 회원 탈퇴 버튼 클릭 시 

				String id = (String)request.getSession().getAttribute("loginID");
				int result = membersDAO.delAccount(id);
				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/idSearch.members")) { // 아이디 찾기 



			} else if(cmd.equals("/goToIdSearch.members")) {
				response.sendRedirect("/members/id_Search.jsp");
			} else if(cmd.equals("/pwSearch.members")) { // 비밀번호 찾기



			} else if(cmd.equals("/goToPwSearch.members")) {
				response.sendRedirect("/members/pw_Search.jsp");
			} else if(cmd.equals("/update.members")) { // 마이페이지 - 내 정보 수정

				request.setCharacterEncoding("utf8");
				String id = (String)request.getSession().getAttribute("loginID");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");

				int result = membersDAO.updateAccount(new MembersDTO(id, password, name, phone, email, zipcode, address1, address2, null, null));
				response.sendRedirect("/mypage.members");

			} else if(cmd.equals("/mypage.members")) { // 마이페이지로 이동

				String id = (String)request.getSession().getAttribute("loginID");
				MembersDTO list = membersDAO.mypage(id);
				request.setAttribute("list", list);
				request.getRequestDispatcher("/members/mypage.jsp").forward(request, response);

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
