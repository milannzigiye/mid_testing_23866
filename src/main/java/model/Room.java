package model;

import java.util.List;
import java.util.UUID;

import javax.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "rooms")
@ToString(exclude = "shelves")
public class Room {

    public Room(String roomCode) {
        this.roomCode = roomCode;
    }

    @Id
    @Column(name = "room_id")
    private String id = UUID.randomUUID().toString();

    @Column(name = "room_code")
    private String roomCode;

    @OneToMany(mappedBy = "room", fetch = FetchType.EAGER)
    private List<Shelf> shelves;


}
