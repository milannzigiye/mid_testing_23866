package dao;

import java.util.List;

import org.hibernate.Session;

import model.Membership;
import model.User;

public class MembershipDAO {

    public List<Membership> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Membership", Membership.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Membership addMembership(Membership membership) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(membership);
            session.getTransaction().commit();
            return membership;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public List<Membership> findByUser(User user) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Membership WHERE user = :user", Membership.class)
                    .setParameter("user", user)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateMembership(Membership membership) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.update(membership);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Membership findById(String membershipId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Membership.class, membershipId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
