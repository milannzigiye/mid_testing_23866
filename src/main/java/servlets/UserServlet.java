package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = new UserDAO();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<User> users = userDAO.findAll();
            System.out.println("Number of users found: " + (users != null ? users.size() : "null"));
            if (users == null || users.isEmpty()) {
                System.out.println("No users found in database");
            }
            request.setAttribute("users", users);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in UserServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching users: " + e.getMessage());
        }
    }
}
