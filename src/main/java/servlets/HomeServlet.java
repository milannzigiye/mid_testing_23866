package servlets;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookDAO;
import dao.BorrowerDAO;
import dao.MembershipDAO;
import model.Book;
import model.Borrower;
import model.Membership;
import model.User;
import model.EMembershipStatus;
import dao.MembershipTypeDAO;
import model.MembershipType;
import model.EBookStatus;
import model.ERole;

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Membership> memberships = null;

        if (user != null) {
            MembershipDAO membershipDAO = new MembershipDAO();
            memberships = membershipDAO.findByUser(user);

            BorrowerDAO borrowerDAO = new BorrowerDAO();
            List<Borrower> borrowers = borrowerDAO.findByUser(user);
            request.setAttribute("userBorrowingTransactions", borrowers);
        }

        // how can i get the membership type name?
        MembershipTypeDAO membershipTypeDAO = new MembershipTypeDAO();
        List<MembershipType> membershipTypes = membershipTypeDAO.findAll();

        List<Book> books = bookDAO.findAll();
        request.setAttribute("books", books);
        request.setAttribute("memberships", memberships);
        request.setAttribute("membershipTypes", membershipTypes);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register_membership".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get the membershipTypeId from the form
            String membershipTypeId = request.getParameter("membershipTypeId");
            System.out.println("Membership Type ID: " + membershipTypeId);
            int duration = Integer.parseInt(request.getParameter("duration"));

            // Get the MembershipType from the database
            MembershipTypeDAO membershipTypeDAO = new MembershipTypeDAO();
            MembershipType membershipType = membershipTypeDAO.findById(membershipTypeId);
            System.out.println("Membership Type: " + membershipType);

            Membership membership = new Membership();
            membership.setUser(user);
            membership.setRegistrationDate(LocalDate.now());
            membership.setExpiringDate(LocalDate.now().plusMonths(duration));
            membership.setMembershipStatus(EMembershipStatus.PENDING);
            membership.setMembershipCode("MEM-" + UUID.randomUUID().toString().substring(0, 5));
            membership.setMembershipType(membershipType);

            MembershipDAO membershipDAO = new MembershipDAO();
            membershipDAO.addMembership(membership);

            response.sendRedirect("home");
        } else if ("borrow_book".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Check if user has appropriate role
            if (user.getRole() != ERole.STUDENT && user.getRole() != ERole.TEACHER) {
                session.setAttribute("errorMessage", "Only Students and Teachers are allowed to borrow books.");
                response.sendRedirect("home");
                return;
            }

            // Check if user has an active membership
            MembershipDAO membershipDAO = new MembershipDAO();
            List<Membership> memberships = membershipDAO.findByUser(user);
            boolean hasActiveMembership = memberships.stream()
                    .anyMatch(m -> m.getMembershipStatus() == EMembershipStatus.APPROVED);

            if (!hasActiveMembership) {
                session.setAttribute("errorMessage", "You need an active membership to borrow books.");
                response.sendRedirect("home");
                return;
            }

            // Check if user hasn't exceeded their book limit
            BorrowerDAO borrowerDAO = new BorrowerDAO();
            List<Borrower> userBorrows = borrowerDAO.findByUser(user);

            int borrowedBooks = userBorrows.size();
            int allowedBooks = memberships.stream()
                    .filter(m -> m.getMembershipStatus() == EMembershipStatus.APPROVED)
                    .mapToInt(m -> m.getMembershipType().getMaxBooks())
                    .sum();

            if (borrowedBooks >= allowedBooks) {
                session.setAttribute("errorMessage",
                        "You have reached your maximum allowed books. Please return some books or upgrade your membership.");
                response.sendRedirect("home");
                return;
            }

            String bookId = request.getParameter("bookId");
            LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));

            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.findById(bookId);

            Borrower borrowing = new Borrower();
            borrowing.setUser(user);
            borrowing.setBook(book);
            borrowing.setDueDate(dueDate);

            BorrowerDAO borrowingDAO = new BorrowerDAO();
            borrowingDAO.addBorrower(borrowing);

            // Update book availability
            book.setStatus(EBookStatus.BORROWED);
            ;
            bookDAO.updateBook(book);

            response.sendRedirect("home");
        } else if ("return_book".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String transactionId = request.getParameter("transactionId");
            BorrowerDAO borrowerDAO = new BorrowerDAO();
            Borrower borrower = borrowerDAO.findById(transactionId);

            if (borrower != null && borrower.getUser().getId().equals(user.getId())) {
                // Set return date
                LocalDate returnDate = LocalDate.now();
                borrower.setReturnDate(returnDate);

                // Calculate late fees if applicable
                if (returnDate.isAfter(borrower.getDueDate())) {
                    long daysLate = java.time.temporal.ChronoUnit.DAYS.between(borrower.getDueDate(), returnDate);
                    Integer lateFee = (int) (daysLate * 100); // 100 RWF per day
                    borrower.setLateChargeFees(lateFee);
                }

                // Update borrower record
                borrowerDAO.updateBorrower(borrower);

                // Update book status
                Book book = borrower.getBook();
                book.setStatus(EBookStatus.AVAILABLE);
                BookDAO bookDAO = new BookDAO();
                bookDAO.updateBook(book);
            }

            response.sendRedirect("home");
        } else {
            doGet(request, response);
        }
    }
}
