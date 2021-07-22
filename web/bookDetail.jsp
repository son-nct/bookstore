<%-- 
    Document   : bookDetail
    Created on : Jun 25, 2021, 10:39:29 PM
    Author     : WIN 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Detail Page</title>
        <!-- Font Awesome -->
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
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.6.0/mdb.min.css"
            rel="stylesheet"
            />
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

                    <a class="btn btn-info" href="shop.jsp" style="margin-left: 20px">
                        Home
                    </a>
                </div>


                <c:if test="${not empty user}">


                    <div class="d-flex align-items-center"> 
                        <div class="d-flex align-items-center" style="font-size: 18px">
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

        <div style="margin-top: 40px ; width: 80%; font-size: 16px" class="container">
            <h2 class="section-heading mb-4">
                Book Detail
            </h2>
            <!--Section: Block Content-->


            <c:set var="book" value="${sessionScope.BOOK_DETAIL}" scope="session"/>
            <form action="addToCart" method="post">

                <input type="hidden" name="urlImg" value="${book.image}"/>
                <input type="hidden" name="txtIdBook" value="${book.idBook}"/>
                <input type="hidden" name="txtTitle" value="${book.title}"/>
                <input type="hidden" name="txtAuthor" value="${book.author}"/>
                <input type="hidden" name="txtPrice" value="${book.price}"/>
                <input type="hidden" name="txtQuantity" value="${book.quantity}"/>
                <input type="hidden" name="txtnameCategory" value="${book.nameCategory}"/>  
                <input type="hidden" name="addInDetailPage" value="true"/>  

                <section class="mb-5">

                    <div class="row">
                        <div class="col-md-6 mb-4 mb-md-0">

                            <div id="mdb-lightbox-ui"></div>

                            <div class="mdb-lightbox">

                                <div class="row product-gallery mx-1">

                                    <div class="col-12 mb-0">
                                        <figure>
                                            <a href="${book.image}"
                                               data-size="710x600">
                                                <img style="max-width: 70%" src="${book.image}"
                                                     class="img-fluid z-depth-1">
                                            </a>
                                        </figure>
                                    </div>
                                </div>

                            </div>

                        </div>
                        <div class="col-md-6">

                            <h5>${book.title}</h5>
                            <p class="pt-1">${book.description}</p>
                            <div class="table-responsive">

                                <table class="table table-sm table-borderless mb-0" style="font-size: 16px">
                                    <tbody>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Author</strong></th>
                                            <td>${book.author}</td>
                                        </tr>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Category:</strong></th>
                                            <td>${book.nameCategory}</td>
                                        </tr>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Price:</strong></th>
                                            <td>$${book.price} USD</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <c:if test="${book.quantity > 0}">
                                <div class="table-responsive mb-2">
                                    <table class="table table-sm table-borderless">
                                        <tbody>
                                            <tr>
                                                <td class="pl-0 pb-0 w-25" style="font-size: 16px">Quantity</td>
                                            </tr>
                                            <tr>
                                                <td class="pl-0">
                                                    <div class="def-number-input number-input safari_only mb-0">
                                                        <input class="quantity" min="0" name="txtAmount" value="${sessionScope.AMOUNT_VALUE}" type="number">

                                                        <c:set var="emptyAmount" value="${sessionScope.EMPTY_AMOUNT}" scope="session"/>
                                                        <c:if test="${not empty emptyAmount}">
                                                            <p style="color: red">${emptyAmount}</p>
                                                            <c:set var="emptyAmount" value=""/>
                                                        </c:if>
                                                       

                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <button type="submit" class="btn btn-primary btn-md mr-1 mb-2">
                                    <i class="fas fa-shopping-cart pr-2"></i> Add to cart
                                </button>
                            </c:if>

                            <c:if test="${book.quantity == 0}">
                                <h5 class="fw-bold text-danger">Status: Out of stock</h5>
                            </c:if>

                        </div>
                    </div>

                </section>
            </form>
        </div>
    </body>
</html>
