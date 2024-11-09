package servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import java.io.IOException;

public class LocationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneNumber = request.getParameter("phoneNumber");
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByPhoneNumber(phoneNumber);
            request.setAttribute("province",
                    user.getVillage().getParent().getParent().getParent().getParent().getLocationName());
        }

        request.getRequestDispatcher("location_result.jsp").forward(request, response);
    }
}
