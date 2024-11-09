package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import model.Book;
import dao.BookDAO;
import model.User;
import dao.UserDAO;
import model.Room;
import dao.RoomDAO;
import model.Shelf;
import dao.ShelfDAO;

public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        List<Book> books = bookDAO.findAll();

        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.findAll();

        RoomDAO roomDAO = new RoomDAO();
        List<Room> rooms = roomDAO.findAll();

        ShelfDAO shelfDAO = new ShelfDAO();
        List<Shelf> shelves = shelfDAO.findAll();

        request.setAttribute("books", books);
        request.setAttribute("users", users);
        request.setAttribute("rooms", rooms);
        request.setAttribute("shelves", shelves);
        request.getRequestDispatcher("/report.jsp").forward(request, response);
    }
}
