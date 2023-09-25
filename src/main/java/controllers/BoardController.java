 package controllers;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import constants.Constants;
import dao.BoardDAO;
import dto.BoardDTO;
import dto.FilesDTO;
import dto.ReplyDTO;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI();
		
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		try {
			if(cmd.equals("/list.board")) { // 게시물 리스트 가져오기
				int currentPage = request.getParameter("cPage")==null ? 1 : Integer.parseInt(request.getParameter("cPage"));
				String keyword = request.getParameter("keyword");
				
				// 검색어 X, 평상시 게시물 로드
				if(keyword == null) {
					List<BoardDTO> listDTO = boardDAO.selectBy(currentPage * Constants.RECORD_COUNT_PER_PAGE - 9, currentPage* Constants.RECORD_COUNT_PER_PAGE);
					
					request.getSession().setAttribute("latestPage", currentPage);
					request.setAttribute("listDTO", listDTO);
					
					request.setAttribute("recordTotalCount", boardDAO.getRecordCount());
					request.setAttribute("recordCountPerPage", Constants.RECORD_COUNT_PER_PAGE);
					request.setAttribute("naviCountPerPage", Constants.NAVI_COUNT_PER_PAGE);
				} 
				// 검색어 O, 해당 게시물만 로드
				else {
					List<BoardDTO> listDTO = boardDAO.selectBy(currentPage * Constants.RECORD_COUNT_PER_PAGE - 9, currentPage* Constants.RECORD_COUNT_PER_PAGE, keyword);
					
					request.getSession().setAttribute("latestPage", currentPage);
					request.setAttribute("listDTO", listDTO);
					request.setAttribute("keyword", keyword);
					
					request.setAttribute("recordTotalCount", boardDAO.getRecordCountOnSearch(keyword));
					request.setAttribute("recordCountPerPage", Constants.RECORD_COUNT_PER_PAGE);
					request.setAttribute("naviCountPerPage", Constants.NAVI_COUNT_PER_PAGE);
				}
				
				request.getRequestDispatcher("/board/freeboard.jsp").forward(request, response);
			} else if(cmd.equals("/insert.board")) { // 게시물 등록
				
//				String uploadPath = request.getServletContext().getRealPath("files");
//				File filesPath = new File(uploadPath);
//				if(!filesPath.exists()) {filesPath.mkdir();}
//				int maxSize = 1024 * 1024 * 10;
//				MultipartRequest multi = new MultipartRequest(request, uploadPath , maxSize, "utf8", new DefaultFileRenamePolicy());
//				
//				String writer = (String)request.getSession().getAttribute("loginID");
//				String title = multi.getParameter("title");
//				String contents = multi.getParameter("contents");
//				String game_name = multi.getParameter("game_name");
				
//				int result = boardDAO.insert(new BoardDTO(0,writer,title,contents,null,null,game_name));		
//
//				Enumeration<String> fileNames = multi.getFileNames();
//
//				while(fileNames.hasMoreElements()) {
//					String fileName = fileNames.nextElement();
//					if(multi.getFile(fileName) != null) {
//						String ori_name = multi.getOriginalFileName(fileName);
//						String sys_name = multi.getFilesystemName(fileName);
//						fileDAO.insert(new FilesDTO(0,ori_name,sys_name,result));
//					}
//				}
//
//				response.sendRedirect("/list.board");
				
			} else if(cmd.equals("/delete.board")) { // 게시물 삭제
				
//				int seq = Integer.parseInt(request.getParameter("seq"));
//				int result = boardDAO.delContents(seq);
//				response.sendRedirect("/list.board");
			
			} else if(cmd.equals("/update.board")) { // 게시물 수정
				
//				String uploadPath = request.getServletContext().getRealPath("files");
//				File filesPath = new File(uploadPath);
//				if(!filesPath.exists()) {filesPath.mkdir();}
//				int maxSize = 1024 * 1024 * 10;
//				MultipartRequest multi = new MultipartRequest(request, uploadPath , maxSize, "utf8", new DefaultFileRenamePolicy());
//				
//				int seq = multi.getParameter("seq");
//				String title = multi.getParameter("title");
//				String contents = multi.getParameter("contents");
//				String game_name = multi.getParameter("game_name");
//				int result = boardDAO.update(title, contents,game_name,seq);		
//
//				Enumeration<String> fileNames = multi.getFileNames();
//
//				while(fileNames.hasMoreElements()) {
//					String fileName = fileNames.nextElement();
//					if(multi.getFile(fileName) != null) {
//						String ori_name = multi.getOriginalFileName(fileName);
//						String sys_name = multi.getFilesystemName(fileName);
//						fileDAO.insert(new FilesDTO(0,ori_name,sys_name,result));
//					}
//				}
				
				response.sendRedirect("/viewContents.board?seq="+seq);
				
			} else if(cmd.equals("/goToWrite.board")) { // 글쓰기 창으로 이동
//				response.sendRedirect("/");
			
			} else if(cmd.equals("/goToEdit.board")) { // 글수정 창으로 이동
				int seq = Integer.parseInt(request.getParameter("seq"));
				
				BoardDTO dto = boardDAO.showContents(seq);
				List<FilesDTO> fileList = fileDAO.selectFile(seq);
				request.setAttribute("contentsList", dto);
				request.setAttribute("fileList", fileList);
				
				request.getRequestDispatcher("/editBoard.jsp").forward(request, response);
				
			} else if(cmd.equals("/showContents.board")) { // 게시글 보기
				
//				int seq = Integer.parseInt(request.getParameter("seq"));
//				
//				int view_countResult = boardDAO.viewCountUpdate(seq);
//				BoardDTO dto = boardDAO.showContents(seq);
//				List<ReplyDTO> replyList = replyDAO.selectAll(seq);
//				
//				List<FilesDTO> fileList = fileDAO.selectFile(seq);
//				request.setAttribute("fileList", fileList);
//				request.setAttribute("dto", dto);
//				request.setAttribute("replyList", replyList);
//				request.getRequestDispatcher("/freeboard.jsp").forward(request, response);
			
			} else if(cmd.equals("/search.board")) { // 게시글 검색 ( 제목 & 내용 & 카테고리 )
//				String title = request.getParameter("searchTitle");
//				List<BoardDTO> list = boardDAO.searchList(title);
			
			} else if(cmd.equals("/indexList.board")) { // index에 최근 5개의 게시물을 올리는 코드입니다.
				List<BoardDTO> selectFive = boardDAO.selectRecentFive();
				request.setAttribute("selectFive", selectFive);
				request.getRequestDispatcher("/index.jsp").forward(request, response);
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
