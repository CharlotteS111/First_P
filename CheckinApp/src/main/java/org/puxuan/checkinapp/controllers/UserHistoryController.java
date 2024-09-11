package org.puxuan.checkinapp.controllers;

import org.puxuan.checkinapp.dtos.UserHistoryDto;
import org.puxuan.checkinapp.entities.UserHistory;
import org.puxuan.checkinapp.mappers.UserHistoryMapper;
import org.puxuan.checkinapp.repository.UserHistoryRepository;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user-history")
@CrossOrigin
public class UserHistoryController {

    private final UserHistoryRepository userHistoryRepository;
    private final UserHistoryMapper userHistoryMapper;

    public UserHistoryController(UserHistoryRepository userHistoryRepository,
                                 UserHistoryMapper userHistoryMapper) {
        this.userHistoryRepository = userHistoryRepository;
        this.userHistoryMapper = userHistoryMapper;
    }

    @PostMapping("/add")
    public boolean addUserHistory(@RequestBody UserHistoryDto userHistoryDto) {
        // convert dto to entity
        UserHistory entity = new UserHistory();
        entity.setUserName(userHistoryDto.getUserName());
        entity.setTime(userHistoryDto.getTime());
        entity.setLocation(userHistoryDto.getLocation());
        entity.setWeather(userHistoryDto.getWeather());
        entity.setId(new Random().nextLong());

        userHistoryRepository.save(entity);
        return true;
    }

    @GetMapping("/find/{username}")
    public List<UserHistoryDto> findUserHistoryByUserName(@PathVariable String username) {
        List<UserHistory> byUserName = userHistoryRepository.findByUserName(username);

        List<UserHistoryDto> collect = new ArrayList<>();
        for (UserHistory userHistory : byUserName) {
            UserHistoryDto userHistoryDto = new UserHistoryDto(userHistory.getUserName(), userHistory.getTime(), userHistory.getLocation(), userHistory.getWeather());
            collect.add(userHistoryDto);
        }
        return collect;
//        return userHistoryRepository.findByUserName(username).stream().map(userHistoryMapper::toDto).collect(Collectors.toList());
    }


}
