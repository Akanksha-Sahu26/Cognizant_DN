package com.cognizant.springlearn.controller;

import com.cognizant.springlearn.Country;
import com.cognizant.springlearn.service.CountryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class CountryController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CountryController.class);

	private final CountryService countryService;

	public CountryController(CountryService countryService) {
		this.countryService = countryService;
	}

	@GetMapping({"/countries/{code}", "/country/{code}"})
	public Country getCountry(@PathVariable String code) {
		LOGGER.info("Inside getCountry - Start. Requested code: {}", code);
		Country country = countryService.getCountry(code);
		if (country == null) {
			LOGGER.error("Country not found for code: {}", code);
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Country not found");
		}
		LOGGER.info("Inside getCountry - End. Returned country: {}", country);
		return country;
	}

}
