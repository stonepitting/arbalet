// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function loadApp(app_id){
	$('#pane2').load('/apps/' + app_id); 
	$('.app').removeClass('selected');
	$('.app-pointer').hide();
	$('#app_' + app_id).addClass('selected');
	$('#app_' + app_id + ' .app-pointer').show();
	return false;
}

function loadTab(app_id, tab){
	url = '/apps/' + app_id + '/' + tab;
	$('#pane2-content').load(url);

	$('#pane2-tabs li').removeClass('tab-selected');
	$('#' + tab + '_tab').addClass('tab-selected');
	
	return false;
}

// This function prepares a remote form
function prepareForm(app_id, object){
	f = $('#create_form');
	console.log('f: ' + f);

  	f.bind("ajax:beforeSend", function(evt, xhr, settings){
		console.log('submitting...');
    	var $submitButton = $(this).find('input[name="commit"]');
	
    	// Update the text of the submit button to let the user know stuff is happening.
    	// But first, store the original text of the submit button, so it can be restored when the request is finished.
    	$submitButton.data( 'origText', $(this).text() );
    	$submitButton.text( "Submitting..." );

  	});
  	
	f.bind("ajax:success", function(evt, data, status, xhr){
		console.log('submitted');
    	loadTab(app_id, object);
  	});
  	
	f.bind('ajax:complete', function(evt, xhr, status){
    	var $submitButton = $(this).find('input[name="commit"]');

    	// Restore the original submit button text
    	$submitButton.text( $(this).data('origText') );
  	});
  	
	f.bind("ajax:error", function(evt, xhr, status, error){
    	var $form = $(this),
        	errors,
        	errorText;

    	try {	
      		// Populate errorText with the comment errors
      		errors = $.parseJSON(xhr.responseText);
    	} catch(err) {
      		// If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
      		errors = {message: "Please reload the page and try again"};
    	}

    	// Build an unordered list from the list of errors
    	errorText = "There were errors with the submission: \n<ul>";

    	for ( error in errors ) {
      		errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
    	}

    	errorText += "</ul>";

    	// Insert error list into form
    	$form.find('div.validation-error').html(errorText);
  	});
}


function showObject(object_type, object_id){
	$('#listing-object').slideUp();
	$('#object-visualizer').slideDown();
	$('#object-edit').load('/' + object_type + '/' + object_id + '/edit');
	return false;
}

function backToListing(object_type, app_id){
	$('#listing-object').slideDown();
	$('#object-visualizer').slideUp();
	return false;
}