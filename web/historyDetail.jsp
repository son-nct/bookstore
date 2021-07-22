<%-- 
    Document   : viewCart
    Created on : Jun 28, 2021, 11:19:48 PM
    Author     : WIN 10
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Detail Page</title>
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
            rel="stylesheet"
            />
        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
            />
        <!-- MDB -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.5.0/mdb.min.css"
            rel="stylesheet"
            />
        <!-- MDB -->
        <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.5.0/mdb.min.js"
        ></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.USER}" scope="session"/>
        <c:if test="${user.role eq 'R1'}">
            <c:redirect url="admin.jsp"/>
        </c:if>




        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <!-- Toggle button -->
                <button
                    class="navbar-toggler"
                    type="button"
                    data-mdb-toggle="collapse"
                    data-mdb-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <i class="fas fa-bars"></i>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <a class="navbar-brand mt-2 mt-lg-0" href="shop.jsp">
                        <img
                            src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Closed_Book_Icon.svg/1200px-Closed_Book_Icon.svg.png"
                            height="40"
                            alt=""
                            loading="lazy"
                            />
                    </a>
                    <ul class="navbar-nav">
                        Book IT Store
                    </ul>
                    <a class="btn btn-info" href="LoadListBookServlet" style="margin-left: 20px">
                        Home
                    </a>
                </div>


                <c:if test="${not empty user}">

                    <div class="d-flex align-items-center"> 
                        <div class="d-flex align-items-center" style="font-size: 20px;">
                            <!-- Avatar -->
                            <a class="text-reset me-3" href="loadHistory" style="font-size: 19px">
                                <i class="fas fa-history"></i> History                       
                            </a>

                            <a
                                class="dropdown-toggle d-flex align-items-center hidden-arrow"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                data-mdb-toggle="dropdown"
                                aria-expanded="false"
                                >
                                <span class="d-flex align-items-center" style="margin: 0px 15px 0 5px; text-decoration: none; color: #4F4F4F;font-size: 18px">
                                    <i style="margin: 0px 5px 0 0" class="far fa-user"></i>${user.fullname}
                                </span>
                            </a>
                            <ul
                                class="dropdown-menu dropdown-menu-end"
                                aria-labelledby="navbarDropdownMenuLink"
                                style="margin: -20px 15px 0 0"
                                >
                                <li>
                                    <a class="dropdown-item" href="logout">Logout</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                </c:if>

                <c:if test="${empty user}">
                    <c:redirect url="shop.jsp"/>
                </c:if>
            </div>

        </nav>
        <div class="jumbotron color-grey-light mt-70">
            <div class="d-flex align-items-center h-100">
                <div class="container text-center py-5">
                    <h3 class="mb-0">History Detail</h3>
                </div>
            </div>
        </div>
        <main>
            <div class="container">


                <!--Section: Block Content-->
                <section class="mt-5 mb-4">

                    <!--Grid row-->
                    <div class="row">

                        <!--Grid column-->
                        <div class="col-lg-8">

                            <!-- Card -->
                            <div class="card wish-list mb-4">
                                <div class="card-body">

                                    <div class="d-flex justify-content-between">
                                        <span class="d-flex">
                                            <h5 class="mb-4" style="margin-right: 10px">Id Order :</h5> 
                                            <p style="font-size: 18px; margin-top: -2px">${sessionScope.ID_ORDER}</p>
                                        </span>

                                        <span class="d-flex">
                                            <h5 class="mb-4" style="margin-right: 10px">Date Order :</h5> 
                                            <p style="font-size: 18px; margin-top: -2px">${sessionScope.DATE_ORDER}</p>
                                        </span>
                                    </div>


                                    <c:set var="total" value=""/>  
                                    <c:set var="listDetail" value="${sessionScope.LIST_DETAIL}" scope="session"/>   

                                    <c:forEach var="detail" items="${listDetail}">
                                        <div class="row mb-4" style="margin-bottom: 20px">
                                            <div class="col-md-5 col-lg-3 col-xl-3">
                                                <div class="view zoom overlay z-depth-1 rounded mb-3 mb-md-0">
                                                    <img class="img-fluid w-10" src="${detail.image}" alt="Sample">
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-9 col-xl-9">
                                                <div class="row mb-4">
                                                    <div class="d-flex justify-content-between">
                                                        <div>
                                                            <h5 class="text-primary">${detail.title}</h5>
                                                            <p class="mb-3 text-muted text-uppercase">Category: ${detail.category}</p>
                                                            <span class="d-flex" style="font-size: 18px">
                                                                <p class="mb-2" style="margin-right: 15px">Price: ${detail.price}$</p> X 
                                                                <p style="margin: 0 15px 0 15px" class="mb-2">${detail.amount}</p> = 
                                                                <c:set var="total" value="${detail.price * detail.amount}"/>
                                                                <p style="margin-left: 15px" class="mb-2">${total}$</p>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr class="mb-4">
                                    </c:forEach>
                                    <h5 style="float: right" class="text-danger">Total: ${sessionScope.TOTAL_MONEY} $</h5>
                                </div>
                            </div>

                        </div>


                    </div>

                </section>
            </div>
        </main>
    </body>
</html>
