package dao;

import java.util.List;

import org.hibernate.Session;
import model.Room;

public class RoomDAO {

    public Room addRoom(Room room) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(room);
            session.getTransaction().commit();
            return room;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public Room findByCode(String roomCode) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Room WHERE roomCode = :roomCode", Room.class)
                    .setParameter("roomCode", roomCode)
                    .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Room> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Room", Room.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Room findById(String roomId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Room.class, roomId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateRoom(Room room) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.update(room);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(String roomId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            Room room = session.get(Room.class, roomId);
            if (room != null) {
                session.delete(room);
            }
        }
    }
}
