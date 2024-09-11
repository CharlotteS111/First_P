package org.puxuan.checkinapp.repository;

import org.puxuan.checkinapp.entities.UserHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserHistoryRepository extends JpaRepository<UserHistory, Long> {
    List<UserHistory> findByUserName(String userName);
}
