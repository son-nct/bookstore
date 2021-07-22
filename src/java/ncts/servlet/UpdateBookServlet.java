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
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
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
public class UpdateBookServlet extends HttpServlet {

    private final String ADMIN_PAGE = "adminPage";
    private final String UPDATE_BOOK_PAGE = "updatePage";

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

        Map<String, String> siteMap = (Map<String, String>) request.getServletContext().getAttribute("SITEMAP");

        String idBook = request.getParameter("txtIdBook");
        String title = request.getParameter("txtTitle");
        String author = request.getParameter("txtAuthor");
        String description = request.getParameter("txtDescription");
        String category = request.getParameter("cboCategory");
        String price = request.getParameter("txtPrice");
        String quantity = request.getParameter("txtQuantity");
        String urlImg = request.getParameter("urlImg");

        String source = null;
        try {
            HttpSession session = request.getSession();
            BookDAO bookDAO = new BookDAO();

            String today = java.time.LocalDate.now().toString();

            int error = 0;

            if (title.length() == 0) {
                request.setAttribute("EMPTY_TITLE", "Please input book's title !");
                error++;
            }

            if (author.length() == 0) {
                request.setAttribute("EMPTY_AUTHOR", "Please input author of book !");
                error++;
            }

            if (price.equals("")) {
                request.setAttribute("EMPTY_PRICE", "Please input positive number !");
                error++;
            } else {
                if (Integer.parseInt(price) < 0) {
                    request.setAttribute("ERROR_PRICE", "Please input positive number !");
                    error++;
                }
            }

            if (quantity.equals("")) {
                request.setAttribute("EMPTY_QUANTITY", "Please input positive number !");
                error++;
            } else {
                if (Integer.parseInt(quantity) < 0) {
                    request.setAttribute("ERROR_QUANTITY", "Please input positive number !");
                    error++;
                }
            }

            if (error > 0) {
                source = UPDATE_BOOK_PAGE;
            } else {

                BookDTO bookUpdated = new BookDTO(idBook, title, urlImg, Integer.parseInt(price), Integer.parseInt(quantity), author, today, category, description);

                boolean check = bookDAO.updateBook(bookUpdated);

                if (check) {

                    String idCategory = (String) session.getAttribute("CATEGORY_VALUE");

                    if (idCategory == null || idCategory.equals("All")) {
                        idCategory = "";
                    }

                    String idRange = (String) session.getAttribute("RANGE_VALUE");
                    if (idRange == null) {
                        idRange = "pr01";
                    }

                    String searchValue = (String) session.getAttribute("SEARCH_VALUE");

                    if (searchValue == null) {
                        searchValue = "";
                    }

                    int priceFrom = 0;
                    int priceTo = 0;

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

                    source = ADMIN_PAGE;
                }
            }

        } catch (SQLException e) {
            log("Have error with database...", e.getCause());
        } catch (NamingException e) {
            log("Couldn't find the datasource", e.getCause());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(siteMap.get(source));
            rd.forward(request, response);
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
