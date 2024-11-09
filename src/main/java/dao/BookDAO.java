package dao;

import java.util.List;

import org.hibernate.Session;

import model.Book;

public class BookDAO {
    public Book addBook(Book book) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.persist(book);
            session.getTransaction().commit();
            return book;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Book updateBook(Book book) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.merge(book);
            session.getTransaction().commit();
            return book;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Book> findAll() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("from Book", Book.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Book findById(String bookId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Book.class, bookId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void deleteBook(String bookId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            Book book = session.get(Book.class, bookId);
            if (book != null) {
                session.delete(book);
            }
            session.getTransaction().commit();
        }
    }
}
