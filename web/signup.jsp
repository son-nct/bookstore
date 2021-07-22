
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="stylesheet" href="./assets/css/signIn.css">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
            rel="stylesheet"
            />
        <!-- MDB -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.5.0/mdb.min.css"
            rel="stylesheet"
            />   
        <script>
            function prevenBack() {
                window.history.forward();
            }
            window.setTimeout("prevenBack()", 0);
            window.onunload = () => {
                null;
            };
        </script>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="container">
                    <header class="d-flex flex-wrap py-3 mb-4 border-bottom align-items-center justify-content-between">
                        <span class="d-flex align-items-center">
                            <a class="navbar-brand mt-2 mt-lg-0">
                                <img
                                    src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Closed_Book_Icon.svg/1200px-Closed_Book_Icon.svg.png"
                                    height="40"
                                    alt=""
                                    loading="lazy"
                                    />
                            </a>
                            <span style="margin-top: 6px" class="fs-4">Book IT Store</span>
                        </span>

                        <ul class="nav nav-pills">
                            <li style="margin-right: 5px" class="nav-item"><a href="login.jsp" class="btn btn-info">Login</a></li>
                            <li class="nav-item"><a href="shop.jsp" class="btn btn-info">Shop Page</a></li>
                        </ul>
                    </header>
                </div>
            </div>

            <div class="body-page">
                <div class="container col-xl-10 col-xxl-8 px-0 py-1" >
                    <div class="row align-items-center g-lg-5 py-2">
                        <div class="col-md-10 mx-auto col-lg-5" >
                            <form action="signup" method="POST" class="p-4 p-md-5 border rounded-3 bg-light" style="width: 400px">

                                <h3 style=" text-align: center; margin: -25px 0 20px 0">Sign Up</h3>

                                <div class="form-floating mb-3">
                                    <input name="txtUsername" value="${param.txtUsername}" type="text" class="form-control" id="floatingInput" placeholder="name@example.com">
                                    <label for="floatingInput">Username</label>

                                    <c:set var="exit_user" value="${requestScope.exit_user}" scope="request"/>
                                    <c:set var="empty_username" value="${requestScope.empty_username}" scope="request"/>
                                    <c:choose>
                                        <c:when test="${not empty exit_user}">
                                            <div style="margin:2px 0 15px 0">
                                                <span style="margin-left: 2px; color: red">${exit_user}</span>
                                            </div>
                                            <c:set var="exit_user" value="" scope="request"/>
                                        </c:when>

                                        <c:when test="${not empty empty_username}">
                                            <div style="margin:2px 0 15px 0">
                                                <span style="margin-left: 2px; color: red">${empty_username}</span>
                                            </div>
                                            <c:set var="empty_username" value="" scope="request"/>
                                        </c:when>
                                    </c:choose>

                                </div>

                                <div class="form-floating mb-3" style="position: relative">
                                    <input name="txtPassword" value="${param.txtPassword}" type="password" class="form-control" id="floatingPassword" placeholder="Password">
                                    <label for="floatingPassword">Password</label>

                                    <c:set var="empty_password" value="${requestScope.empty_password}" scope="request"/>
                                    <c:if test="${not empty empty_password}">
                                        <div style="margin:2px 0 0px 0;">
                                            <span style="margin-left: 2px; color: red">${empty_password}</span>
                                        </div>
                                        <c:set var="empty_password" value="" scope="request"/>
                                    </c:if>
                                </div>

                                <div class="form-floating mb-3" style="position: relative">
                                    <input name="txtRepassword" value="${param.txtRepassword}" type="password" class="form-control" id="floatingPassword" placeholder="Password">
                                    <label for="floatingPassword">Re-password</label>

                                    <c:set var="not_match" value="${requestScope.not_match}" scope="request"/>
                                    <c:if test="${not empty not_match}">
                                        <div  style="margin:2px 0 0px 0;">
                                            <span style="margin-left: 2px; color: red">${not_match}</span>
                                        </div>
                                        <c:set var="not_match" value="" scope="request"/>
                                    </c:if>
                                </div>



                                <div class="form-floating mb-3">
                                    <input name="txtFullname" value="${param.txtFullname}" type="text" class="form-control" id="floatingInput"  placeholder="name@example.com">
                                    <label for="floatingInput">Fullname</label>

                                    <c:set var="empty_fullname" value="${requestScope.empty_fullname}" scope="request"/>
                                    <c:if test="${not empty empty_fullname}">
                                        <div  style="margin:2px 0 0px 0;">
                                            <span style="margin-left: 2px; color: red">${empty_fullname}</span>
                                        </div>
                                        <c:set var="empty_fullname" value="" scope="request"/>
                                    </c:if>
                                </div>

                                <div class="form-floating mb-3">
                                    <input name="txtEmail" value="${param.txtEmail}" type="text" class="form-control" id="floatingInput"  placeholder="name@example.com">
                                    <label for="floatingInput">Email</label>

                                    <c:set var="empty_email" value="${requestScope.empty_email}" scope="request"/>
                                    <c:set var="invalid_email" value="${requestScope.invalid_email}" scope="request"/>
                                    <c:choose>
                                        <c:when test="${not empty empty_email}">
                                            <div style="margin:2px 0 15px 0">
                                                <span style="margin-left: 2px; color: red">${empty_email}</span>
                                            </div>
                                            <c:set var="empty_email" value="" scope="request"/>
                                        </c:when>

                                        <c:when test="${not empty invalid_email}">
                                            <div style="margin:2px 0 15px 0">
                                                <span style="margin-left: 2px; color: red">${invalid_email}</span>
                                            </div>
                                            <c:set var="invalid_email" value="" scope="request"/>
                                        </c:when>
                                    </c:choose>

                                </div>

                                <div class="form-floating mb-3">
                                    <input name="txtPhone" value="${param.txtPhone}" type="text" class="form-control" id="floatingInput" placeholder="Phone">
                                    <label for="floatingInput">Phone</label>

                                    <c:set var="empty_phone" value="${requestScope.empty_phone}" scope="request"/>
                                    <c:set var="error_phone" value="${requestScope.error_phone}" scope="request"/>
                                    <c:choose>
                                        <c:when test="${not empty empty_phone}">
                                            <div style="margin:2px 0 15px 0">
                                                <span style="margin-left: 2px; color: red">${empty_phone}</span>
                                            </div>
                                            <c:set var="empty_phone" value="" scope="request"/>
                                        </c:when>

                                        <c:when test="${not empty error_phone}">
                                            <div style="margin:2px 0 15px 0">
                                                <span  style="margin-left: 2px; color: red">${error_phone}</span>
                                            </div>
                                            <c:set var="error_phone" value="" scope="request"/>
                                        </c:when>
                                    </c:choose>
                                </div>

                                <div class="form-floating mb-3">
                                    <input name="txtAddress" value="${param.txtAddress}" type="text" class="form-control" id="floatingInput" placeholder="Address">
                                    <label for="floatingInput">Address</label>

                                    <c:set var="empty_address" value="${requestScope.empty_address}" scope="request"/>
                                    <c:if test="${not empty empty_address}">
                                        <div style="margin:2px 0 0px 0;">
                                            <span style="margin-left: 2px; color: red">${empty_address}</span>
                                        </div>
                                        <c:set var="empty_address" value="" scope="request"/>
                                    </c:if>
                                </div>

                                <button name="btnAction" value="signUp" class="w-100 btn btn-lg btn-primary" type="submit">Sign up</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>



