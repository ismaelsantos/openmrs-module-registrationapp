package org.openmrs.module.registrationapp.page.controller;

import static org.junit.Assert.*;

import java.util.Calendar;
import java.util.Date;
import org.junit.Ignore;
import org.jfree.data.time.Year;
import org.junit.Before;
import org.junit.Test;
import org.junit.Before;
import org.mockito.Mockito;
import org.mockito.internal.matchers.Not;
import org.mockito.stubbing.OngoingStubbing;
import org.openmrs.Patient;
import static org.mockito.Mockito.*;

public class RegisterPatientPageControllerTest {
	
	private Patient patientMocked = mock(Patient.class);
	private RegisterPatientPageController registerPatientPage = new RegisterPatientPageController();


	@Test
	public void shouldBuildBirthdateFromEstimatedYearsAndMonths() {

		// prepare

		Integer estimatedYears = 15;
		Integer estimatedMonths = 0;

		Date birthdate = registerPatientPage.buildBirthdate(null, null, null, estimatedYears, estimatedMonths, patientMocked);

		Calendar calendarToday = Calendar.getInstance();
		calendarToday.add(Calendar.YEAR, -estimatedYears);
		calendarToday.add(Calendar.MONTH, -estimatedMonths);

		verify(patientMocked).setBirthdateEstimated(anyBoolean()); // OK!

		assertEquals("day", calendarToday.getTime().getDate(), birthdate.getDate());
		assertEquals("month", calendarToday.getTime().getMonth(), birthdate.getMonth());
		assertEquals("year", calendarToday.getTime().getYear(), birthdate.getYear());
	}

	@Test
	public void shouldBuildBirthdateIfOnlyYearMonthDayAreSet(){

		Date birthdate = registerPatientPage.buildBirthdate(15, 10, 1990, null, null, patientMocked);

		verify(patientMocked, never()).setBirthdateEstimated(anyBoolean());

		assertEquals("day", 15, birthdate.getDate());
		assertEquals("month", 10, birthdate.getMonth());
		assertEquals("year", 90, birthdate.getYear());
	}
	
	@Test
	public void shouldBuildBirthdateIfAllTheParametersAreSet(){

		Date birthdate = registerPatientPage.buildBirthdate(18, 9, 1987, 15, 20, patientMocked);

		verify(patientMocked, never()).setBirthdateEstimated(anyBoolean());

		assertEquals("day", 18, birthdate.getDate());
		assertEquals("month", 9, birthdate.getMonth());
		assertEquals("year", 87, birthdate.getYear());
	}
}
