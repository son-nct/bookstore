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
        <title>View Cart Page</title>
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
                    <h3 class="mb-0">Shopping cart</h3>
                </div>
            </div>
        </div>
        <main>
            <div class="container">

                <c:set var="map" value="${sessionScope.ITEMS}" scope="session"/>
                <c:set var="numberItems" value="${sessionScope.NUMBER_ITEMS}" scope="session"/>
                <c:if test="${empty numberItems}">
                     <c:set var="numberItems" value="0" scope="session"/>
                </c:if>
                <!--Section: Block Content-->
                <section class="mt-5 mb-4">

                    <!--Grid row-->
                    <div class="row">

                        <!--Grid column-->
                        <div class="col-lg-8">

                            <!-- Card -->
                            <div class="card wish-list mb-4">
                                <div class="card-body">

                                    <h5 class="mb-4">Cart (<span>${numberItems}</span> items)</h5>
                                    <c:set var="total" value=""/>  

                                    <c:set var="listError" value="${sessionScope.LIST_OUT_OF_STOCK}" scope="session"/>   
                                    <c:set var="idError" value=""/>   
                                    <c:set var="remainingQuantity" value=""/>   

                                    <c:forEach var="book" items="${map.keySet()}">

                                        <c:forEach var="bookError" items="${listError}">
                                            <c:if test="${bookError.idBook eq book.idBook}">
                                                <c:set var="idError" value="${book.idBook}"/>
                                                <c:set var="remainingQuantity" value="${bookError.quantity}"/>
                                            </c:if>
                                        </c:forEach>

                                        <div class="row mb-4">
                                            <div class="col-md-5 col-lg-3 col-xl-3">
                                                <div class="view zoom overlay z-depth-1 rounded mb-3 mb-md-0">
                                                    <img class="img-fluid w-10" src="${book.image}" alt="Sample">

                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-9 col-xl-9">
                                                <div class="row mb-4">
                                                    <div class="d-flex justify-content-between">
                                                        <div>
                                                            <h5>${book.title}</h5>
                                                            <p class="mb-3 text-muted text-uppercase">Category: ${book.nameCategory}</p>
                                                            <p class="mb-2 text-uppercase small">Price:  $${book.price}</p>
                                                            <span class="d-flex align-items-center">
                                                                <p style="margin: 8px 15px 0 0" class="mb-2 text-uppercase small">Quantity: ${map.get(book)}</p>
                                                                <button onclick="updateQuantity('${book.idBook}')" style="margin-top: -5px" class="btn btn-success">Update Quantity</button>
                                                            </span>

                                                            <div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <a onclick="askToDelete('${book.idBook}')" style="cursor: pointer" type="button" class="card-link-secondary small text-uppercase mr-3"><i class="fas fa-trash-alt mr-1"></i> Remove item </a>
                                                        </div>

                                                        <p class="mb-0"><span><strong>$${map.get(book) * book.price}</strong></span></p>
                                                                    <c:set var="total" value="${total + map.get(book) * book.price}"/>


                                                    </div>
                                                    <c:if test="${book.idBook eq idError and remainingQuantity != 0}">
                                                        <span style="margin-top: 10px; color: red" class="d-flex">
                                                            <i class="fas fa-exclamation-circle" style="margin: 5px 5px 0 0"></i>
                                                            <p>Our shop only have ${remainingQuantity} of these books left !</p>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${book.idBook eq idError and remainingQuantity == 0}">
                                                        <span style="margin-top: 10px; color: red" class="d-flex">
                                                            <i class="fas fa-exclamation-circle" style="margin: 5px 5px 0 0"></i>
                                                            <p>This book is out of stock !</p>
                                                        </span>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>



                                    <hr class="mb-4">
                                    <p class="text-primary mb-0"><i class="fas fa-info-circle mr-1"></i> Do not delay the purchase, adding
                                        items to your cart does not mean booking them.</p>

                                </div>
                            </div>
                            <!-- Card -->
                            <!-- Card -->

                            <!-- Card -->
                            <c:if test="${not empty map}">
                                <div class="card mb-4">
                                    <div class="card-body">

                                        <h5 class="mb-4">We accept</h5>
                                        <img class="mr-2" width="45px" src="https://www.sketchappsources.com/resources/source-image/PayPalCard.png" alt="Mastercard">
                                    </div>
                                </div>
                            </c:if>

                        </div>

                        <div class="col-lg-4">

                            <!-- Card -->
                            <c:if test="${numberItems > 0 }">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <form action="checkout" method="post">
                                            <h5 class="mb-3">The total amount of ${numberItems} items</h5>

                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
                                                    Temporary amount
                                                    <span>$${total}</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                                    Shipping
                                                    <span>Gratis</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                                    <div>
                                                        <strong>The total amount of</strong>
                                                        <strong>
                                                            <p class="mb-0">(including VAT)</p>
                                                        </strong>
                                                    </div>
                                                    <span><strong>$${total}</strong></span>
                                                </li>
                                            </ul>
                                            <input type="hidden" name="txtTotal" value="${total}"/>
                                            <button type="submit" class="btn btn-primary btn-block waves-effect waves-light">go to
                                                checkout
                                            </button>
                                        </form>

                                    </div>
                                </div>
                            </c:if>

                        </div>
                        <!--Grid column-->

                    </div>
                    <!--Grid row-->

                </section>
            </div>
        </main>
        <script>
            function updateQuantity(idBook) {
                swal({
                    title: "Enter new quantity ",
                    content: {
                        element: "input",
                        attributes: {
                            placeholder: "Type positive number",
                            type: "number",
                        }
                    },
                    buttons: true,
                    dangerMode: true
                })
                        .then((value) => {
                            if (value.length > 0 && parseInt(value) > 0) {
                                window.location.href = "updateQuantity?idBook=" + idBook
                                        + "&txtQuantity=" + value;
                            } else {
                                swal(`Please input positive number !`);
                            }

                        });
            }


            function askToDelete(idBook) {
                swal({
                    title: "Are you sure to remove this item?",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true
                }).then((willDelete) => {
                    if (willDelete) {
                        window.location.href = "removeInCart?idBook=" + idBook;
                    }
                });

            }
        </script>
    </body>
</html>
