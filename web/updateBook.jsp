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
        <title>Update Page</title>
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
        <script src="./assets/js/uploadImg.js"></script>
    </head>
    <body>

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

        <div style="margin-top: 5px ;width: 80%; font-size: 16px" class="container">
            <h2 class="section-heading mb-4">
                Update Book
            </h2>
            <!--Section: Block Content-->
            <section class="mb-5">
                <form action="updateBook" method="post">
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
                                                <img id="img" style="max-width: 70%" src="${book.image}"
                                                     class="img-fluid z-depth-1">
                                            </a>
                                        </figure>
                                    </div>

                                    <div id="overplay" class="position-fixed  start-0 end-0 bottom-0" style="top: 200%;background-color: rgba(255,255,255,0.5)"></div>
                                    <div class="d-flex justify-content-center align-items-center position-fixed  start-0 end-0 bottom-0" id="loading" style="top:200%">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>

                                    <span class="d-flex align-items-center">
                                        <p class="fw-bold text-primary" style="margin: 3px 5px 0 0">Change Image: </p>
                                        <input onchange="uploadImg()" id="file" type="file" name="txtImage" placeholder="Select new image">
                                        <input id="urlHidden" type="hidden" value="${book.image}" name="urlImg"/>
                                    </span>
                                </div>

                            </div>

                        </div>
                        <div class="col-md-6">
                            <span>
                                <p class="fw-bold" style="margin-bottom: 0">Title:<p> 
                                    <input name="txtTitle" value="${book.title}" style="width: 100%"/><br/>
                                    <input type="hidden" name="txtIdBook" value="${book.idBook}"/>
                            </span>
                            <c:set var="emptyTitle" value="${requestScope.EMPTY_TITLE}" scope="request"/>
                            <c:if test="${not empty emptyTitle}">
                                <p style="color: red">${emptyTitle}</p>
                                <c:remove var="emptyTitle"/>
                            </c:if>

                            <span>
                                <p class="fw-bold" style="margin-bottom: 0">Description:<p> 
                                    <textarea  name="txtDescription"  style="width: 100%; height: 200px">${book.description}</textarea>
                            </span>


                            <div class="table-responsive">
                                <table class="table table-sm table-borderless mb-0" style="font-size: 16px">
                                    <tbody>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Author</strong></th>
                                            <td>
                                                <input style="width: 100%" name="txtAuthor" value="${book.author}"/>
                                                <c:set var="emptyAuthor" value="${requestScope.EMPTY_AUTHOR}" scope="request"/>
                                                <c:if test="${not empty emptyAuthor}">
                                                    <p style="color: red">${emptyAuthor}</p>
                                                    <c:set var="emptyAuthor" value=""/>
                                                </c:if>
                                            </td>

                                        </tr>

                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><p class="fw-bold" style="margin-top: 10px">Category:</p></th>
                                            <td>
                                                <select name="cboCategory" class="form-select" aria-label="Default select example" style="width: 150px">
                                                    <c:set var="listCate" value="${sessionScope.LIST_CATE}" scope="session"/>

                                                    <c:forEach var="category" items="${listCate}">
                                                        <option 
                                                            <c:if test="${book.nameCategory eq category.nameCategory}">
                                                                selected="true"
                                                            </c:if> 
                                                            value="${category.idCategory}">${category.nameCategory}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Price:</strong></th>
                                            <td>
                                                <span class="d-flex align-items-center">
                                                    <input style="margin-right: 5px; width: 100px" type="number" name="txtPrice" value="${book.price}"/> 
                                                    <strong class="fw-bold">USD</strong>

                                                </span>
                                                <c:set var="errorPrice" value="${requestScope.ERROR_PRICE}" scope="request"/>
                                                <c:if test="${not empty errorPrice}">
                                                    <p style="color: red">${errorPrice}</p>
                                                    <c:set var="errorPrice" value=""/>
                                                </c:if>

                                                <c:set var="emptyPrice" value="${requestScope.EMPTY_PRICE}" scope="request"/>
                                                <c:if test="${not empty emptyPrice}">
                                                    <p style="color: red">${emptyPrice}</p>
                                                    <c:set var="emptyPrice" value=""/>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="pl-0 w-25" scope="row"><strong>Quantity:</strong></th>
                                            <td>
                                                <input style="width: 100px" type="number" name="txtQuantity" value="${book.quantity}"/>

                                                <c:set var="errorQuantity" value="${requestScope.ERROR_QUANTITY}" scope="request"/>
                                                <c:if test="${not empty errorQuantity}">
                                                    <p style="color: red">${errorQuantity}</p>
                                                    <c:set var="errorQuantity" value=""/>
                                                </c:if>

                                                <c:set var="emptyQuantity" value="${requestScope.EMPTY_QUANTITY}" scope="request"/>
                                                <c:if test="${not empty emptyQuantity}">
                                                    <p style="color: red">${emptyQuantity}</p>
                                                    <c:set var="emptyQuantity" value=""/>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <button type="submit" class="btn btn-success btn-md mr-1 mb-2">Update</button>
                        </div>
                    </div>
                </form>


            </section>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </body>
</html>
