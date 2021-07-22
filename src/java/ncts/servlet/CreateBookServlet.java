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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ncts.dao.BookDAO;
import ncts.dto.BookDTO;

/**
 *
 * @author WIN 10
 */
public class CreateBookServlet extends HttpServlet {

    private final String CREATE_BOOK_PAGE = "createPage";

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

        String title = request.getParameter("txtTitle");
        String urlImg = request.getParameter("urlImg");
        String price = request.getParameter("txtPrice");
        String quantity = request.getParameter("txtQuantity");
        String author = request.getParameter("txtAuthor");
        String description = request.getParameter("txtDescription");
        String category = request.getParameter("cboCategory");

        String source = null;

        try {
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

            if (urlImg.equals("")) {
                request.setAttribute("EMPTY_IMG", "Please select image of book !");
                error++;
            }

            if (error > 0) {
                source = CREATE_BOOK_PAGE;
            } else {
                String idBook = UUID.randomUUID().toString();
                String status = "active";
                String importDate = java.time.LocalDate.now().toString();

                BookDTO dto = new BookDTO(idBook, title, urlImg, Integer.parseInt(price), Integer.parseInt(quantity), author, importDate, category, status, description);
                BookDAO bookDAO = new BookDAO();
                boolean check = bookDAO.createBook(dto);
                if (check) {
                    source = "";
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
