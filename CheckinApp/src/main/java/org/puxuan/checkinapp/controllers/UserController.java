package org.puxuan.checkinapp.controllers;


import org.puxuan.checkinapp.dtos.UserDto;
import org.puxuan.checkinapp.entities.User;
import org.puxuan.checkinapp.mappers.UserMapper;
import org.puxuan.checkinapp.repository.UserRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserController(UserRepository userRepository,
                          UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }


    @GetMapping("/find/{username}")
    public List<UserDto> findUserByUserName(@PathVariable String username) {
        return userRepository.findByUserName(username).stream().map(userMapper::toDto).collect(Collectors.toList());
    }

    @PostMapping("/signup")
    public boolean addUser(@RequestBody UserDto userDto) {
        try {
            User user = new User();
            user.setUserName(userDto.getUserName());
            user.setPassword(userDto.getPassword());
            user.setId(new Random().nextLong());

            if (userRepository.findByUserName(userDto.getUserName()).size() > 0) {
                return false;
            }
            userRepository.save(user);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @PostMapping("/login")
    public boolean login(@RequestBody UserDto userDto) {
        List<User> users = userRepository.findByUserName(userDto.getUserName());
        if (users.isEmpty()) {
            return false;
        }
        return users.get(0).getPassword().equals(userDto.getPassword());
    }

    @GetMapping("/random_number")
    public int getRandomNumber() {
        return new Random().nextInt(6) + 1;
    }
}
