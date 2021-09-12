package com.minton.minton05.notice.service;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minton.minton05.cafe.dto.CafeDto;
import com.minton.minton05.notice.dao.NoticeDao;
import com.minton.minton05.notice.dto.NoticeDto;

@Service //spring bean container 에서 bean을 생성
public class NoticeServiceImpl implements NoticeService{

	@Autowired private NoticeDao noticeDao; //dao를 주입
	
	//공지사항 목록을 가져오는 메소드 - request 영역에 저장 
	@Override
	public void getList(HttpServletRequest request) {
		//페이징 처리하는 메소드 가져오기
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=10;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
		   
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		   
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
	      /*
        [ 검색 키워드에 관련된 처리 ]
        -검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.      
	     */
	     String keyword=request.getParameter("keyword");
	     String condition=request.getParameter("condition");
	     //만일 키워드가 넘어오지 않는다면 
	     if(keyword==null){
	        //키워드와 검색 조건에 빈 문자열을 넣어준다. 
	        //클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
	        keyword="";
	        condition=""; 
	     }
	     //특수기호를 인코딩한 키워드를 미리 준비한다. 
	     String encodedK=URLEncoder.encode(keyword);
	         
	     //Dto 객체에 startRowNum 과 endRowNum 을 담는다.
	     NoticeDto dto=new NoticeDto();
	     dto.setStartRowNum(startRowNum);
	     dto.setEndRowNum(endRowNum);

	      //만일 검색 키워드가 넘어온다면 
	      if(!keyword.equals("")){
	    	  //검색 조건이 무엇이냐에 따라 분기 하기
	    	  if(condition.equals("title_content")){//제목 + 내용 검색인 경우
	    		  //검색 키워드를 NoticeDto 에 담아서 전달한다.
	    		  dto.setTitle(keyword);
	    		  dto.setContent(keyword);
	    	  }else if(condition.equals("title")){ //제목 검색인 경우
	    		  dto.setTitle(keyword);
	    	  }else if(condition.equals("writer")){ //작성자 검색인 경우
	    		  dto.setWriter(keyword);
	    	  } // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	      }
	      //글 목록 얻어오기 
	      List<NoticeDto> list=noticeDao.getList(dto);
	      //전체글의 갯수
	      int totalRow=noticeDao.getCount(dto);
	      
	      //하단 시작 페이지 번호 
	      int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	      //하단 끝 페이지 번호
	      int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	      

	      //전체 페이지의 갯수
	      int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	      //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	      if(endPageNum > totalPageCount){
	         endPageNum=totalPageCount; //보정해 준다.
	      }
	      //view page 에서 필요한 값을 request 영역에 담는다.
	      request.setAttribute("pageNum", pageNum);
	      request.setAttribute("startPageNum", startPageNum);
	      request.setAttribute("endPageNum", endPageNum);
	      request.setAttribute("condition", condition);
	      request.setAttribute("keyword", keyword);
	      request.setAttribute("encodedK", encodedK);
	      request.setAttribute("totalPageCount", totalPageCount);
	      request.setAttribute("list", list);
	      request.setAttribute("totalRow", totalRow);
	      
	      //로그인한 사람이 admin인지 확인할 id 값 넘겨주기
	      String id = (String) request.getSession().getAttribute("id");
	      request.setAttribute("id", id);
	}

	//공지사항 글 1개에 대한 정보를 가져오는 메소드 - request 영역에 저장
	@Override
	public void getData(HttpServletRequest request) {
		//로그인한 사람이 admin인지 확인할 id 값 넘겨주기
		String id = (String) request.getSession().getAttribute("id");
		request.setAttribute("id", id);
		
		//자세히 보여줄 글번호를 읽어온다. 
		int num=Integer.parseInt(request.getParameter("num"));
		//조회수 올리기
		noticeDao.addViewCount(num);
		//키워드 처리
		String keyword=request.getParameter("keyword");
	    String condition=request.getParameter("condition");
	    //만일 키워드가 넘어오지 않는다면 
	    if(keyword==null){
	       //키워드와 검색 조건에 빈 문자열을 넣어준다. 
	       //클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
	       keyword="";
	       condition=""; 
	    }
	    //특수기호를 인코딩한 키워드를 미리 준비한다. 
	    String encodedK=URLEncoder.encode(keyword);
	        
	    //Dto 객체에 자세히 보여줄 글번호를 넣는다
	    NoticeDto dto=new NoticeDto();
	    dto.setNum(num);
	    
	    //만일 검색 키워드가 넘어온다면 
	    if(!keyword.equals("")){
	    	//검색 조건이 무엇이냐에 따라 분기 하기
	    	if(condition.equals("title_content")){//제목 + 내용 검색인 경우
	    		//검색 키워드를 NoticeDto 에 담아서 전달한다.
	    		dto.setTitle(keyword);
	    		dto.setContent(keyword);
	    	}else if(condition.equals("title")){ //제목 검색인 경우
	    		dto.setTitle(keyword);
	    	}else if(condition.equals("writer")){ //작성자 검색인 경우
	    		dto.setWriter(keyword);
	    	} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	    }
	    //dto에 키워드를 설정한 dto를 새로 넣어준다.
	    dto=noticeDao.getData(dto);
	    
		//view page에 필요한 값을 request 에 담아주기
		request.setAttribute("dto", dto);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
	}

