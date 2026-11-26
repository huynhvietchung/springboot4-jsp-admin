package vn.hcmute.springboot4.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.hcmute.springboot4.entity.Category;

import java.util.Optional;

public interface CategoryService {

    Page<Category> findByNameContaining(String keyword, Pageable page);

    Page<Category> findAll(Pageable pageable);

    Optional<Category> findById(Long id);

    Category save(Category category);

    void deleteById(Long id);

    long count();
}
