package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MembershipTypeDAO;
import model.MembershipType;

public class MembershipTypeServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MembershipTypeDAO membershipTypeDAO = new MembershipTypeDAO();
        List<MembershipType> membershipTypes = membershipTypeDAO.findAll();
        request.setAttribute("membershipTypes", membershipTypes);
        request.getRequestDispatcher("membership_type.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        Integer maxBooks = Integer.parseInt(request.getParameter("maxBooks"));
        Integer price = Integer.parseInt(request.getParameter("price"));

        MembershipTypeDAO membershipTypeDAO = new MembershipTypeDAO();
        MembershipType membershipType = new MembershipType(name, maxBooks, price);

        switch (action) {
            case "create":
                membershipTypeDAO.addMembershipType(membershipType);
                break;
            case "update":
                membershipType.setId(id);
                membershipTypeDAO.updateMembershipType(membershipType);
                break;
            case "delete":
                membershipTypeDAO.deleteMembershipType(Integer.parseInt(id));
                break;
        }

        response.sendRedirect("membership_type");
    }
}
// Compare this snippet from src/main/java/servlets/RoomServlet.java:
