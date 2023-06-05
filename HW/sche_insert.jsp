<%@ include file="db_open.jsp" %>
<%@ include file="session_check.jsp" %>
<%
    int start = Integer.parseInt(request.getParameter("start"));
    int end = Integer.parseInt(request.getParameter("end"));
    String name = request.getParameter("name");
    String dow = request.getParameter("dow");
    ResultSet rs = null;
    JSONObject sendObj = new JSONObject();

    // your codes here
    PreparedStatement pStmt = con.prepareStatement(
        "select * from schedule where dow = ? and ? < end and start < ? and user_id = ?"
    );
    pStmt.setString(1, dow);
    pStmt.setInt(2, start);
    pStmt.setInt(3, end);    
    pStmt.setString(4, user_id);

    rs = pStmt.executeQuery();

    if(rs.next()) {
        sendObj.put("code", -1);
        out.print(sendObj);
    } else {
        PreparedStatement pStmt2 = con.prepareStatement(
            "insert into schedule(user_id, name, start, end, dow) values (?, ?, ?, ?, ?)"
        );
        pStmt2.setString(1, user_id);
        pStmt2.setString(2, name);
        pStmt2.setInt(3, start);
        pStmt2.setInt(4, end);
        pStmt2.setString(5, dow);

        pStmt2.executeUpdate();
        
        PreparedStatement pStmt3 = con.prepareStatement("select last_insert_id()");
        rs = pStmt3.executeQuery();
        
        if(rs.next()) {
            sendObj.put("code", rs.getInt(1));
            sendObj.put("name", name);
            sendObj.put("start", start);
            sendObj.put("end", end);
            sendObj.put("dow", dow);
        }
        out.println(sendObj);

        pStmt2.close();
        pStmt3.close();
    }

    pStmt.close();
%>
<%@ include file="db_close.jsp" %>