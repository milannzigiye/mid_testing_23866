package model;

import java.util.UUID;
import javax.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "locations")
public class Location {

    @Id
    @Column(name = "location_id")
    private String id = UUID.randomUUID().toString();

    @Column(name = "location_name")
    private String locationName;

    @Column(name = "location_code")
    private String locationCode;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Location parent;

    @Column(name = "location_type")
    @Enumerated(EnumType.STRING)
    private ELocationType locationType;
}
