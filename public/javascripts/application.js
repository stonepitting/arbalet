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

// adds the ajax loader to the element of id #id
function loadImg(id){
  img_tag = '<div style="text-align:center"><img src="/images/loader.gif" alt="" style="padding: 30px 0;" /></div>';
  $('#' + id).html(img_tag);
}

function loadTab(app_id, tab){
	load_url = '/apps/' + app_id + '/' + tab;

  $.ajax({
     url: load_url,
     success: function(data){
        // reload the tab
       $('#pane2-content').html(data);
     },
     beforeSend: function(){
       loadImg('pane2-content');
     }

   });
	//$('#pane2-content').load(url);

	$('#pane2-tabs li').removeClass('tab-selected');
	$('#' + tab + '_tab').addClass('tab-selected');
	
	return false;
}

// This function prepares a remote form
function prepareForm(app_id, object){
	f = $('#create_form');
	
  	f.bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('input[name="commit"]');
	   
  	});
  	
	f.bind("ajax:success", function(evt, data, status, xhr){
      console.log('success');
      loadTab(app_id, object);
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

//This function deletes an object through ajax and reloads the parent pane
function deleteObject(object_type, object_id, app_id){
  if (confirm('Are you sure?')){
    del_url = '/' + object_type + '/' + object_id;
    $.ajax({
     type: "DELETE",
     url: del_url,
     success: function(msg){
        // reload the tab
       loadTab(app_id, object_type);
     }

   });
   return false;
  }
}

function backToListing(object_type, app_id){
	$('#listing-object').slideDown();
	$('#object-visualizer').slideUp();
	return false;
}