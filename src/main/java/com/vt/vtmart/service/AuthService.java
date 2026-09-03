package com.vt.vtmart.service;

import com.vt.vtmart.dao.UserDAO;
import com.vt.vtmart.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Optional;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String email, String password) {
        if (email == null || password == null) {
            return null;
        }

        Optional<User> userOpt = userDAO.findByEmail(email.trim());
        if (userOpt.isEmpty()) {
            return null;
        }

        User user = userOpt.get();
        String dbPass = user.getPasswordHash();
        if (dbPass == null) {
            return null;
        }

        boolean matches = false;

        // Plain-text check / demo fallback
        if (password.equals(dbPass)) {
            matches = true;
        } else {
            // BCrypt check with safety catch
            try {
                if (dbPass.startsWith("$2a$") || dbPass.startsWith("$2b$") || dbPass.startsWith("$2y$")) {
                    matches = BCrypt.checkpw(password, dbPass);
                }
            } catch (Exception e) {
                matches = false;
            }
        }

        return matches ? user : null;
    }

    public boolean register(String name, String email, String password, String role) {
        if (userDAO.findByEmail(email).isPresent()) {
            return false;
        }
        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
        User newUser = new User();
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setPasswordHash(hashed);
        newUser.setRole(role != null ? role : "BUYER");

        return userDAO.create(newUser);
    }
}
