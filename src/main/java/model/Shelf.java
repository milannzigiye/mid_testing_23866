package model;

import java.util.List;
import java.util.UUID;

import javax.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "shelves")
@ToString(exclude = {"room", "books"})
public class Shelf {

    public Shelf(String name, Integer availableStock, String bookCategory, Integer initialStock, Room room) {
        this.name = name;
        this.availableStock = availableStock;
        this.bookCategory = bookCategory;
        this.initialStock = initialStock;
        this.room = room;
    }

    @Id
    private String id = UUID.randomUUID().toString();

    @Column(name = "name")
    private String name;

    @Column(name = "available_stock")
    private Integer availableStock;

    @Column(name = "book_category")
    private String bookCategory;

    @Column(name = "initial_stock")
    private Integer initialStock;

    @OneToMany(mappedBy = "shelf", fetch = FetchType.EAGER)
    private List<Book> books;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAvailableStock() {
        return availableStock;
    }

    public void setAvailableStock(Integer availableStock) {
        this.availableStock = availableStock;
    }

    public String getBookCategory() {
        return bookCategory;
    }

    public void setBookCategory(String bookCategory) {
        this.bookCategory = bookCategory;
    }

    public Integer getInitialStock() {
        return initialStock;
    }

    public void setInitialStock(Integer initialStock) {
        this.initialStock = initialStock;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

}
