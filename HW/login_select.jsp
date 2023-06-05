<%@ include file="header.jsp" %>
<%
    String user_id = request.getParameter("id");
    String userPassword = request.getParameter("password");
    ResultSet rs = null;

    // your codes here
    PreparedStatement pStmt = con.prepareStatement(
        "select user_id from user where user_id = ? and user_password = sha1(sha1(?))"
    );
    pStmt.setString(1, user_id);
    pStmt.setString(2, userPassword);

    rs = pStmt.executeQuery();

    if(rs.next()) {
        session.setAttribute("user_id", user_id);
        response.sendRedirect("/index.jsp");
    } else {
        response.sendRedirect("/login.jsp");
    }

    pStmt.close();
    
%>
<%@ include file="footer.jsp" %>