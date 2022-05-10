<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>

<%@ include file="UserDAO.jsp" %>

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
User User = (User)request.getAttribute("User");
if(User == null){
	User = new User();
	request.setAttribute("User", User);
}
User.setUserID(request.getParameter("userID"));
User.setUserPassword(request.getParameter("userPassword"));
User.setUserName(request.getParameter("userName"));
User.setUserGender(request.getParameter("userGender"));
User.setUserEmail(request.getParameter("userEmail"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(User.getUserID() == null || User.getUserPassword() == null || User.getUserName() == null || User.getUserGender() == null || User.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(User);
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.setAttribute("userID", User.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			} 
		}
	
	%>

</body>
</html>