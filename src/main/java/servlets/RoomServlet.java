package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Room;
import model.Shelf;
import dao.RoomDAO;

public class RoomServlet extends HttpServlet {

    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                Room room = roomDAO.findById(id);
                request.setAttribute("room", room);
                request.getRequestDispatcher("edit-room.jsp").forward(request, response);
            } else {
                List<Room> rooms = roomDAO.findAll();
                // Calculate total books and store separately
                int[] totalBooksArray = new int[rooms.size()];
                for (int i = 0; i < rooms.size(); i++) {
                    Room room = rooms.get(i);
                    int totalBooks = 0;
                    for (Shelf shelf : room.getShelves()) {
                        totalBooks += shelf.getBooks().size();
                    }
                    totalBooksArray[i] = totalBooks;
                }
                request.setAttribute("rooms", rooms);
                request.setAttribute("totalBooks", totalBooksArray);
                request.getRequestDispatcher("room.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading rooms: " + e.getMessage());
            request.getRequestDispatcher("room.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                String roomId = request.getParameter("roomId");
                roomDAO.delete(roomId);
                response.sendRedirect("room_servlet");
                return;
            } else if (action == null || "create".equals(action) || "update".equals(action)) {
                String roomCode = request.getParameter("roomCode");
                String id = request.getParameter("id");

                Room room = new Room(roomCode);
                if (id != null && !id.isEmpty()) {
                    room.setId(id);
                    roomDAO.updateRoom(room);
                } else {
                    roomDAO.addRoom(room);
                }
                response.sendRedirect("room_servlet");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error processing room: " + e.getMessage());
            doGet(request, response);
        }
    }
}
