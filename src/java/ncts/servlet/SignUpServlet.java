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
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ncts.dao.UserDAO;
import ncts.dto.UserDTO;

/**
 *
 * @author WIN 10
 */
public class SignUpServlet extends HttpServlet {

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

        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String rePassword = request.getParameter("txtRepassword");

        String fullname = request.getParameter("txtFullname");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");
        String address = request.getParameter("txtAddress");

        String source = null;

        try {
            int error = 0;
            UserDAO userDAO = new UserDAO();

            String username_exit = userDAO.checkUsername(username);
            if ((username.length() > 0) && username_exit != null) {
                String exit_user = "username is already exist. Try again !";
                request.setAttribute("exit_user", exit_user);
                error++;
            }

            if (username.length() == 0) {
                String empty_username = "Please input your Email !";
                request.setAttribute("empty_username", empty_username);
                error++;
            }

            if (email.length() == 0) {
                String empty_email = "Please input your Email !";
                request.setAttribute("empty_email", empty_email);
                error++;
            }
            if (!email.matches("^[A-Za-z][\\w-]+@([\\w]+\\.[\\w]+|[\\w]+\\.[\\w]{2,}\\.[\\w]{2,})$")) {
                String invalid_email = "Not valid email. Try again !";
                request.setAttribute("invalid_email", invalid_email);
                error++;
            }

            if (password.length() == 0) {
                request.setAttribute("empty_password", "Please input your password !");
                error++;
            }

            if (!rePassword.equals(password)) {
                request.setAttribute("not_match", "Password and Repassword not match. Try again!");
                error++;
            }

            if (fullname.length() == 0) {
                request.setAttribute("empty_fullname", "Please input your displayName !");
                error++;
            }

            if (phone.length() == 0) {
                String empty_phone = "Please input your phone number !";
                request.setAttribute("empty_phone", empty_phone);
                error++;
            }

            if (phone.length() >= 1 && !phone.matches("^0\\d{9,11}$")) {
                String error_phone = "Not valid phone number. Try again !";
                request.setAttribute("error_phone", error_phone);
                error++;
            }

            if (address.length() == 0) {
                request.setAttribute("empty_address", "Please input your address !");
                error++;
            }

            if (error > 0) {
                source = "signUpPage";
            } else {
                String role = "R2";
                String status = "active";
                UserDTO dto = new UserDTO(username, password, fullname, email, address, phone, role, status);
                userDAO.registerAccount(dto);
                source = "loginPage";
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
