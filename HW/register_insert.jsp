<%@ include file="header.jsp" %>
<%
    String user_id = request.getParameter("id");
    String user_password = request.getParameter("password");
    ResultSet rs = null;

    // your codes here
    PreparedStatement pStmt = con.prepareStatement(
        "select * from user where user_id = ?"
    );
    pStmt.setString(1, user_id);

    rs = pStmt.executeQuery();

    if (rs.next())
        response.sendRedirect("/register.jsp");
    else
    {
        PreparedStatement pStmt2 = con.prepareStatement(
        "insert into user values (?, sha1(sha1(?)))"
        );
        pStmt2.setString(1, user_id);
        pStmt2.setString(2, user_password);

        pStmt2.executeUpdate();
        pStmt2.close();

        response.sendRedirect("/login.jsp");
    }
    pStmt.close();

%>
<%@ include file="footer.jsp" %>

