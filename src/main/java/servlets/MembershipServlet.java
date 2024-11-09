package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MembershipDAO;
import model.EMembershipStatus;
import model.Membership;

public class MembershipServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MembershipDAO membershipDAO = new MembershipDAO();
        List<Membership> memberships = membershipDAO.findAll();
        request.setAttribute("members", memberships);
        request.getRequestDispatcher("members.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("memberId");
        String newStatus = request.getParameter("newStatus");
        MembershipDAO membershipDAO = new MembershipDAO();
        Membership membership = membershipDAO.findById(memberId);
        membership.setMembershipStatus(EMembershipStatus.valueOf(newStatus));

        membershipDAO.updateMembership(membership);
        response.sendRedirect("membership_servlet");
    }

}
