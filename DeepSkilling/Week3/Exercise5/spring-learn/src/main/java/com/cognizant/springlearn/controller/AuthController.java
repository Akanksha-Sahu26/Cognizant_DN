package com.cognizant.springlearn.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class AuthController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

	@GetMapping("/authenticate")
	public Map<String, String> authenticate(@RequestHeader(value = "Authorization", required = false) String authHeader) {
		LOGGER.info("Inside authenticate - Start");
		
		if (authHeader == null || !authHeader.startsWith("Basic ")) {
			LOGGER.error("Missing or invalid Authorization header");
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Missing or invalid Authorization header");
		}

		String base64Credentials = authHeader.substring(6).trim();
		String credentials;
		try {
			byte[] decoded = Base64.getDecoder().decode(base64Credentials);
			credentials = new String(decoded, StandardCharsets.UTF_8);
		} catch (IllegalArgumentException e) {
			LOGGER.error("Failed to decode base64 credentials: {}", e.getMessage());
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Failed to decode base64 credentials");
		}

		String[] values = credentials.split(":", 2);
		if (values.length != 2) {
			LOGGER.error("Invalid credentials format");
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials format");
		}

		String username = values[0];
		String password = values[1];

		if (!"user".equals(username) || !"pwd".equals(password)) {
			LOGGER.error("Invalid username or password");
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid username or password");
		}

		LOGGER.info("User {} successfully authenticated", username);

		// Generate token using HMAC256
		Algorithm algorithm = Algorithm.HMAC256("jwt-secret-key-must-be-long-enough-for-hmac256-which-is-at-least-256-bits");
		String token = JWT.create()
				.withSubject(username)
				.withIssuedAt(new Date())
				.withExpiresAt(new Date(System.currentTimeMillis() + 1800000)) // 30 minutes expiration
				.sign(algorithm);

		Map<String, String> response = new HashMap<>();
		response.put("token", token);

		LOGGER.info("Inside authenticate - End. Generated token: {}", token);
		return response;
	}

}
