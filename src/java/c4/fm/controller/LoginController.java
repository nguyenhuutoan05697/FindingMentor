/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package c4.fm.controller;

import c4.fm.dao.UserDAO;
import c4.fm.role.RoleDAO;
import c4.fm.role.RoleDTO;
import c4.fm.user.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MSI
 */
public class LoginController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String ADMIN_PAGE = "LoadAdminServlet";
    private static final String USER_PAGE = "user.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String UserID = request.getParameter("your_name");
            String password = request.getParameter("your_pass");
            UserDAO dao = new UserDAO();
            UserDTO user = dao.checkLogin(UserID, password);
            HttpSession session = request.getSession();
            if (user != null) {
                session.setAttribute("LOGIN_USER", user);
                String RoleID = user.getRoleID();
                if ("AD".equals(RoleID)) {
                    url = ADMIN_PAGE;
                } else if ("US".equals(RoleID)) {
                    RoleDAO roleDao = new RoleDAO();
                    RoleDTO role = roleDao.loadListRole(user.getRoleID());
                    session.setAttribute("USER_ROLE", role);
                    url = USER_PAGE;
                } else if ("MT".equals(RoleID)) {
                    RoleDAO roleDao = new RoleDAO();
                    RoleDTO role = roleDao.loadListRole(user.getRoleID());
                    session.setAttribute("USER_ROLE", role);
                    url = USER_PAGE;
                } else {
                    session.setAttribute("ERROR_MESSAGE", "Your role is not support");
                }
            } else {
                session.setAttribute("ERROR_MESSAGE", "Incorrect UserID or Password");
            }
            System.out.println(request.getParameter("code"));
        } catch (Exception e) {
            log("Error at Login Controller" + e.toString());
        } finally {
            response.sendRedirect(url);
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
