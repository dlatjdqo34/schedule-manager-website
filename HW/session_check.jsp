<%
    String user_id = (String)session.getAttribute("user_id"); // your codes here;
    if(user_id == null)
        response.sendRedirect("/login.jsp");
%>