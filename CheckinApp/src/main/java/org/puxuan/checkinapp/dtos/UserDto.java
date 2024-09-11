package org.puxuan.checkinapp.dtos;

import lombok.Value;

import java.io.Serializable;

/**
 * DTO for {@link org.puxuan.checkinapp.entities.User}
 */
@Value
public class UserDto implements Serializable {
    String userName;
    String password;

    public UserDto(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }
}
