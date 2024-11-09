package model;

import java.util.UUID;
import javax.persistence.*;
import lombok.*;

@Entity
@Table(name = "membership_types")
@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class MembershipType {

    public MembershipType(String name, Integer maxBooks, Integer price) {
        this.name = name;
        this.price = price;
        this.maxBooks = maxBooks;
    }

    @Id
    @Column(name = "membership_type_id")
    private String id = UUID.randomUUID().toString();

    @Column(name = "max_books")
    private Integer maxBooks;

    @Column(name = "membership_type_name")
    private String name;

    @Column(name = "price")
    private Integer price;
}
