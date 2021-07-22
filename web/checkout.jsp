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
        <title>Check Out Page</title>
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
        <script src="https://www.paypalobjects.com/api/checkout.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                    <a class="btn btn-info" href="admin.jsp" style="margin-left: 20px">
                        Home
                    </a>
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
                    <c:redirect url="shop.jsp"/>
                </c:if>
            </div>

        </nav>
        <div class="jumbotron color-grey-light mt-70">
            <div class="d-flex align-items-center h-100">
                <div class="container text-center py-5">
                    <h3 class="mb-0">Checkout</h3>
                </div>
            </div>
        </div>
        <main>
            <div class="container">

                <c:set var="map" value="${sessionScope.ITEMS}" scope="session"/>
                <c:set var="numberItems" value="${sessionScope.NUMBER_ITEMS}" scope="session"/>
                <!--Section: Block Content-->
                <section class="mt-5 mb-4" >

                    <!--Grid row-->
                    <div class="row" style="margin-top: -50px">

                        <!--Grid column-->
                        <div class="col-lg-8">

                            <!-- Card -->
                            <div class="card wish-list mb-4" >
                                <div class="card-body">

                                    <h5 class="mb-4">Customer Details</h5>
                                    <div class="row mb-4">
                                        <div >
                                            <div class="d-flex ">
                                                <label class="fw-bold" style="margin-right: 10px; min-width: 150px">Full Name: </label>  
                                                <p>${user.fullname}</p>
                                            </div>
                                            <div class="d-flex ">
                                                <label class="fw-bold" style="margin-right: 10px; min-width: 150px">Email: </label>  
                                                <p>${user.email}</p>
                                            </div>
                                            <div  class="d-flex ">
                                                <label class="fw-bold" style="margin-right: 10px; min-width: 150px">Phone: </label>  
                                                <p>${user.phone}</p>
                                            </div>
                                            <div class="d-flex ">
                                                <label class="fw-bold" style="margin-right: 10px; min-width: 150px">Shipping Address: </label>  
                                                <p>${user.address}</p>
                                            </div>
                                        </div>


                                    </div>
                                    <hr class="mb-4">
                                    <p class="text-primary mb-0"><i class="fas fa-info-circle mr-1"></i> Please check carefully before paying.</p>

                                </div>
                            </div>
                            <!-- Card -->
                            <!-- Card -->

                            <!-- Card -->
                            <c:if test="${not empty map}">
                                <div class="card mb-4">
                                    <div class="card-body">

                                        <h5 class="mb-4">Select Your Payment Method</h5>
                                        <div class="d-flex align-items-center">
                                            <a onclick="shipCODPayment()" style="cursor: pointer; margin-right: 20px">
                                                <img class="mr-2" width="200px" src="https://binhduonglogistics.com/wp-content/uploads/2021/05/ship-cod-la-gi-loi-ich-cua-hinh-thuc-nay.png" alt="Direct payment">
                                            </a>

                                            <div id="paypal-button"></div>
                                        </div>
                                    </div>

                                </div>
                            </c:if>

                        </div>

                        <div class="col-lg-4">

                            <!-- Card -->
                            <c:if test="${numberItems > 0 }">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <c:set var="itemNumber" value="${sessionScope.NUMBER_ITEMS}" scope="session"/>
                                        <c:set var="totalPrice" value="${sessionScope.TOTAL}" scope="session"/>
                                        <h5 class="mb-3">The total amount of ${itemNumber}</h5>

                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
                                                Temporary amount
                                                <span>$${totalPrice}</span>
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
                                                <span><strong>$${totalPrice}</strong></span>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                                <!-- Card -->

                                <!-- Card -->
                                <div class="card mb-4">
                                    <div class="card-body">

                                        <a
                                            class="btn btn-primary"
                                            data-mdb-toggle="collapse"
                                            href="#collapseExample"
                                            role="button"
                                            aria-expanded="false"
                                            aria-controls="collapseExample"
                                            >
                                            Add a discount code !
                                        </a>


                                        <!-- Collapsed content -->
                                        <div class="collapse mt-3" id="collapseExample">
                                            <div style="position: relative">
                                                <input style="height: 38px  " name="txtDiscount" value="" type="number" class="form-control"  placeholder="Input code">
                                            </div>

                                        </div>
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



            paypal.Button.render({
                // Configure environment
                env: 'sandbox',
                client: {
                    sandbox: 'demo_sandbox_client_id',
                    production: 'demo_production_client_id'
                },
                // Customize button (optional)
                locale: 'en_US',
                style: {
                    layout: 'vertical',
                    color: 'gold',
                    label: 'paypal'
                },

                // Enable Pay Now checkout flow (optional)
                commit: true,

                // Set up a payment
                payment: function (data, actions) {
                    $.ajax({
                        url: "checkPayment",
                        method: "GET",
                        data: "",
                        success: function (data) {
                            if (data === 'true') {
                                window.location.href = 'checkout?txtTotal=${totalPrice}';
                            }
                        },
                    });

                    return actions.payment.create({
                        transactions: [{
                                amount: {
                                    total: ${totalPrice},
                                    currency: 'USD'
                                }
                            }]
                    });
                },
                // Execute the payment
                onAuthorize: function (data, actions) {
                    //mai thử ajax ở đoạn này check quantity

                    return actions.payment.execute().then(function () {
                        // Show a confirmation message to the buyer
                        $.ajax({
                            url: "saveOrder",
                            method: "GET",
                            data: {totalMoney: ${totalPrice}},
                            success: function (data) {
                                swal({
                                    title: "Payment success",
                                    icon: "success",
                                    buttons: {
                                        catch : {
                                            text: "Back to shop",
                                        },
                                    },
                                }).then((value) => {
                                    window.location.href = "http://localhost:8084/Lab3_BookStore_SE140371/LoadListBookServlet";
                                });
                            },
                        });
                    });
                }
            }, '#paypal-button');


            function shipCODPayment() {
                $.ajax({
                    url: "checkPayment",
                    method: "GET",
                    data: "",
                    success: function (data) {
                        if (data === 'true') {
                            window.location.href = 'checkout?txtTotal=${totalPrice}';
                        } else {
                            $.ajax({
                                url: "saveShipCOD",
                                method: "GET",
                                data: {totalMoney: ${totalPrice}},
                                success: function (data) {
                                    swal({
                                        title: "Payment success",
                                        icon: "success",
                                        buttons: {
                                            catch : {
                                                text: "Back to shop",
                                            },
                                        },
                                    }).then((value) => {
                                        window.location.href = "http://localhost:8084/Lab3_BookStore_SE140371/LoadListBookServlet";
                                    });
                                },
                            });
                        }
                    },
                });
            }
        </script>
    </body>
</html>
