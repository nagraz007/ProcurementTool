// JavaScript Document

//helper function to create the form
function getNewSubmitForm(){
	 var submitForm = document.createElement("FORM");
	 document.body.appendChild(submitForm);
	 submitForm.method = "POST";
	 return submitForm;
}

function createNewFormElement(inputForm, elementName, elementValue){
	 var newElement = document.createElement("<input name='"+elementName+"' type='hidden'>");
	 inputForm.appendChild(newElement);
	 newElement.value = elementValue;
	 return newElement;
}

function skipRegistration(next_event_id,event_id){
	/* var submitForm = getNewSubmitForm();
	 createNewFormElement(submitForm, "id",event_id);
	 submitForm.action= "nexstep.cfm";
	 submitForm.submit();*/
	 
	window.document.location='nextstep.cfm?skip='+next_event_id+'&source='+event_id;
	/*
	myForm = document.createElement('FORM')
 	myForm.method = 'post'
 	myForm.action = 'newtstep.cfm'
 	myForm.setAttribute('Name', 'myForm')
 	myForm.id = 'myForm'
 	
 	// Create a text selection
 	textField = document.createElement('INPUT')
 	textField.type = 'text'
 	textField.setAttribute('value', event_id)
 	textField.setAttribute('Name', 'event_id')
 	myForm.appendChild(textField)
	myForm.submit();	*/ 
}