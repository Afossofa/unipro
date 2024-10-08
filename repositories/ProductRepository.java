package com.example.uniproject.repositories;

import com.example.uniproject.models.Products;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Products, Long> {
    List<Products> findByTitle(String title);
}
