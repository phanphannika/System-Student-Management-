<%@page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    Connection con;
    PreparedStatement pst = null; // Initialize pst with null
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root","");
        pst = con.prepareStatement("delete from records where id=?");
        pst.setString(1, id);
        pst.executeUpdate();

        %>
        <script>
            alert("Record Deleted Successfully");
            window.location.href = "index.jsp";
        </script>
        <%
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } 
        // Rest of the code...
    
%>

