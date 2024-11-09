package model;

import java.time.LocalDate;
import java.util.UUID;

import javax.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "memberships")
public class Membership {

    @Id
    @Column(name = "membership_id")
    private String id = UUID.randomUUID().toString();

    @Column(name = "expiring_date")
    private LocalDate expiringDate;

    @Column(name = "membership_code")
    private String membershipCode;

    @ManyToOne
    @JoinColumn(name = "membership_type_id")
    private MembershipType membershipType;

    @Column(name = "membership_status")
    @Enumerated(EnumType.STRING)
    private EMembershipStatus membershipStatus;

    @Column(name = "registration_date")
    private LocalDate registrationDate;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
