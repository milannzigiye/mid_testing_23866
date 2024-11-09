package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.ERole;
import model.User;
import util.Validation;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login_servlet" })
public class LoginServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByUsername(username);

            if (user == null) {
                response.sendRedirect("login.jsp?error=Invalid username");
                return;
            }

            Boolean result = Validation.verifyPassword(password, user.getPassword());
            if (!result) {
                response.sendRedirect("login.jsp?error=Invalid password");
                return;
            }
            request.getSession().setAttribute("user", user);
            if (user.getRole() == ERole.STUDENT || user.getRole() == ERole.TEACHER) {
                response.sendRedirect("home");
            } else if (user.getRole() == ERole.MANAGER || user.getRole() == ERole.DEAN || user.getRole() == ERole.HOD) {
                response.sendRedirect("report");
            } else {
                response.sendRedirect("book_servlet");
            }
        } catch (Exception e) {
            response.sendRedirect("login.jsp?error=System error");
        }
    }
}
