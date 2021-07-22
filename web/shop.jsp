<%-- 
    Document   : shop
    Created on : Jun 25, 2021, 4:05:10 PM
    Author     : WIN 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop Page</title>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!-- MDB -->
        <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.6.0/mdb.min.js"
        ></script>
    </head>
    <body>

        <c:set var="user" value="${sessionScope.USER}" scope="session"/>
        <c:if test="${user.role eq 'R1'}">
            <c:redirect url="admin.jsp"/>
        </c:if>

        <c:remove var="BEING_IN_DETAIL"/>

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
                </div>


                <c:if test="${not empty user}">

                    <div class="d-flex align-items-center"> 
                        <div class="d-flex align-items-center" style="font-size: 20px;">
                            <!-- Icon -->
                            <a class="text-reset me-3" href="loadHistory" style="font-size: 19px">
                                <i class="fas fa-history"></i> History                       
                            </a>
                            
                            <a class="text-reset me-3" href="viewCart">
                                <i class="fas fa-shopping-cart"></i>
                                <c:set var="numberItems" value="${sessionScope.NUMBER_ITEMS}" scope="session"/>
                                <c:if test="${numberItems > 0}">
                                    <span class="badge rounded-pill badge-notification bg-danger">
                                        ${numberItems}
                                    </span>
                                </c:if>
                            </a>

                            <!-- Avatar -->
                            <a
                                class="dropdown-toggle d-flex align-items-center hidden-arrow"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                data-mdb-toggle="dropdown"
                                aria-expanded="false"
                                >
                                <span class="d-flex align-items-center" style="margin: 0px 0 0 5px; text-decoration: none; color: #4F4F4F;font-size: 18px">
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
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Register</a>
                        </li>
                    </ul>
                </c:if>
            </div>

        </nav>
        <form action="search">
            <header class="py-3 mb-4 border-bottom d-flex align-items-center justify-content-center">

                <div class="filter" style="display: flex; align-items: center">


                    <div class="d-flex justify-content-center align-items-center">
                        <div style="display: flex; align-items: center; padding: 0 20px; margin-top: 5px">
                            <p style="margin: 0px 5px 0 5px; font-size: 20px">Category: </p>

                            <c:set var="cate_value" value="${sessionScope.CATEGORY_VALUE}" scope="session"/>
                            <select name="cboCategory" class="form-select" aria-label="Default select example" style="height: 40px; margin-left: 5px">

                                <c:set var="listCate" value="${sessionScope.LIST_CATE}" scope="session"/>
                                <option
                                    <c:if test="${cate_value eq 'All'}">
                                        selected="true"
                                    </c:if> 
                                    value="">All
                                </option>
                                <c:forEach var="category" items="${listCate}">
                                    <option 
                                        <c:if test="${cate_value eq category.idCategory}">
                                            selected="true"
                                        </c:if> 
                                        value="${category.idCategory}">${category.nameCategory}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div  class="d-flex justify-content-center align-items-center" style="padding: 0 20px; margin-top: 5px">
                            <p style="margin: 0px 5px 0 5px; font-size: 20px; min-width: 120px">Price range: </p>
                            <c:set var="range_value" value="${sessionScope.RANGE_VALUE}" scope="session"/>
                            <select name="cboRange" class="form-select" aria-label="Default select example" style="height: 40px">
                                <c:set var="listRange" value="${sessionScope.LIST_RANGE}" scope="session"/>
                                <c:forEach var="range" items="${listRange}">
                                    <option 
                                        <c:if test="${range_value eq range.idRange}">
                                            selected="true"
                                        </c:if> 
                                        value="${range.idRange}">${range.value}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div class="d-flex align-items-center">
                        <input name="txtSearch" id="searchValue" value="${sessionScope.SEARCH_VALUE}"  style="margin: 2px 5px 0 20px; width:300px; height: 40px" type="search" class="form-control" placeholder="Search..." aria-label="Search">
                        <button onclick="SearchResource()" style="height: 38px; margin-top: 2px" type="submit" class="btn btn-primary">Search</button>
                    </div>

                </div>
            </header>
        </form>

        <div class="container" style="max-width: 80%">
            <div class="d-flex align-items-center" style="margin-bottom: 25px; flex-wrap: wrap">
                <c:set var="listBook" value="${sessionScope.LIST_BOOK}" scope="session"/>
                <c:forEach var="book" items="${listBook}">



                    <div class="col-md"> 
                        <form action="addToCart" method="post">
                            <div class="card" style="width: 280px; height: 540px; margin-bottom: 20px">

                                <input type="hidden" name="urlImg" value="${book.image}"/>
                                <input type="hidden" name="txtIdBook" value="${book.idBook}"/>
                                <input type="hidden" name="txtTitle" value="${book.title}"/>
                                <input type="hidden" name="txtPrice" value="${book.price}"/>
                                <input type="hidden" name="txtQuantity" value="${book.quantity}"/>
                                <input type="hidden" name="txtnameCategory" value="${book.nameCategory}"/>
                                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                                    <img
                                        src="${book.image}"
                                        class="img-fluid"
                                        width="280"
                                        height="300"
                                        style="object-fit: cover"
                                        />



                                    <a href="loadDetail?txtId=${book.idBook}">
                                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                                    </a>
                                </div>
                                <div class="card-body">
                                    <h5 style="cursor: pointer" class="card-title fw-bold text-primary text-truncate">
                                        <a href="loadDetail?txtId=${book.idBook}"> ${book.title}</a>
                                    </h5>
                                    <span style="padding: 10px 0 0px 0; display: block;">
                                        <span class="card-text d-flex align-items-center" style="margin-bottom: 0">
                                            <span class="card-text" style="margin-bottom: 0">
                                                <label class="fw-bold" style="min-width: 80px">Category: </label> ${book.nameCategory}
                                            </span>
                                        </span>

                                        <span class="card-text d-flex align-items-center" style="margin-bottom: 0">
                                            <span class="card-text" style="margin-bottom: 0">
                                                <label class="fw-bold" style="min-width: 80px">Price: </label> $${book.price} USD
                                            </span>
                                        </span>


                                        <span class="card-text d-flex align-items-center" style="margin-bottom: 0">
                                            <label class="fw-bold" style="min-width: 80px">Status: </label>
                                            <c:if test="${book.quantity >0}">
                                                Available
                                            </c:if>
                                            <c:if test="${book.quantity == 0}">
                                                <label class="text-danger" st>Out of stock</label>
                                            </c:if>
                                        </span> 

                                    </span>


                                </div>
                                <span class="d-flex align-items-center" style="margin: 10px 0">
                                    <c:if test="${book.quantity > 0}">
                                        <button class="btn btn-primary">Add To Cart <i class="fas fa-shopping-cart"></i></button> 
                                        </c:if>
                                </span>
                            </div>

                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>     
    </body>
</html>
