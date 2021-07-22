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
        <title>History Page</title>
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
                    <h3 class="mb-0">History purchase</h3>
                </div>
            </div>
        </div>
        <main>
            <div class="container">

                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <form action="loadHistory" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3 d-flex align-items-center">
                        <span>
                            <input id="searchValue" name="txtDate" value="${sessionScope.DATE_VALUE}" type="date" class="form-control"  aria-label="Search">
                        </span>
                        <span style="margin-left: 15px">
                            <button class="btn btn-outline-primary">Search By Date</button>
                            <button onclick="clearDate()" class="btn btn-outline-primary">Search All</button>
                        </span>
                    </form>
                </div>

                <c:set var="listOrder" value="${sessionScope.LIST_ORDER}" scope="session"/>
                <c:if test="${not empty listOrder}">

                    <table class="table" style="font-size: 18px">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Id Order</th>
                                <th scope="col">Date Purchase</th>
                                <th scope="col">Total Money</th>
                                <th scope="col">Method Payment</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>



                            <c:forEach var="order" items="${listOrder}" varStatus="counter">
                            <form action="historyDetail">
                                <tr>
                                    <th scope="row">${counter.count}</th>
                                    <td>
                                        ${order.idOrder}
                                        <input type="hidden" value="${order.idOrder}" name="txtIdOrder"/>
                                    </td>
                                    <td>
                                        ${order.dateOrder}
                                        <input type="hidden" value="${order.dateOrder}" name="txtDateOrder"/>
                                    </td>
                                    <td>
                                        ${order.totalMoney} $
                                        <input type="hidden" value="${order.totalMoney}" name="txtTotalMoney"/>
                                    </td>
                                    <td>${order.methodPayment}</td>
                                    <td>
                                        <button class="btn btn-secondary btn-rounded">
                                            View Detail
                                        </button>
                                    </td>
                                </tr>
                            </form>

                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty listOrder}">
                    <h5 style="text-align: center" class="text-danger">No record is match !</h5>
                </c:if>
            </div>
        </main>
        <script>
            function clearDate() {
                document.getElementById('searchValue').valueAsDate = null;
            }

        </script>
    </body>
</html>
