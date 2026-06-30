package com.cognizant.springlearn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@SpringBootApplication
public class SpringLearnApplication {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpringLearnApplication.class);

	public static void main(String[] args) {
		LOGGER.info("SpringLearnApplication starting...");
		SpringApplication.run(SpringLearnApplication.class, args);
		displayCountry();
		LOGGER.info("SpringLearnApplication started successfully!");
	}

	public static void displayCountry() {
		LOGGER.info("Inside displayCountry method.");
		ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
		@SuppressWarnings("unchecked")
		java.util.List<Country> countries = context.getBean("countryList", java.util.ArrayList.class);
		LOGGER.debug("Countries loaded: {}", countries);
	}

}


