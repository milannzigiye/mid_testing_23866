package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Shelf;
import model.Room;
import dao.ShelfDAO;
import dao.RoomDAO;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/shelf")
public class ShelfServlet extends HttpServlet {

    private ShelfDAO shelfDAO = new ShelfDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("edit".equals(action)) {
                // Load shelf for editing
                String shelfId = request.getParameter("id");
                Shelf shelf = shelfDAO.findById(shelfId);
                request.setAttribute("editShelf", shelf);
            }

            // Load rooms and shelves for display
            List<Room> rooms = roomDAO.findAll();
            List<Shelf> shelves = shelfDAO.findAll();

            request.setAttribute("rooms", rooms);
            request.setAttribute("shelves", shelves);
            request.getRequestDispatcher("shelf.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error loading data: " + e.getMessage());
            request.getRequestDispatcher("shelf.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("update".equals(action)) {
                // Handle update
                String shelfId = request.getParameter("id");
                Shelf shelf = shelfDAO.findById(shelfId);
                updateShelfFromRequest(shelf, request);
                shelfDAO.updateShelf(shelf);
                request.setAttribute("success", "Shelf updated successfully");
            } else {
                // Handle create
                Shelf shelf = new Shelf();
                updateShelfFromRequest(shelf, request);
                shelfDAO.addShelf(shelf);
                request.setAttribute("success", "Shelf added successfully");
            }

            response.sendRedirect("shelf");
        } catch (Exception e) {
            request.setAttribute("error", "Error processing shelf: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void updateShelfFromRequest(Shelf shelf, HttpServletRequest request) throws Exception {
        String roomId = request.getParameter("roomId");
        Room room = roomDAO.findById(roomId);

        if (room == null) {
            throw new Exception("Room not found");
        }

        shelf.setName(request.getParameter("name"));
        shelf.setBookCategory(request.getParameter("bookCategory"));
        shelf.setInitialStock(Integer.parseInt(request.getParameter("initialStock")));
        shelf.setAvailableStock(shelf.getInitialStock());
        shelf.setRoom(room);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String shelfId = request.getParameter("id");
            shelfDAO.deleteShelf(shelfId);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting shelf: " + e.getMessage());
        }
    }
}
