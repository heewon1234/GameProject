package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import commons.EncryptionUtils;
import dao.MembersDAO;
import dto.MembersDTO;

// 주석 추가


@WebServlet("*.members")
public class MembersController extends HttpServlet {

	private static String generateRandomCode(int length) {
		String chars = "0123456789"; //ABCDEFGHIJKLMNOPQRSTUVWXYZ
		StringBuilder code = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			code.append(chars.charAt(random.nextInt(chars.length())));
		}
		return code.toString();
	}

	private boolean verifyAuthenticationCode(HttpServletRequest request) { // 인증번호 확인
		// 세션에서 저장된 인증 코드 가져오기
		HttpSession session = request.getSession();

		// 사용자가 입력한 인증 코드
		String enteredCode = request.getParameter("code");

		String verificationCode = (String) session.getAttribute("verificationCode");

		System.out.println("Entered Code: " + enteredCode);

		return verificationCode != null && verificationCode.equals(enteredCode);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		response.setContentType("text/html;charset=utf8");
		request.setCharacterEncoding("utf8");
		PrintWriter pw = response.getWriter();

		MembersDAO membersDAO = MembersDAO.getInstance();
		Gson gson = new Gson();

		try {
			if(cmd.equals("/insert.members")) { // 회원가입

				String id = request.getParameter("id");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone = request.getParameter("phone_head") + request.getParameter("phone_body") + request.getParameter("phone_tail");
				String email1 = request.getParameter("email1");
				String email2 = request.getParameter("email2");
				String email = email1+"@"+email2;
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");

				MembersDTO membersDTO = new MembersDTO(id, password, name, phone, email, zipcode, address1, address2, null, null);

				boolean isDuplicatedEmail = membersDAO.isDuplicatedEmail(email);

				if (isDuplicatedEmail) {

			        response.getWriter().write("<script>alert('이메일이 이미 사용 중입니다. 다른 이메일을 선택해주세요.'); window.location='/members/register.jsp';</script>");
			    } else {
			        int result = membersDAO.insert(membersDTO);
			        

			        if (result > 0) {
			            System.out.println("회원가입 성공");
			            response.sendRedirect("/index.jsp");
			        } else {
			            response.sendRedirect("/error.jsp");
			        }
			    }

			}
			else if(cmd.equals("/idDupleCheck.members")) {
				String id = request.getParameter("id");
				boolean result = membersDAO.isDuplicatedID(id);

				pw.append(gson.toJson(result));
			}
			else if(cmd.equals("/emailDupleCheck.members")) {
				String email = request.getParameter("email");
				boolean result = membersDAO.isDuplicatedEmail(email);

				pw.append(gson.toJson(result));
			}
			else if (cmd.equals("/sendVerificationCode.members")) {
				HttpSession session = request.getSession();

				// 인증코드 발급
				String code = generateRandomCode(6);
				session.setAttribute("verificationCode", code);

				System.out.println("Stored Verification Code: " + code);

				// 이메일에 인증번호 전송 로직
				final String user = "teammarvel2023@gmail.com";
				final String emailPassword = "uhhj xwkr czfn xzsq";

				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.port", 465);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
				props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLSv1.2 사용

				Session emailSession = Session.getInstance(props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(user, emailPassword);
					}
				});

				MimeMessage message = new MimeMessage(emailSession);
				try {
					message.setFrom(new InternetAddress(user));

					// 이메일 입력 필드에서 이메일 값을 가져옴
					String email = request.getParameter("email");

					message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

					// 이메일 제목
					message.setSubject("요청하신 인증번호를 알려드립니다.");

					// 이메일 내용 (code는 인증번호)
					message.setText("아래의 인증번호를 인증번호 입력창에 입력해주세요\n\n"+"인증번호 발급 : [" + code + "]");

					// 메시지 전송
					Transport.send(message); 

					System.out.println("인증번호 발급 성공");

					// 성공적으로 이메일을 발송한 경우, 클라이언트에게 성공 응답을 보내기
					response.getWriter().write("success");

				} catch (AddressException e) {
					e.printStackTrace();
					// 이메일 주소 오류 처리
					response.getWriter().write("email_error");
				} catch (MessagingException e) {
					e.printStackTrace();
					// 이메일 발송 오류 처리
					response.getWriter().write("send_error");
				}
			}
			else if (cmd.equals("/verifyCode.members")) {
				if (verifyAuthenticationCode(request)) {
					// 인증 코드 일치
					System.out.println("인증 코드 일치");
					response.getWriter().write("success");
				} else {
					// 인증 코드 불일치
					response.getWriter().write("error");
				}
			}


			else if(cmd.equals("/goToLogin.members")) { // 로그인 창으로 이동

				response.sendRedirect("/members/login.jsp");

			} else if (cmd.equals("/login.members")) { // 로그인 버튼 클릭 시

				String id = request.getParameter("id");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				boolean result = membersDAO.isAccountExist(id, password);

				if(membersDAO.isBanned(id)) {
					response.getWriter().write("banned");
					return;
				}

				if (result) {
					System.out.println("로그인 성공");
					String email = membersDAO.getEmail(id);
					request.getSession().setAttribute("loginID", id); // session scope
					request.getSession().setAttribute("email", email);
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/html; charset=utf-8");
					response.sendRedirect("/index.jsp");
				} else {
					System.out.println("false 확인");
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/html; charset=utf8");
					// result가 false인 경우 클라이언트로 "false" 응답을 보내기
					response.getWriter().write("false");
				}
			} else if(cmd.equals("/logout.members")) { // 로그아웃 버튼 클릭 시
				request.getSession().removeAttribute("loginID"); // 사용자의 키로 저장되어 있던 특정 정보 하나 제거
				request.getSession().invalidate(); // 사용자의 키로 저장되어 있던 정보 다 제거
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/goToSignUp.members")) { // 회원 가입 페이지 창으로 이동

				response.sendRedirect("/members/register.jsp");

			} else if(cmd.equals("/delAccountPage.members")) { // 회원 탈퇴 페이지로 이동
				String id = (String)request.getSession().getAttribute("loginID");
				String loginPassword = membersDAO.getPassword(id);
				request.setAttribute("loginPassword", loginPassword);
				request.getRequestDispatcher("/members/deleteAccount.jsp").forward(request, response);
			} else if(cmd.equals("/memberOut.members")) { // 회원 탈퇴 버튼 클릭 시 
				String id = (String)request.getSession().getAttribute("loginID");
				
				int result = membersDAO.changePosition(id);

				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");

			} else if (cmd.equals("/idSearch.members")) { // 아이디 찾기

				String name = request.getParameter("inputName");
				String email = request.getParameter("email1") + "@" + request.getParameter("email2");

				String foundId = membersDAO.getIdByEmail(email);

				if (foundId != null) {
					System.out.println("아이디 찾기 성공");
					request.setAttribute("foundId", foundId);
					request.getRequestDispatcher("/members/id_search_result.jsp").forward(request, response);
				} else {
					System.out.println("아이디를 찾을 수 없음");
					request.setAttribute("errorMessage", "Email에 해당하는 아이디를 찾을 수 없습니다.");
					request.getRequestDispatcher("/members/id_Search.jsp").forward(request, response);
				}
			} 
			else if(cmd.equals("/goToIdSearch.members")) {
				response.sendRedirect("/members/id_Search.jsp");

			} else if (cmd.equals("/pwSearch.members")) {

				String id = request.getParameter("inputId");
				String email = request.getParameter("email1") + "@" + request.getParameter("email2");

				String foundId = membersDAO.getIdByEmail(email);

				if (foundId != null && foundId.equals(id)) {
					System.out.println("비밀번호 찾기 성공");
					HttpSession session = request.getSession();
					session.setAttribute("foundId", foundId);
					request.getRequestDispatcher("/members/pw_search_result.jsp").forward(request, response);
				} else {
					System.out.println("가입시 사용한 이메일이 아님");
					request.setAttribute("errorMessage", "가입시 사용한 이메일이 아닙니다.");
					request.getRequestDispatcher("/members/pw_Search.jsp").forward(request, response);
				}
			}
			else if (cmd.equals("/pw_reset.members")) {

				HttpSession session = request.getSession();
				String id = (String) session.getAttribute("foundId");
				String newPw = EncryptionUtils.getSHA512(request.getParameter("newPassword"));

				try {
					int rowsUpdated = membersDAO.updatePassword(id, newPw);

					if (rowsUpdated > 0) {
						System.out.println("비밀번호 수정 완료");
						response.sendRedirect("/members/login.jsp"); 
					} else {
						System.out.println("비밀번호 수정 실패");
						response.sendRedirect("/pwSearch.members"); 
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else if(cmd.equals("/goToPwSearch.members")) {
				response.sendRedirect("/members/pw_Search.jsp");
			} else if(cmd.equals("/update.members")) { // 마이페이지 - 내 정보 수정

				request.setCharacterEncoding("utf8");
				String id = (String)request.getSession().getAttribute("loginID");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone_head = request.getParameter("phone_head");
				String phone_body = request.getParameter("phone_body");
				String phone_tail = request.getParameter("phone_tail");
//				String email1 = request.getParameter("email1");
//				String email2 = request.getParameter("email2");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");

				String phone = phone_head+phone_body+phone_tail;
//				String email = email1 + "@" + email2;

				int result = membersDAO.updateAccount(new MembersDTO(id, password, name, phone, null, zipcode, address1, address2, null, null));
				response.sendRedirect("/mypage.members");

			} else if(cmd.equals("/mypage.members")) { // 마이페이지로 이동

				String id = (String)request.getSession().getAttribute("loginID");
				MembersDTO list = membersDAO.mypage(id);
				request.setAttribute("mypageList", list);
				request.getRequestDispatcher("/members/myPage.jsp").forward(request, response);

			} else if(cmd.equals("/membersInfo.members")) { // 관리자 페이지로 이동

				List<MembersDTO> list = new ArrayList<>();
				String id = (String)request.getSession().getAttribute("loginID");
				MembersDTO myInfo = membersDAO.mypage(id);
				request.setAttribute("myInfo", myInfo);
				list = membersDAO.selectMembersInfo();
				request.setAttribute("list", list);
				request.getRequestDispatcher("/members/admin.jsp").forward(request, response);
			} else if(cmd.equals("/banMember.members")) { // 사용자 밴
				String id = request.getParameter("id");
				membersDAO.banMember(id);
				response.sendRedirect("/membersInfo.members");
			} else if(cmd.equals("/unbanMember.members")) { // 밴 풀기
				String id = request.getParameter("id");
				membersDAO.unbanMember(id);
				response.sendRedirect("/membersInfo.members");
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