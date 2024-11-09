package model;

import java.util.List;
import java.util.UUID;

import javax.persistence.*;

import lombok.*;

@Entity
@Table(name = "users")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(exclude = { "memberships", "village" })
@NoArgsConstructor
@AllArgsConstructor
public class User extends Person {

    @Id
    private String id = UUID.randomUUID().toString();

    @Column(name = "user_name")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "role")
    @Enumerated(EnumType.STRING)
    private ERole role = ERole.STUDENT;

    @ManyToOne
    @JoinColumn(name = "village_id")
    private Location village;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private List<Membership> memberships;
    
    

}
