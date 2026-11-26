package vn.hcmute.springboot4.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.hcmute.springboot4.entity.User;

import java.util.Optional;

public interface UserService {

    User login(String username, String password);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    User save(User user);

    Optional<User> findById(Long id);

    Optional<User> findByUsername(String username);

    void deleteById(Long id);

    Page<User> findAll(Pageable pageable);

    Page<User> search(String keyword, Pageable pageable);

    long count();
}
