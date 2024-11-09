package model;

import java.time.LocalDate;
import java.util.UUID;

import javax.persistence.*;
import lombok.*;



@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "borrowers")
public class Borrower {

    @Builder
    public Borrower(LocalDate dueDate, Book book, LocalDate pickDate, Integer fine, Integer lateChargeFees, User user) {
        this.dueDate = dueDate;
        this.book = book;
        this.pickDate = pickDate;
        this.fine = fine;
        this.lateChargeFees = lateChargeFees;
        this.user = user;
    }

    @Id
    private String id = UUID.randomUUID().toString();

    @Column(name = "due_date")
    private LocalDate dueDate;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Column(name = "pick_date")
    private LocalDate pickDate;

    @Column(name = "fine")
    @Builder.Default
    private Integer fine = 0;

    @Column(name = "late_charge_fees")
    @Builder.Default
    private Integer lateChargeFees = 0;

    @ManyToOne
    @JoinColumn(name = "reader_id")
    private User user;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public LocalDate getDueDate() {
		return dueDate;
	}

	public void setDueDate(LocalDate dueDate) {
		this.dueDate = dueDate;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public LocalDate getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(LocalDate returnDate) {
		this.returnDate = returnDate;
	}

	public LocalDate getPickDate() {
		return pickDate;
	}

	public void setPickDate(LocalDate pickDate) {
		this.pickDate = pickDate;
	}

	public Integer getFine() {
		return fine;
	}

	public void setFine(Integer fine) {
		this.fine = fine;
	}

	public Integer getLateChargeFees() {
		return lateChargeFees;
	}

	public void setLateChargeFees(Integer lateChargeFees) {
		this.lateChargeFees = lateChargeFees;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
    
    
}
