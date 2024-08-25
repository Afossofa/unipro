package com.example.uniproject.services;

import com.example.uniproject.models.Users;
import com.example.uniproject.models.enums.Role;
import com.example.uniproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    public boolean createUser(Users user){
        String email = user.getEmail();
        if(userRepository.findByEmail(email) != null) return false;
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        return true;
    }
    public List<Users> list(){
        return userRepository.findAll();
    }
    public void changeUserRoles(Users user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }
    public void deleteUser(Object userByPrincipal, Long id) {
        Users user = userRepository.findById(id)
                .orElse(null);
        if (user != null) {
                userRepository.delete(user);
                log.info("User with id {} was deleted", id);
        }
        else {
            log.info("User with id {} not found", id);
        }
    }
    public Object getUserByPrincipal(Principal principal) {
        if (principal == null) return new Users();
        return userRepository.findByEmail(principal.getName());
    }
}
