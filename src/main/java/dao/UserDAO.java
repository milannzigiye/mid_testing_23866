package dao;

import java.util.List;

import org.hibernate.Session;

import model.User;

public class UserDAO {

    public void addUser(User user) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(user);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<User> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            List<User> users = session.createQuery("SELECT u FROM User u", User.class).getResultList();
            session.getTransaction().commit();
            return users;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public User findByUsername(String username) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM User WHERE username = :username", User.class)
                    .setParameter("username", username)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public User findByPhoneNumber(String phoneNumber) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM User WHERE phoneNumber = :phoneNumber", User.class)
                    .setParameter("phoneNumber", phoneNumber)
                    .uniqueResult();
        }
    }

    public User findById(String userId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(User.class, userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
