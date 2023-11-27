<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    if (request.getParameter("submit") != null) {
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection con;
        PreparedStatement pst;
        ResultSet rs;

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "");
        pst = con.prepareStatement("insert into records(stname, course, fee) values(?,?,?)");
        pst.setString(1, name);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.executeUpdate();
        pst.close();
        con.close();
%>

<script>
    alert("Record Added Successfully");
</script>

<%
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Management System by Using Crud Java Server Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .row{
            width:90%;
            margin:auto;
        }
        .card{
            background-color:lightblue;
            border:1px solid gray;
            padding:10px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;"class="mt-2">STUDENT MANAGEMENT SYSTEM</h1>
    <div class="row mt-5">
        <div class="col-sm-4">
            <form class="card" method="POST" action="#">
                <div align="left">
                    <label class="form-label">Student Name</label>
                    <input type="text" class="form-control" placeholder="name" name="sname" id="sname" required>
                </div>
                <div align="left">
                    <label class="form-label">Course</label>
                    <input type="text" class="form-control" placeholder="Course" name="course" id="course" required>
                </div>
                <div align="left">
                    <label class="form-label"> Fee</label>
                    <input type="text" class="form-control" placeholder="Fee" name="fee" id="fee" required="">
                </div> <br>
                <div align="right">
                    <input type="submit" value="Submit" name="submit" id="submit" class="btn btn-info">
                    <input type="reset" value="Reset" name="reset" id="reset" class="btn btn-warning">
                </div>
            </form>
        </div>
        <div class="col-sm-8">
            <div class="panel-body">
                <table class="table table-responsive table-border table-bordered" id="tbl-student" cellpadding="0" width="100%">
                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Course</th>
                            <th>Fee</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;

                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "");
                            String query = "select * from records";
                            Statement st = con.createStatement();
                            rs = st.executeQuery(query);
                        
                            while (rs.next()) {
                                String id = rs.getString("id");
                            
                            %>

                        <tr>
                            <td><%=rs.getString("stname")%></td>
                            <td><%=rs.getString("course") %></td>
                            <td><%=rs.getString("fee")%></td>
                            <td> <a href="update.jsp?id=<%=id%>">Edit</a></td>
                            <td> <a href="delete.jsp?id=<%=id%>">Delete</a></td>
                            
                        </tr>

                        <%
                            }
                            rs.close();
                            st.close();
                            con.close();
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>