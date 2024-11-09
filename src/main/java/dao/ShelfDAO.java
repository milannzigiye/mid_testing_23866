package dao;

import java.util.List;

import org.hibernate.Session;

import model.Shelf;

public class ShelfDAO {

    public Shelf addShelf(Shelf shelf) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(shelf);
            session.getTransaction().commit();
            return shelf;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateShelf(Shelf shelf) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.merge(shelf);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Shelf> findByRoomId(String roomId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            String hql = "FROM Shelf s WHERE s.room.id = :room_id";
            return session.createQuery(hql, Shelf.class)
                    .setParameter("room_id", roomId)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Shelf findById(String shelfId) throws Exception {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Shelf.class, shelfId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void deleteShelf(String shelfId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            Shelf shelf = session.get(Shelf.class, shelfId);
            if (shelf != null) {
                session.delete(shelf);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Shelf> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Shelf", Shelf.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
