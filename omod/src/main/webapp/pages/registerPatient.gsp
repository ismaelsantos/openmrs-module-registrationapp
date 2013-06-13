<%
    if (sessionContext.authenticated && !sessionContext.currentProvider) {
        throw new IllegalStateException("Logged-in user is not a Provider")
    }
    ui.decorateWith("appui", "standardEmrPage")
    ui.includeJavascript("uicommons", "navigator/validators.js", Integer.MAX_VALUE - 19)
    ui.includeJavascript("uicommons", "navigator/navigator.js", Integer.MAX_VALUE - 20)
    ui.includeJavascript("uicommons", "navigator/navigatorHandlers.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/navigatorModels.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/exitHandlers.js", Integer.MAX_VALUE - 22);
    ui.includeCss("uicommons", "emr/simpleFormUi.css", -200)

    def genderOptions = [ [label: ui.message("emr.gender.M"), value: 'M'],
                          [label: ui.message("emr.gender.F"), value: 'F'] ]
                          
	def monthOptions = []
	(0..11).each { i->
		monthOptions[i] = [label: ui.message("registrationapp.month."+i), value: i]
	}
%>
${ ui.includeFragment("uicommons", "validationMessages")}

<script type="text/javascript">
    jQuery(function() {
        KeyboardController();
    });
</script>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("registrationapp.registration.label") }", link: "${ ui.pageLink("registrationapp", "registerPatient") }" }
    ];

    var testFormStructure = "${formStructure}";
</script>

<div id="content" class="container">
    <h2>
        ${ ui.message("registrationapp.registration.label") }
    </h2>

    <form id="registration" method="POST">
        <section id="demographics">
            <span class="title">Demographics</span>

            <fieldset>
                <legend>${ui.message("SystemInfo.name")}</legend>
                <h3>${ui.message("registrationapp.patient.name.question")}</h3>
                <% nameTemplate.lineByLineFormat.each { name -> %>
                    ${ ui.includeFragment("uicommons", "field/text", [
                            label: ui.message(nameTemplate.nameMappings[name]),
                            size: nameTemplate.sizeMappings[name],
                            formFieldName: name,
                            left: true])}

                <% } %>
                <input type="hidden" name="preferred" value="true"/>
            </fieldset>

            <fieldset>
                <legend>${ ui.message("emr.gender") }</legend>
                ${ ui.includeFragment("uicommons", "field/dropDown", [
                        label: "What's the patient's gender?",
                        formFieldName: "gender",
                        maximumSize: 3,
                        options: genderOptions
                ])}
            </fieldset>

            <fieldset>
                <legend>${ui.message("Person.birthdate")}</legend>
                <h3>${ ui.message("registrationapp.birthdate.day.question")}</h3>
                ${ ui.includeFragment("uicommons", "field/text", [
                        label: ui.message("registrationapp.birthdate.day.label"),
                        formFieldName: "birthDay",
                        left: true])}
                ${ ui.includeFragment("uicommons", "field/dropDown", [
                        label: ui.message("registrationapp.birthdate.month.label"),
                        formFieldName: "birthMonth",
                        options: monthOptions,
                        maximumSize: 10,
                        left: true])}
                ${ ui.includeFragment("uicommons", "field/text", [
                        label: ui.message("registrationapp.birthdate.year.label"),
                        formFieldName: "birthYear",
                        left: true])}
                
                <h3>${ ui.message("general.or")} </h3>
                ${ ui.includeFragment("uicommons", "field/text", [
                        label: ui.message("registrationapp.birthdate.estimatedyear.label"),
                        formFieldName: "estimatedYear",
                        left: true])}
                        
                ${ ui.includeFragment("uicommons", "field/text", [
                        label: ui.message("registrationapp.birthdate.estimatedmonth.label"),
                        formFieldName: "estimatedMonth",
                        left: true])}                        
                
            </fieldset>

            <% if (enableOverrideOfAddressPortlet == 'false') { %>
	            <fieldset>
	                <legend>${ ui.message("Person.address") }</legend>
	                <h3>${ui.message("registrationapp.patient.address.question")}</h3>
	        		${ ui.includeFragment("uicommons", "field/personAddress", [
                    	addressTemplate: addressTemplate
                	])}
	            </fieldset>
            <% } %>

        </section>
        <!-- read configurable sections from the json config file-->
        <% formStructure.sections.each { structure ->
            def section = structure.value
            def questions=section.questions
        %>
            <section id="${section.id}">
                <span class="title">${ui.message(section.label)}</span>
                    <% questions.each { question ->
                        def fields=question.fields
                    %>
                        <fieldset>
                            <legend>${ ui.message(question.legend)}</legend>
                            <% fields.each { field -> %>
                                ${ ui.includeFragment(field.fragmentRequest.providerName, field.fragmentRequest.fragmentId, [
                                        label:ui.message(field.label),
                                        formFieldName: field.formFieldName,
                                        left: true])}
                            <% } %>
                        </fieldset>
                    <% } %>
            </section>
        <% } %>
        <div id="confirmation">
            <span class="title">Confirm</span>
            <div id="confirmationQuestion">
                Confirm submission? <p style="display: inline"><input type="submit" class="confirm" value="Yes" /></p> or <p style="display: inline"><input id="cancelSubmission" class="cancel" type="button" value="No" /></p>
            </div>
            <div class="before-dataCanvas"></div>
            <div id="dataCanvas"></div>
            <div class="after-data-canvas"></div>
        </div>
    </form>
</div>
