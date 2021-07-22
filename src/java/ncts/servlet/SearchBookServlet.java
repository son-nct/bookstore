/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ncts.dao.BookDAO;
import ncts.dto.BookDTO;

/**
 *
 * @author WIN 10
 */
public class SearchBookServlet extends HttpServlet {

    private final String SHOP_PAGE = "shop.jsp";

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

        String idCategory = request.getParameter("cboCategory");
        String idRange = request.getParameter("cboRange");
        String searchValue = request.getParameter("txtSearch");
        int priceFrom = 0;
        int priceTo = 0;

        String url = null;
        try {
            HttpSession session = request.getSession();
            BookDAO bookDAO = new BookDAO();

            switch (idRange) {
                case "pr02":
                    priceFrom = 5;
                    priceTo = 50;
                    break;
                case "pr03":
                    priceFrom = 50;
                    priceTo = 100;
                    break;
                case "pr04":
                    priceFrom = 100;
                    priceTo = 0;
                    break;
            }

            if (idRange.equals("pr01")) {
                List<BookDTO> listBook = bookDAO.getListBookWithoutRange(idCategory, searchValue);
                session.setAttribute("LIST_BOOK", listBook);
            } else {
                List<BookDTO> listBook = bookDAO.getListBookInRange(idCategory, searchValue, priceFrom, priceTo);
                session.setAttribute("LIST_BOOK", listBook);
            }

            if (idCategory.equals("")) {
                idCategory = "All";
            }

            session.setAttribute("CATEGORY_VALUE", idCategory);
            session.setAttribute("RANGE_VALUE", idRange);
            session.setAttribute("SEARCH_VALUE", searchValue);

            url = SHOP_PAGE;

        } catch (SQLException e) {
            log("Have error with database...", e.getCause());
        } catch (NamingException e) {
            log("Couldn't find the datasource", e.getCause());
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
