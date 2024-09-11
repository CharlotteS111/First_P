package org.puxuan.checkinapp.repository;

import org.puxuan.checkinapp.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByUserName(String userName);

}
