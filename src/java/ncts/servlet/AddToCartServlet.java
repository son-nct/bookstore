/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ncts.dao.CartObject;
import ncts.dto.BookDTO;
import ncts.dto.UserDTO;

/**
 *
 * @author WIN 10
 */
public class AddToCartServlet extends HttpServlet {

    private final String SHOP_PAGE = "shop.jsp";
    private final String LOGIN_PAGE = "login.jsp";
    private final String DETAIL_PAGE = "bookDetail.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String urlImg = request.getParameter("urlImg");
        String idBook = request.getParameter("txtIdBook");
        String title = request.getParameter("txtTitle");
        int price = Integer.parseInt(request.getParameter("txtPrice"));
        int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
        String nameCategory = request.getParameter("txtnameCategory");

        String addInDetailPage = request.getParameter("addInDetailPage");
        String amount = request.getParameter("txtAmount");

        String url = null;
        try {
            HttpSession session = request.getSession();

            UserDTO user = (UserDTO) session.getAttribute("USER");

            
            if (addInDetailPage != null && addInDetailPage.equals("true")) {
                session.setAttribute("BEING_IN_DETAIL_PAGE", "bookDetail.jsp");
            }

            if (user == null) {
                url = LOGIN_PAGE;
            } else {

                CartObject cart = (CartObject) session.getAttribute("CART");
                if (cart == null) {
                    cart = new CartObject();
                }

                if (addInDetailPage != null && addInDetailPage.equals("true")) {
                    int error = 0;

                    if (amount.length() == 0) {
                        session.setAttribute("EMPTY_AMOUNT", "Please input quantity !");
                        error++;
                    }

                    if (error > 0) {
                        session.setAttribute("AMOUNT_VALUE", amount);
                        url = DETAIL_PAGE;
                    } else {
                        session.removeAttribute("EMPTY_AMOUNT");

                        BookDTO book = new BookDTO(idBook, title, price, quantity, urlImg, nameCategory);

                        cart.addToCartWithAmount(book, Integer.parseInt(amount));

                        int count = cart.getItems().size();
                        session.setAttribute("NUMBER_ITEMS", count);
                        session.setAttribute("CART", cart);

                        url = SHOP_PAGE;
                    }

                } else {
                    BookDTO book = new BookDTO(idBook, title, price, quantity, urlImg, nameCategory);
                    cart.addToCart(book);

                    int count = cart.getItems().size();
                    session.setAttribute("NUMBER_ITEMS", count);
                    session.setAttribute("CART", cart);

                    url = SHOP_PAGE;
                }

            }

        } finally {
            response.sendRedirect(url);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
