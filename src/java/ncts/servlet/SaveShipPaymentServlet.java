/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;
import java.util.UUID;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ncts.dao.BookDAO;
import ncts.dao.CartObject;
import ncts.dao.OrderDAO;
import ncts.dto.BookDTO;
import ncts.dto.OrderDTO;
import ncts.dto.OrderDetailDTO;
import ncts.dto.UserDTO;

/**
 *
 * @author WIN 10
 */
public class SaveShipPaymentServlet extends HttpServlet {

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
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            BookDAO bookDAO = new BookDAO();
            OrderDAO orderDAO = new OrderDAO();

            CartObject cart = (CartObject) session.getAttribute("CART");
            if (cart != null) {

                UserDTO user = (UserDTO) session.getAttribute("USER");
                String username = user.getUsername();
                String idOrder = UUID.randomUUID().toString();
                String dateOrder = java.time.LocalDate.now().toString();
                int totalMoney = Integer.parseInt(request.getParameter("totalMoney"));
                String methodPayment = "Ship COD";
                OrderDTO order = new OrderDTO(idOrder, username, dateOrder, totalMoney, methodPayment);
                boolean insertOrder = orderDAO.createOrder(order);

                Map<BookDTO, Integer> items = cart.getItems();
                for (BookDTO bookDTO : items.keySet()) {
                    if (insertOrder) {
                        String idDetail = UUID.randomUUID().toString();
                        String idBook = bookDTO.getIdBook();
                        int amount = items.get(bookDTO);
                        OrderDetailDTO detail = new OrderDetailDTO(idDetail, idOrder, idBook, amount);
                        boolean insertDetail = orderDAO.createOrderDetail(detail);
                        if (insertDetail) {
                            int remainingQuantity = bookDTO.getQuantity() - amount;
                            bookDAO.updateQuantity(idBook, remainingQuantity);
                        }
                    }
                }
                session.removeAttribute("CART");
                session.removeAttribute("NUMBER_ITEMS");
                session.removeAttribute("ITEMS");

            }
        } catch (SQLException e) {
            log("Have error with database...", e.getCause());
        } catch (NamingException e) {
            log("Couldn't find the datasource", e.getCause());
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
