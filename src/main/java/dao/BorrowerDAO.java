package dao;

import java.util.List;

import org.hibernate.Session;

import model.Borrower;
import model.User;

public class BorrowerDAO {
    public Borrower addBorrower(Borrower borrower) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(borrower);
            session.getTransaction().commit();
            return borrower;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Borrower> findByUser(User user) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            List<Borrower> borrowers = session.createQuery("FROM Borrower WHERE user = :user", Borrower.class)
                    .setParameter("user", user)
                    .getResultList();
            session.getTransaction().commit();
            return borrowers;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Borrower findById(String id) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Borrower.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Borrower updateBorrower(Borrower borrower) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.merge(borrower);
            session.getTransaction().commit();
            return borrower;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
