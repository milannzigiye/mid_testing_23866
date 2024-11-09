package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import dao.BorrowerDAO;
import dao.UserDAO;
import model.Book;
import model.Borrower;
import model.EBookStatus;
import model.User;

public class BorrowerServlet extends HttpServlet {

    private BookDAO bookDAO;
    private BorrowerDAO borrowerDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowerDAO = new BorrowerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("books", bookDAO.findAll());
        request.getRequestDispatcher("list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("borrow")) {
            // Process book borrowing
            String bookId = request.getParameter("bookId");
            String userId = request.getParameter("userId");

            Book book = bookDAO.findById(bookId);
            User user = userDAO.findById(userId);

            Borrower borrower = Borrower.builder()
                    .book(book)
                    .user(user)
                    .pickDate(LocalDate.now())
                    .dueDate(LocalDate.now().plusDays(14))
                    .fine(0)
                    .lateChargeFees(0)
                    .build();

            borrowerDAO.addBorrower(borrower);

            book.setStatus(EBookStatus.BORROWED);
            bookDAO.updateBook(book);

            response.sendRedirect(request.getContextPath() + "/borrow?status=success");
        }
    }
}
