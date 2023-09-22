package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.FilesDAO;
import dto.FilesDTO;

@WebServlet("/FilesController")
public class FilesController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FilesDAO fileDAO = FilesDAO.getInstance();
		String cmd = request.getRequestURI();
		try {
			if(cmd.equals("/upload.file")) { // 게시물 이미지 업로드 ( ajax )
				String uploadPath = request.getServletContext().getRealPath("files");
				System.out.println(uploadPath);
				File filesPath = new File(uploadPath);
				if(!filesPath.exists()) {filesPath.mkdir();} // 폴더가 없다면 만들어라

				int maxSize = 1024 * 1024 * 10; // 업로드 파일 최대 사이즈 : 10MB	

				MultipartRequest multi = new MultipartRequest(request, uploadPath , maxSize, "utf8", new DefaultFileRenamePolicy()); // multipartrequest로 업그레이드

				Enumeration<String> fileNames = multi.getFileNames();
				while(fileNames.hasMoreElements()) {
					String fileName = fileNames.nextElement();
					if(multi.getFile(fileName) != null) { // multi.getFile(fileName) : 파일 크기 -> 파일이 없다면 null 반환
						System.out.println(fileName);
						String ori_name = multi.getOriginalFileName(fileName);
						String sys_name = multi.getFilesystemName(fileName);
						fileDAO.insert(new FilesDTO(0,ori_name,sys_name,0));
						PrintWriter pw = response.getWriter();
						pw.append("/files/"+sys_name);
					}
				}
			} 
		} catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
