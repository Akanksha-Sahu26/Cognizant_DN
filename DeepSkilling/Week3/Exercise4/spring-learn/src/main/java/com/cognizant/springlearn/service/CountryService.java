package com.cognizant.springlearn.service;

import java.util.ArrayList;
import java.util.List;
import com.cognizant.springlearn.Country;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

@Service
public class CountryService {

	private final List<Country> countries;

	@SuppressWarnings("unchecked")
	public CountryService() {
		ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
		this.countries = context.getBean("countryList", ArrayList.class);
	}

	public Country getCountry(String code) {
		return countries.stream()
				.filter(c -> c.getCode().equalsIgnoreCase(code))
				.findFirst()
				.orElse(null);
	}

}
