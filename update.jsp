<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
if (request.getParameter("submit") != null) {
    String id = request.getParameter("id");
    String name = request.getParameter("sname");
    String course = request.getParameter("course");
    String fee = request.getParameter("fee");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "");
        
        // Update the record in the database
        pst = con.prepareStatement("UPDATE records SET stname=?, course=?, fee=? WHERE id=?");
        pst.setString(1, name);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.setString(4, id);
        pst.executeUpdate();
        
        // Redirect to the index.jsp page after successful update
        response.sendRedirect("index.jsp");
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error updating record");
    } finally {
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} else {
    String id = request.getParameter("id");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "");
        
        // Retrieve the record from the database
        pst = con.prepareStatement("SELECT * FROM records WHERE id=?");
        pst.setString(1, id);
        rs = pst.executeQuery();
        
        if (rs.next()) {
            // Populate the form fields with the current values
            String name = rs.getString("stname");
            String course = rs.getString("course");
            String fee = rs.getString("fee");

            %>
            <!DOCTYPE html>
            <html>
            <head>
                <title>Update Record</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <style>
                    body{
                        width:100%;
                        height:100vh;
                    }
                    .row{
                        display:flex;
                        align-items:center;
                        justify-content:center;
                    }
                    .card{
                        background-color:lightblue;
                        border:1px solid gray;
                        border-radius:10px;
                        padding:10px;
                        
                    }
                </style>
            </head>
            <body>
                

                <h1 style="text-align: center;">STUDENT MANAGEMENT SYSTEM</h1>
                <div class="row mt-5">
                    <div class="col-sm-4">
                        <form class="card" method="POST" action="update.jsp">
                            <input type="hidden" name="id" value="<%= id %>">
                            <div align="left">
                                <label class="form-label">Student Name</label>
                                <input type="text" class="form-control" placeholder="name" name="sname" value="<%= name %>" id="sname" required>
                            </div>
                            <div align="left">
                                <label class="form-label">Course</label>
                                <input type="text" class="form-control" placeholder="Course" name="course" value="<%= course %>" id="course" required>
                            </div>
                            <div align="left">
                                <label class="form-label"> Fee</label>
                                <input type="text" class="form-control" placeholder="Fee" name="fee" value="<%= fee %>" id="fee" required="">
                            </div> <br>
                            <div align="right">
                                <input type="submit" value="Update" name="submit" id="submit" class="btn btn-info">
                                <input type="reset" value="Reset" name="reset" id="reset" class="btn btn-warning">
                            </div>
                        </form>
                    </div>
                </div>

                 
            </body>
            </html>
            <%
        } else {
            out.println("Record not found");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error retrieving record");
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
%>