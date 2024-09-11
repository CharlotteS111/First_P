package org.puxuan.checkinapp.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name = "user_history", schema = "public")
public class UserHistory {
    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "user_name")
    private String userName;

    @Column(name = "time")
    private String time;

    @Column(name = "location")
    private String location;

    @Column(name = "weather")
    private String weather;


}
