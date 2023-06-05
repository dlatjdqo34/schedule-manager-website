<%@ include file="header.jsp" %>
<%
    int code = Integer.parseInt(request.getParameter("code"));
    int rs = 0;

    // your codes here
    PreparedStatement pStmt = con.prepareStatement(
        "delete from schedule where code = ?"
    );
    pStmt.setInt(1, code);

    rs = pStmt.executeUpdate();
    pStmt.close();
%>
<%@ include file="footer.jsp" %>