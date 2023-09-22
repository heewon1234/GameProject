package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Properties;
import java.util.Random;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.gson.Gson;

import commons.EncryptionUtils;
import dao.MembersDAO;
import dto.MembersDTO;


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


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();

		MembersDAO membersDAO = MembersDAO.getInstance();
		Gson gson = new Gson();

		try {
			if(cmd.equals("/insert.members")) { // 회원가입
<<<<<<< HEAD
=======
// 임시 주석
>>>>>>> b628b21b333612109d16b329350a8b2da0fa2d7b
				String id = request.getParameter("id");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone = request.getParameter("phone_head") + request.getParameter("phone_body") + request.getParameter("phone_tail");
				String email = request.getParameter("email");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");

				// Redirect to the verification page
				response.sendRedirect("/index.jsp");
			}
			else if(cmd.equals("/idDupleCheck.members")) {
				String id = request.getParameter("id");
				boolean result = membersDAO.isDuplicatedID(id);
				PrintWriter pw = response.getWriter();

				pw.append(gson.toJson(result));
			}
			else if (cmd.equals("/sendVerificationCode.members")) {
				// Generate a random code
				String code = generateRandomCode(6);

				// Set it in the session
				HttpSession session = request.getSession();
				session.setAttribute("verificationCode", code);

				// Email sending logic
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
					// Recipient's email address
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

					// Email subject
					message.setSubject("📢 Avengers 로그인 인증번호 📢");

					// Email text: random 6-digit code
					message.setText("인증번호 발급 : [" + code + "]");

					// Send the message
					Transport.send(message); // send message

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
				// 사용자가 입력한 인증 코드
				String enteredCode = request.getParameter("code");

				// 세션에서 저장된 인증 코드 가져오기
				HttpSession session = request.getSession();
				String verificationCode = (String) session.getAttribute("verificationCode");

				if (verificationCode != null && verificationCode.equals(enteredCode)) {
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

			} else if(cmd.equals("/login.members")){ // 로그인 버튼 클릭 시

				String id = request.getParameter("id");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				boolean result = membersDAO.isAccountExist(id, password);

				if(result) { 
					request.getSession().setAttribute("loginID", id); // session scope
				}
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/logout.members")) { // 로그아웃 버튼 클릭 시

				request.getSession().removeAttribute("loginID"); // 사용자의 키로 저장되어 있던 특정 정보 하나 제거
				request.getSession().invalidate(); // 사용자의 키로 저장되어 있던 정보 다 제거
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/goToSignUp")) { // 회원 가입 페이지 창으로 이동

			} else if(cmd.equals("/memberOut.members")) { // 회원 탈퇴 버튼 클릭 시 

				String id = (String)request.getSession().getAttribute("loginID");
				int result = membersDAO.delAccount(id);
				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/idSearch.members")) { // 아이디 찾기 



			} else if(cmd.equals("/goToIdSearch.members")) {
				response.sendRedirect("/");
			} else if (cmd.equals("/pwSearch.members")) {
			}


			else if(cmd.equals("/goToPwSearch.members")) {
				//response.sendRedirect("/");
			} else if(cmd.equals("/update.members")) { // 마이페이지 - 내 정보 수정

				request.setCharacterEncoding("utf8");
				String id = (String)request.getSession().getAttribute("loginID");
				String password = EncryptionUtils.getSHA512(request.getParameter("password"));
				String name = request.getParameter("name");
				String phone_head = request.getParameter("phone_head");
				String phone_body = request.getParameter("phone_body");
				String phone_tail = request.getParameter("phone_tail");
				String email1 = request.getParameter("email1");
				String email2 = request.getParameter("email2");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");

				String phone = phone_head+phone_body+phone_tail;
				String email = email1 + "@" + email2;

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
