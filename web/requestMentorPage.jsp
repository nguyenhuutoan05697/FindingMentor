<%-- 
    Document   : admin.jsp
    Created on : Sep 30, 2021, 10:36:15 AM
    Author     : cunpl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <!-- Header -->
        <div id="header">
            <div class="shell">
                <!-- Logo + Top Nav -->
                <div id="top">
                    <h1><a href="#">SpringTime</a></h1>
                    <c:if test="${sessionScope.LOGIN_USER == null}">
                        <c:redirect url="user.jsp"/>
                    </c:if>
                    <c:if test="${sessionScope.LOGIN_USER != null}">
                        <c:if test="${sessionScope.LOGIN_USER.roleID ne 'AD'}">
                            <c:redirect url="user.jsp"/>
                        </c:if>
                        <c:if test="${sessionScope.LOGIN_USER.roleID eq 'AD'}">
                            <div id="top-navigation"> Welcome <a href="#"><strong>Administrator</strong></a> <span>|</span> <a href="MainController?action=Logout">Log out</a> </div>
                        </c:if>
                    </c:if>
                </div>
                <!-- End Logo + Top Nav -->
                <!-- Main Nav -->
                <div id="navigation">
                    <ul>
                        <li><a href="MainController?action=LoadAdminPage" ><span>Dashboard</span></a></li>
                        <li><a href="MainController?action=LoadMentorPage"><span>Mentor Management</span></a></li>
                        <li><a href="MainController?action=LoadUserPage"><span>User Management</span></a></li>
                        <li><a href="MainController?action=LoadApprovePage"class="active"><span>Approve Mentor</span></a></li>
                    </ul>
                </div>
                <!-- End Main Nav -->
            </div>
        </div>
        <!-- End Header -->
        <!-- Container -->
        <div id="container">
            <div class="shell">

                <!-- Message OK -->

                <!-- End Message OK -->
                <!-- Message Error -->

                <!-- End Message Error -->
                <br />
                <!-- Main -->
                <div id="main">
                    <div class="cl">&nbsp;</div>
                    <!-- Content -->
                    <div id="content">
                        <!-- Box -->
                        <div class="box">
                            <c:if test="${requestScope.APPROVE_MSG != null}">
                                ${requestScope.APPROVE_MSG}
                            </c:if>
                            <!-- Box Head -->
                            <div class="box-head">
                                <form action="MainController">


                                    <h2 class="left">Current Request</h2>
                                    <div class="right">
                                        <label>Search Request</label>
                                        <input type="text" name ="searchValue" class="field small-field" />
                                        <input type="submit" class="button" name="action" value="SearchRequest" />
                                    </div>
                                </form>
                            </div>
                            <!-- End Box Head -->
                            <!-- Table -->
                            <div class="table">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <c:if test="${requestScope.LISTREQUEST_ADMIN == null}">
                                        <tr>
                                            <th>Nothing to search</th>
                                        </tr>
                                    </c:if>


                                    <c:if test="${requestScope.LISTREQUEST_ADMIN != null}">
                                        <tr>
                                            <!-- RequestID, UserID, Name, Certificate, Description, Status -->
                                            <th></th>
                                            <th>User ID</th>
                                            <th>Name</th>
                                            <th>Certificate</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th width="110" class="ac">Content Control</th>
                                        </tr>

                                        <c:forEach var="s" items="${requestScope.LISTREQUEST_ADMIN}">
                                            <tr>
                                                <th>

                                                    <input type="hidden" name="requestId" value="${s.requestId}" />
                                                </th>
                                                <th>${s.userId}</th>
                                                <th>${s.name}</th>
                                                <th>${s.certificate}</th>
                                                <th>${s.description}</th>
                                                <th>${s.status}</th>
                                                <th>
                                                    <c:if test="${s.status eq 'true'}">
                                                        <a href="MainController?action=ApproveRequest&requestId=${s.requestId}&userId=${s.userId}" class="ico del">Approve</a>
                                                        <a href="MainController?action=DenailRequest&requestId=${s.requestId}&userId=${s.userId}" class="ico edit">Denial</a>

                                                    </c:if>

                                                </th>

                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                </table>
                                <!-- Pagging -->

                                <!-- End Pagging -->
                            </div>
                            <!-- Table -->
                        </div>
                        <!-- End Box -->
                        <!-- Box -->

                        <!-- End Box -->
                    </div>
                    <!-- End Content -->
                    <!-- Sidebar -->

                    <!-- End Sidebar -->
                    <div class="cl">&nbsp;</div>
                </div>
                <!-- Main -->
            </div>
        </div>
        <!-- End Container -->
        <!-- Footer -->
        <div id="footer">
            <div class="shell"> <span class="left">&copy; 2021 - Company Four Class</span> <span class="right"> Design by <a href="http://chocotemplates.com">Chocotemplates.com</a> </span> </div>
        </div>
        <!-- End Footer -->
    </body>
</html>
