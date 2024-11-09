package servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import dao.ShelfDAO;
import model.Book;
import model.EBookStatus;
import model.Shelf;

public class BookServlet extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();
    private ShelfDAO shelfDAO = new ShelfDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Shelf> shelves = shelfDAO.findAll();
            List<Book> books = bookDAO.findAll();

            request.setAttribute("shelves", shelves);
            request.setAttribute("books", books);
            request.getRequestDispatcher("book.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading data: " + e.getMessage());
            request.getRequestDispatcher("book.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String shelfId = request.getParameter("shelfId");
            Shelf shelf = shelfDAO.findById(shelfId);

            if (shelf == null) {
                throw new Exception("Shelf not found");
            }

            // Check if shelf has available space
            if (shelf.getAvailableStock() <= 0) {
                throw new Exception("Shelf is full");
            }

            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setPublisher(request.getParameter("author"));
            book.setISBNCode(request.getParameter("isbn"));
            book.setPublicationYear(LocalDate.of(Integer.parseInt(request.getParameter("publicationYear")), 1, 1));
            book.setShelf(shelf);
            book.setStatus(EBookStatus.AVAILABLE);

            Book addedBook = bookDAO.addBook(book);
            System.out.println(addedBook);

            // Update shelf available stock
            shelf.setAvailableStock(shelf.getAvailableStock() - 1);
            shelfDAO.updateShelf(shelf);

            request.setAttribute("success", "Book added successfully");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error adding book: " + e.getMessage());
            doGet(request, response);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookId = request.getParameter("id");
            Book book = bookDAO.findById(bookId);

            if (book != null && book.getShelf() != null) {
                // Update shelf available stock before deleting book
                Shelf shelf = book.getShelf();
                shelf.setAvailableStock(shelf.getAvailableStock() + 1);
                shelfDAO.updateShelf(shelf);
            }

            bookDAO.deleteBook(bookId);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting book: " + e.getMessage());
        }
    }
}
