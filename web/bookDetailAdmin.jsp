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
        <title>Book Detail Admin Page</title>
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
    <body style="overflow: hidden">

        <c:set var="user" value="${sessionScope.USER}" scope="session"/>
        <c:if test="${user.role ne 'R1'}">
            <c:redirect url="shop.jsp"/>
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
                    <a class="btn btn-info" href="admin.jsp" style="margin-left: 20px">
                        Home
                    </a>
                </div>


                <c:if test="${not empty user}">


                    <div class="d-flex align-items-center"> 
                        <div class="d-flex align-items-center" style="font-size: 18px">

                            <!-- Avatar -->
                            <a
                                class="dropdown-toggle d-flex align-items-center hidden-arrow"
                                href="#"
                                id="navbarDropdownMenuLink"
                                role="button"
                                data-mdb-toggle="dropdown"
                                aria-expanded="false"
                                >
                                <span class="d-flex align-items-center" style="margin: 0px 15px  0 5px; text-decoration: none; color: #4F4F4F;font-size: 18px">
                                    <i style="margin: -5px 5px 0 0" class="far fa-user"></i>Admin: ${user.fullname}
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

        <div style="margin-top: 20px;width: 80%; font-size: 16px" class="container">
            <h2 class="section-heading mb-4">
                Book Detail
            </h2>
            <!--Section: Block Content-->
            <section class="mb-5">

                <div class="row">
                    <div class="col-md-6 mb-4 mb-md-0">

                        <div id="mdb-lightbox-ui"></div>

                        <div class="mdb-lightbox">

                            <div class="row product-gallery mx-1">
                                <c:set var="book" value="${sessionScope.BOOK_DETAIL}" scope="session"/>
                                <div class="col-12 mb-0">
                                    <figure class="view overlay rounded z-depth-1 main-img">
                                        <a href="${book.image}"
                                           data-size="710x823">
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
                                    <tr>
                                        <th class="pl-0 w-25" scope="row"><strong>Quantity</strong></th>
                                        <td>${book.quantity}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
</html>
