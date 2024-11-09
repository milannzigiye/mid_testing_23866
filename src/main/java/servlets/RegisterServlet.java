package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import static util.Validation.hashPassword;
import dao.LocationDAO;
import dao.UserDAO;
import model.Location;
import model.User;
import model.ELocationType;
import model.EGender;
import model.ERole;

@WebServlet(name = "RegisterServlet", urlPatterns = { "/register_servlet" })
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        // Contact and Location Information
        String phoneNumber = request.getParameter("phoneNumber");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String sector = request.getParameter("sector");
        String cell = request.getParameter("cell");
        String village = request.getParameter("village");

        // Validation checks
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=Username is required");
            return;
        }

        if (username.length() < 3 || username.length() > 50) {
            response.sendRedirect("register.jsp?error=Username must be between 3 and 50 characters");
            return;
        }

        if (password == null || password.length() < 8) {
            response.sendRedirect("register.jsp?error=Password must be at least 8 characters long");
            return;
        }

        if (firstName == null || firstName.trim().isEmpty() || lastName == null || lastName.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=First and last name are required");
            return;
        }

        if (phoneNumber == null || !phoneNumber.matches("^\\d{10}$")) {
            response.sendRedirect("register.jsp?error=Please enter a valid 10-digit phone number");
            return;
        }

        // Location validation
        if (province == null || province.trim().isEmpty()
                || district == null || district.trim().isEmpty()
                || sector == null || sector.trim().isEmpty()
                || cell == null || cell.trim().isEmpty()
                || village == null || village.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=All location fields are required");
            return;
        }

        // Hash the password (using the example from earlier)
        try {
            String hashedPassword = hashPassword(password);

            // Create location hierarchy
            LocationDAO locationDAO = new LocationDAO();

            // Create and save province
            Location provinceObj = new Location();
            provinceObj.setLocationName(province);
            provinceObj.setLocationCode(province.substring(0, 3).toUpperCase());
            provinceObj.setLocationType(ELocationType.PROVINCE);
            provinceObj.setParent(null);
            locationDAO.addLocation(provinceObj);

            // Create and save district
            Location districtObj = new Location();
            districtObj.setLocationName(district);
            districtObj.setLocationCode(district.substring(0, 3).toUpperCase());
            districtObj.setLocationType(ELocationType.DISTRICT);
            districtObj.setParent(provinceObj);
            locationDAO.addLocation(districtObj);

            // Create and save sector
            Location sectorObj = new Location();
            sectorObj.setLocationName(sector);
            sectorObj.setLocationCode(sector.substring(0, 3).toUpperCase());
            sectorObj.setLocationType(ELocationType.SECTOR);
            sectorObj.setParent(districtObj);
            locationDAO.addLocation(sectorObj);

            // Create and save cell
            Location cellObj = new Location();
            cellObj.setLocationName(cell);
            cellObj.setLocationCode(cell.substring(0, 3).toUpperCase());
            cellObj.setLocationType(ELocationType.CELL);
            cellObj.setParent(sectorObj);
            locationDAO.addLocation(cellObj);

            // Create and save village
            Location villageObj = new Location();
            villageObj.setLocationName(village);
            villageObj.setLocationCode(village.substring(0, 3).toUpperCase());
            villageObj.setLocationType(ELocationType.VILLAGE);
            villageObj.setParent(cellObj);
            locationDAO.addLocation(villageObj);

            // Create and save user
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setPhoneNumber(phoneNumber);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setVillage(villageObj);
            user.setGender(EGender.valueOf(gender.toUpperCase()));
            user.setRole(ERole.valueOf(role.toUpperCase()));

            UserDAO userDAO = new UserDAO();
            userDAO.addUser(user);

            response.sendRedirect("login.jsp?message=Registration successful");

        } catch (IllegalArgumentException e) {
            response.sendRedirect("register.jsp?error=Invalid input: " + e.getMessage());
        } catch (Exception e) {
            // Log the actual exception for debugging
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Registration failed: Password hashing error");
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("RegisterServlet initialized!");
    }

}
