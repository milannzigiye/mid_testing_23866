package dao;

import org.hibernate.Session;

import model.Location;

public class LocationDAO {

    public void addLocation(Location location) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(location);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Location findById(String id) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Location.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
