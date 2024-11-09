package model;
import model.EBookStatus;
import java.time.LocalDate;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@ToString(exclude = "shelf")
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "books")
public class Book {

    public Book(EBookStatus status, Integer edition, String ISBNCode, LocalDate publicationYear, String publisher,
            String title, Shelf shelf) {
        this.status = status;
        this.edition = edition;
        this.ISBNCode = ISBNCode;
        this.publicationYear = publicationYear;
        this.publisher = publisher;
        this.title = title;
        this.shelf = shelf;
    }

    @Id
    private String id = UUID.randomUUID().toString();

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private EBookStatus status;

    @Column(name = "edition")
    private Integer edition;

    @Column(name = "isbn_code")
    private String ISBNCode;

    @Column(name = "publication_year")
    private LocalDate publicationYear;

    @Column(name = "publisher")
    private String publisher;

    @Column(name = "title")
    private String title;

    @ManyToOne
    @JoinColumn(name = "shelf_id")
    private Shelf shelf;

	
    
    

}
