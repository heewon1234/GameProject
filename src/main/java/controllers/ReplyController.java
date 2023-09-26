package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

import constants.Constants;
import dao.ReplyDAO;
import dto.BoardDTO;
import dto.ReplyDTO;

@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReplyDAO replyDAO = ReplyDAO.getInstance();
		String cmd = request.getRequestURI();
		request.setCharacterEncoding("utf8");
		Gson gson = new GsonBuilder().registerTypeAdapter(Timestamp.class, new JsonSerializer<Timestamp>() {
			private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd. hh:mm");

			@Override
			public JsonElement serialize(Timestamp arg0, Type arg1, JsonSerializationContext arg2) {
				return new JsonPrimitive(sdf.format(arg0));
			}
		}).create();
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		gson.toJson(timestamp);
		
		try {
			if(cmd.equals("/list.reply")) { // 댓글 리스트 가져오기
				
				response.setContentType("text/html; charset=utf8");
				
				int parent_seq = Integer.parseInt(request.getParameter("parent_seq"));
				
				int currentReplyPage=(int)request.getSession().getAttribute("latestReplyPageNum");

				int start = currentReplyPage*Constants.RECORD_COUNT_PER_PAGE-(Constants.RECORD_COUNT_PER_PAGE-1);
				
				int end = currentReplyPage*Constants.RECORD_COUNT_PER_PAGE;
				
				List<ReplyDTO> replyList = replyDAO.selectBy(start, end, parent_seq);
				
				if(replyList.size()==0) {
					currentReplyPage -= 1;
					start = currentReplyPage*Constants.RECORD_COUNT_PER_PAGE-(Constants.RECORD_COUNT_PER_PAGE-1);
					end = currentReplyPage*Constants.RECORD_COUNT_PER_PAGE;
					replyList = replyDAO.selectBy(start, end, parent_seq);
				}
				
				PrintWriter pw = response.getWriter();
				pw.append(gson.toJson(replyList));
				
			} else if(cmd.equals("/insert.reply")) { // 댓글 등록
				
				String writer = (String)request.getSession().getAttribute("loginID");
				String contents = request.getParameter("contentsReply");
				contents = contents.replaceAll("\n", "<br>");
				int parent_seq = Integer.parseInt(request.getParameter("seq"));
			
				int result = replyDAO.insert(new ReplyDTO(0,writer,contents,null,parent_seq));
				response.sendRedirect("/showContents.board?seq="+parent_seq);
				
			} else if(cmd.equals("/delete.reply")) { // 댓글 삭제
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				int result = replyDAO.delete(seq);
				int parent_seq = Integer.parseInt(request.getParameter("parent_seq"));
				int currentReplyPage = Integer.parseInt(request.getParameter("currentReplyPage"));;
				response.sendRedirect("/showContents.board?seq="+parent_seq+"&currentReplyPage="+currentReplyPage);
				
			} else if(cmd.equals("/update.reply")) { // 댓글 수정
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				String contents = request.getParameter("contents");
				int result = replyDAO.update(contents, seq);
				int parent_seq = Integer.parseInt(request.getParameter("parent_seq"));
				int currentReplyPage = Integer.parseInt(request.getParameter("currentReplyPage"));
				response.sendRedirect("/showContents.board?seq="+parent_seq+"&currentReplyPage="+currentReplyPage);
				
				
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
