package org.puxuan.checkinapp.dtos;

import lombok.Value;

import java.io.Serializable;

/**
 * DTO for {@link org.puxuan.checkinapp.entities.UserHistory}
 */
@Value
public class UserHistoryDto implements Serializable {
    String userName;
    String time;
    String location;
    String weather;

    public UserHistoryDto(String userName, String time, String location, String weather) {
        this.userName = userName;
        this.time = time;
        this.location = location;
        this.weather = weather;
    }
}
