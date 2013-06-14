package org.openmrs.module.registrationapp.page.controller;

import static org.junit.Assert.*;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;

public class RegisterPatientPageControllerTest {

	@Test
	public void shouldBuildBirthdateFromEstimatedYearsAndMonths() {
		
		// prepare
		RegisterPatientPageController registerPatientPage = new RegisterPatientPageController();
		
		Integer estimatedYears = 15;
		Integer estimatedMonths = 0;
		 
		Date birthdate = registerPatientPage.buildBirthdate(null, null, null, estimatedYears, estimatedMonths);
		
		Calendar calendarToday = Calendar.getInstance();
		
		calendarToday.add(Calendar.YEAR, -estimatedYears);
		calendarToday.add(Calendar.MONTH, -estimatedMonths);
		
		assertEquals(calendarToday.getTime(), birthdate);
		
	}
	

}
