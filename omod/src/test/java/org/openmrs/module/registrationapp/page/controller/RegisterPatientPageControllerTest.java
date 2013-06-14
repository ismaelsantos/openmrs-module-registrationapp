package org.openmrs.module.registrationapp.page.controller;

import static org.junit.Assert.*;

import java.util.Calendar;
import java.util.Date;

import org.jfree.data.time.Year;
import org.junit.Before;
import org.junit.Test;

public class RegisterPatientPageControllerTest {
	
	private RegisterPatientPageController registerPatientPage;

	@Before
	public void setUp() {
		registerPatientPage = new RegisterPatientPageController();
	}
	
	@Test
	public void shouldBuildBirthdateFromEstimatedYearsAndMonths() {	
		Integer estimatedYears = 15;
		Integer estimatedMonths = 0;
		 
		Date birthdate = registerPatientPage.buildBirthdate(null, null, null, estimatedYears, estimatedMonths);
		
		Calendar birthdayExpected = Calendar.getInstance();
		
		birthdayExpected.add(Calendar.YEAR, -estimatedYears);
		birthdayExpected.add(Calendar.MONTH, -estimatedMonths);
		Date birthdayExpectedDate = birthdayExpected.getTime();
		
		assertEquals(birthdayExpectedDate.getYear(), birthdate.getYear());
		assertEquals(birthdayExpectedDate.getMonth(), birthdate.getMonth());
		assertEquals(birthdayExpectedDate.getDay(), birthdate.getDay());
	}
	
	@Test
	public void shouldBuildBirthDateIfFiveParametersArePassed() {
		Date birthDate = registerPatientPage.buildBirthdate(4, 8, 1984, 5, 15);
		
		assertEquals(4, birthDate.getDate());
		assertEquals(8, birthDate.getMonth());
		assertEquals(84, birthDate.getYear());
	}
	

}
