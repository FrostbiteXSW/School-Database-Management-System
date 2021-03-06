<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理</title>
    <link href="css/page.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/student.js"></script>
</head>
<body style="background-color: #a9c4d6">
<h1 class="TitleStyle">欢迎登录教学事务管理系统</h1>
<div class="MainDiv">
    <div class="LeftDiv">
        <table class="LeftTable">
            <tbody>
            <tr>
                <td><button class="LeftContent" onclick="CourseInfo()">&nbsp;课程信息</button></td>
            </tr>
            <tr>
                <td ><button class="LeftContent" onclick="selectCourse()">&nbsp;选课</button></td>
            </tr>
            <tr>
                <td><button class="LeftContent" onclick="quitCourse()">&nbsp;退课</button></td>
            </tr>
            <tr>
                <td><button class="LeftContent" onclick="exitSystem()">&nbsp;退出登录</button></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="SplitLine"></div>
    <div class="RightDiv">
        <br><span class="RightSubtitleStyle">选课</span><br><br>
        <form method="post" action="handleSelectCourse.action">
            <table id="MainTable" class="MainTable" align="center" cellpadding="5">
                <tbody>
                <tr>
                    <td class="InnerTitle">课号</td>
                    <td class="InnerTitle">课名</td>
                    <td class="InnerTitle">学期</td>
                    <td class="InnerTitle">上课时间</td>
                    <td class="InnerTitle">任课教师</td>
                    <td class="InnerTitle">学分</td>
                    <td class="InnerTitle">选择</td>
                </tr>
                <%
                    SessionFactory sessionFactory = new Configuration(). configure("hibernate.cfg.xml"). buildSessionFactory();
                    Session s = sessionFactory.openSession();
                    String username = (String)session.getAttribute("username");
                    Query query = s.createQuery(
                            "select O.kh, C.km, O.xq, O.sksj, T.xm, T.gh, C.xf from OEntity as O, CEntity as C, TEntity as T " +
                                    "where not (O.kh, O.xq) in " +
                                    "(select E.kh, E.xq from EEntity as E " +
                                    "where E.xh = '" + username + "') " +
                                    "and C.kh = O.kh and T.gh = O.gh " +
                                    "order by O.kh");
                    List list = query.list();
                    for (Object aList : list) {
                        Object[] tuple = (Object[]) aList;
                        String kh = (String) tuple[0], km = (String) tuple[1], xq = (String) tuple[2], sksj = (String) tuple[3], xm = (String) tuple[4], gh = (String) tuple[5];
                        int xf = (int) tuple[6];
                        out.print("\n" +
                                "<tr>\n" +
                                "   <td class='InnerBlock'>" + kh + "</td>\n" +
                                "   <td class='InnerBlock'>" + km + "</td>\n" +
                                "   <td class='InnerBlock'>" + sksj + "</td>\n" +
                                "   <td class='InnerBlock'>" + xm + "</td>\n" +
                                "   <td class='InnerBlock'>" + xq + "</td>\n" +
                                "   <td class='InnerBlock'>" + xf + "</td>\n" +
                                "   <td class='InnerBlock' style='text-align: center'><input type='radio' name='kh' value='" + xq + "|" + kh + "|" + session.getAttribute("username") + "|" + gh + "'/></td>\n" +
                                "</tr>\n");
                    }
                %>
                </tbody>
            </table>
            <input type="submit" value="确认"/>
            <input type="reset" value="重置"/>
            <%
                String name = request.getParameter("from");
                if (name != null && name.equals("failed"))
                    out.print("<br><br><div style='text-align: center; font-weight: bolder'>选课失败！</div>");
                if (name != null && name.equals("success"))
                    out.print("<br><br><div style='text-align: center; font-weight: bolder'>选课成功！</div>");
            %>
        </form>
    </div>
</div>
</body>
</html>