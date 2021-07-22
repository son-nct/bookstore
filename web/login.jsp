<%-- 
    Document   : login
    Created on : Jun 5, 2021, 8:01:53 AM
    Author     : WIN 10
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
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

        <c:set var="user" value="${sessionScope.USER}" scope="session"/>
        <c:if test="${not empty user}">
            <c:redirect url="shop.jsp"/>
        </c:if>

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
                    <li style="margin-right: 5px" class="nav-item"><a href="signup.jsp" class="btn btn-info">Sign Up</a></li>
                    <li class="nav-item"><a href="shop.jsp" class="btn btn-info">Shop Page</a></li>
                </ul>
            </header>

            <div class="body-page" style="margin-top: 5%">
                <div class="container col-xl-10 col-xxl-8 px-4 " >
                    <div class="row align-items-center g-lg-5 py-2">
                        <div class="col-md-10 mx-auto col-lg-5" >
                            <form action="login" method="POST" class="p-4 p-md-5 border rounded-3 bg-light" style="width: 400px; position: relative">
                                <h3 style=" text-align: center; margin: -25px 0 20px 0">Login</h3>
                                <div class="form-floating mb-3">
                                    <input name="txtUsername" type="text" class="form-control" id="floatingInput" placeholder="abc@gmail.com">
                                    <label for="floatingInput">Username:</label>

                                </div>
                                <div class="form-floating mb-3">
                                    <input name="txtPassword" type="password" class="form-control" id="floatingPassword" placeholder="Password">
                                    <label for="floatingPassword">Password</label>
                                </div>
                                <div class="checkbox mb-3">
                                    <label>
                                        <input type="checkbox" value="remember-me"> Remember me
                                    </label>
                                </div>

                                <span>
                                    <c:set var="error" value="${sessionScope.LOGIN_ERROR}" scope="session"/>
                                    <c:if test="${not empty error}">
                                        <p style="color: red; text-align: center;">${error}</p>
                                        <c:remove var="error"/>
                                    </c:if>
                                </span>
                                <button id="login-btn" class="w-100 btn btn-lg btn-primary" type="submit">
                                    Login
                                </button >

                                <hr class="my-4">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>