	//공지사항 글 1개 추가하는 메소드 
	@Override
	public void saveContent(NoticeDto dto) {
		noticeDao.insert(dto);		
	}
	
	//공지사항 글 수정을 위해 글정보 불러오는 메소드 - 글 번호로 글정보 가져와서 request에 저장
		@Override
		public void getUpdateData(HttpServletRequest request, int num) {
			NoticeDto dto = noticeDao.getData(num);
			request.setAttribute("dto", dto);
		}

	//공지사항 글 수정하는 메소드
	@Override
	public void updateContent(HttpServletRequest request, NoticeDto dto) {
		noticeDao.update(dto);
		request.setAttribute("dto", dto);
	}

	//공지사항 글 삭제하는 메소드
	@Override
	public void deleteContent(int num) {
		//exception 작업 예정
		noticeDao.delete(num);	
	}
		
	//ajax 요청용/index용- 공지사항 목록을 가져오는 메소드 
	@Override
	public List<NoticeDto> ajaxGetListIndex(HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
	
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
				   
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;		
	     	         
		//Dto 객체에 startRowNum 과 endRowNum 을 담는다.
		NoticeDto dto=new NoticeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		//글 목록 얻어오기 
		List<NoticeDto> list=noticeDao.getList(dto);
	      
		return list;
	}
	
	//ajax 요청용 - 공지사항 목록을 가져오는 메소드 
	@Override
	public List<NoticeDto> ajaxGetList(HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=10;
	
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}		   
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;		
		/*
		[ 검색 키워드에 관련된 처리 ]
		-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}

		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword); 	         
		//Dto 객체에 startRowNum 과 endRowNum 을 담는다.
		NoticeDto dto=new NoticeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content")){//제목 + 내용 검색인 경우
				//검색 키워드를 CafeDto 에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}

		//글 목록 얻어오기 
		List<NoticeDto> list=noticeDao.getList(dto);	      
		return list;
	}

	//ajax 요청용 - 공지사항 글하단 페이징 처리에 필요한 데이터를 리턴하는 메소드
	@Override
	public Map<String, Object> ajaxPaging(HttpServletRequest request) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String keyword = (String)request.getParameter("keyword");
		String condition = (String)request.getParameter("condition");
		/*
		 * @RequestParam int pageNum,
			@RequestParam String keyword, @RequestParam String condition
		 * */
				
		//한페이지에 표시할 게시글 수
		final int PAGE_ROW_COUNT=10;
		//하단에 표시할 페이지 개수
		final int PAGE_DISPLAY_COUNT=5;		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);

		NoticeDto dto=new NoticeDto();
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content")){//제목 + 내용 검색인 경우
				//검색 키워드를 CafeDto 에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}
		
		//전체 row 개수
		int totalRow=noticeDao.getCount(dto);
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		//json 문자열로 응답할 데이터를 Map에 담는다.
		Map<String, Object>	map=new HashMap<>();
		map.put("startPageNum", startPageNum);
		map.put("endPageNum", endPageNum);
		map.put("totalPageCount", totalPageCount);
		//Map을 리턴해주면, Map에 담긴 데이터가
		//{"startPageNum": x, "endPageNum":x, "totalPageCount":x}
		//의 json 문자열로 변환되어서 응답된다. 
		return map;
	}

	//ajax 요청용 - 공지사항 글 자세히 보기
	@Override
	public NoticeDto ajaxGetDetail(HttpServletRequest request) {
		//파라미터로 넘어오는 글번호, keyword, condition 
		int num = Integer.parseInt(request.getParameter("num"));
		String keyword = (String)request.getParameter("keyword");
		String condition = (String)request.getParameter("condition");
		//조회수 올리기
		//noticeDao.addViewCount(num);
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);
		
		NoticeDto dto=new NoticeDto();
		
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content")){//제목 + 내용 검색인 경우
				//검색 키워드를 CafeDto 에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}
		
		dto.setNum(num);
		dto = noticeDao.getData(num);
		return dto;
	}

	
}



