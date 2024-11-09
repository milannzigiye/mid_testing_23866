package dao;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;

import model.Book;
import model.Borrower;
import model.Location;
import model.Membership;
import model.MembershipType;
import model.Room;
import model.Shelf;
import model.User;

public class HibernateUtil {

    private static SessionFactory sessionFactory = null;

    public static SessionFactory getSession() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();

                Properties property = new Properties();

                // Database connection settings
                property.put(Environment.DRIVER, "org.postgresql.Driver");
                property.put(Environment.URL, "jdbc:postgresql://localhost:5432/auca_library_db");
                property.put(Environment.USER, "postgres");
                property.put(Environment.PASS, "54564");
                property.put(Environment.SHOW_SQL, true);
                property.put(Environment.HBM2DDL_AUTO, "update");

                configuration.addProperties(property);

                configuration.addAnnotatedClass(Membership.class);
                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(Book.class);
                configuration.addAnnotatedClass(Shelf.class);
                configuration.addAnnotatedClass(Room.class);
                configuration.addAnnotatedClass(Borrower.class);
                configuration.addAnnotatedClass(Location.class);
                configuration.addAnnotatedClass(MembershipType.class);

                sessionFactory = configuration.buildSessionFactory();
                return sessionFactory;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else {
            return sessionFactory;
        }
    }
}
