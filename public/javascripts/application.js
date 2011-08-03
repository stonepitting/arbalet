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
