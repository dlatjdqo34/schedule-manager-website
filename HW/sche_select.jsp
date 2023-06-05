<%@ include file="db_open.jsp" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ include file="session_check.jsp" %>
<%
    String search = request.getParameter("sText");
    ResultSet rs = null;
    JSONArray sendArr = new JSONArray();

    // your codes here
    PreparedStatement pStmt = con.prepareStatement(
        "select * from schedule where user_id = ? and name like concat(?, '%')  order by code asc" 
    );
    pStmt.setString(1, user_id);
    pStmt.setString(2, search);

    rs = pStmt.executeQuery();

    while(rs.next()) {
        JSONObject sendObj = new JSONObject();
        sendObj.put("code", rs.getInt(1));
        sendObj.put("name", rs.getString(3));
        sendObj.put("start", rs.getInt(4));
        sendObj.put("end", rs.getInt(5));
        sendObj.put("dow", rs.getString(6));

        sendArr.add(sendObj);
    }
    out.print(sendArr);

    pStmt.close();
%>
<%@ include file="db_close.jsp" %>