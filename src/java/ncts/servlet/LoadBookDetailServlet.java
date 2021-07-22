/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ncts.dao.BookDAO;
import ncts.dto.BookDTO;
import ncts.dto.UserDTO;

/**
 *
 * @author WIN 10
 */
public class LoadBookDetailServlet extends HttpServlet {

    private final String DETAIL_PAGE = "bookDetail.jsp";
    private final String DETAIL_PAGE_ADMIN = "bookDetailAdmin.jsp";
    private final String UPDATE_BOOK_PAGE = "updateBook.jsp";

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
        String idBook = request.getParameter("txtId");
        String url = null;
        try {
            HttpSession session = request.getSession();
            BookDAO bookDAO = new BookDAO();
            BookDTO book = bookDAO.getBookDetail(idBook);
            session.setAttribute("BOOK_DETAIL", book);

            UserDTO user = (UserDTO) session.getAttribute("USER");
            if (user != null) {
                String role = user.getRole();
                if (user.getRole().equals("R1")) {
                    String viewDetail = request.getParameter("viewDetail");
                    if (viewDetail != null) {
                        url = DETAIL_PAGE_ADMIN;
                    } else {
                        url = UPDATE_BOOK_PAGE;
                    }
                } else {
                    session.setAttribute("BEING_IN_DETAIL_PAGE", "bookDetail.jsp");
                    url = DETAIL_PAGE;
                }
            } else {
                session.setAttribute("BEING_IN_DETAIL_PAGE", "bookDetail.jsp");
                url = DETAIL_PAGE;
            }

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
