package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import model.Borrower;
import model.User;

public class Validation {

    public static String hashPassword(String password) {
        try {
            // Generate a random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            // Create MessageDigest instance for SHA-512
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt);

            // Add password bytes to digest
            byte[] hashedPassword = md.digest(password.getBytes());

            // Combine salt and password bytes
            byte[] combinedHash = new byte[salt.length + hashedPassword.length];
            System.arraycopy(salt, 0, combinedHash, 0, salt.length);
            System.arraycopy(hashedPassword, 0, combinedHash, salt.length, hashedPassword.length);

            // Convert to base64 for storage
            return Base64.getEncoder().encodeToString(combinedHash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Decode from base64
            byte[] combinedHash = Base64.getDecoder().decode(storedHash);

            // Extract salt and hash
            byte[] salt = new byte[16];
            byte[] hash = new byte[combinedHash.length - 16];
            System.arraycopy(combinedHash, 0, salt, 0, 16);
            System.arraycopy(combinedHash, 16, hash, 0, hash.length);

            // Generate new hash with same salt
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt);
            byte[] newHash = md.digest(password.getBytes());

            // Compare hashes
            return MessageDigest.isEqual(hash, newHash);
        } catch (NoSuchAlgorithmException | IllegalArgumentException e) {
            return false;
        }
    }


}
