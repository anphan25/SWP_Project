<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:set var = "userlist" value = "${requestScope.USER_LIST}" />
<c:set var = "currentadmin" value = "${sessionScope.CURRENT_USER}" />

<c:if test = "${empty currentadmin}">
    <c:redirect url = "firstLoginPage"/>
</c:if>
<c:if test = "${currentadmin.role != 'A'}">
    Duma admin fake
    <script>window.history.back();</script>
    <%-- sau lày có lỗi thì đổi lại page 404. --%>
</c:if>
<div id="freshair">
                        <table>
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Email</th>
                                    <th>huhu</th>
                                    <th>Fullname</th>
                                    <th>Gender</th>
                                    <th>Campus</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th colspan="2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var = "loto" items = "${userlist}" varStatus = "counter"> 
                                <tr> 
                                    <td>${counter.count}</td> 
                                    <td>${loto.email}</td> 
                                    <input type="hidden" id="e${counter.count}" value="${loto.email}"/>
                                    <td>${loto.name}</td> 
                                    <td>${loto.gender}</td> 
                                    <td>${loto.campus}</td> 
                                    <td> 
                                        <select id="${counter.count}" name="txtList" > 
                                        <c:if test = "${loto.role == 'Admin'}" > 
                                        <option selected="selected" value="A">Admin</option> 
                                        <option value="S">Student</option> 
                                        <option value="M">Mentor</option> 
                                        </c:if> <c:if test = "${loto.role == 'Mentor'}" > 
                                        <option value="A">Admin</option> 
                                        <option value="S">Student</option> 
                                        <option selected="selected" value="M">Mentor</option> 
                                        </c:if> <c:if test = "${loto.role == 'Student'}" > 
                                        <option value="A">Admin</option> 
                                        <option selected="selected" value="S">Student</option> 
                                        <option value="M">Mentor</option> </c:if> 
                                        </select> 
                                    </td> 
                                    <td>${loto.statusaccount}</td> 
                                    <td><button class="update-btn" name="btAction" value="updating" onclick="kingcrimson('u${counter.count}')" >Update</button></td> 
                                    <td><button class="ban-btn" name="btAction" value="banning" onclick="kingcrimson('b${counter.count}')" >Ban</button></td> 
                                </tr>
                                </c:forEach>
                            </tbody>   
                        </table>
</div>
