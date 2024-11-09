package dao;

import org.hibernate.Session;

import model.MembershipType;

import java.util.List;

public class MembershipTypeDAO {
    public MembershipType addMembershipType(MembershipType membershipType) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(membershipType);
            session.getTransaction().commit();
            return membershipType;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<MembershipType> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("from MembershipType", MembershipType.class).getResultList();
        }
    }

    public MembershipType findById(String id) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(MembershipType.class, id);
        }
    }

    public void updateMembershipType(MembershipType membershipType) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.update(membershipType);
            session.getTransaction().commit();
        }
    }

    public void deleteMembershipType(int id) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            MembershipType membershipType = session.get(MembershipType.class, id);
            session.delete(membershipType);
            session.getTransaction().commit();
        }
    }
}
