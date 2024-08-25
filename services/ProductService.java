package com.example.uniproject.services;

import com.example.uniproject.models.Products;
import com.example.uniproject.models.Users;
import com.example.uniproject.repositories.ProductRepository;
import com.example.uniproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;


@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Products> listProducts(String title) {
        if (title != null) return productRepository.findByTitle(title);
        return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Products product) {
        product.setUser(getUserByPrincipal(principal));
        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());

        productRepository.save(product);
    }


    public Users getUserByPrincipal(Principal principal) {
        if (principal == null) return new Users();
        return userRepository.findByEmail(principal.getName());
    }

    public void deleteProduct(Users user, Long id) {
        Products product = productRepository.findById(id)
                .orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                productRepository.delete(product);
                log.info("Product with id = {} was deleted", id);
            } else {
               log.error("User: {} haven't this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} is not found", id);
        }
    }

    public Products getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
