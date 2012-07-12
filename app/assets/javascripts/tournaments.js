$(function(){
  // enable date-pickers
  // TODO: use a data attribute to do this
  $('input[data-toggle=datepicker]').datepicker({
    format: 'dd-mm-yyyy'
  });

  // decent tab navigation
  $(window).bind('popstate', function(e) {
    path_array = location.pathname.split('/');

    if(path_array[1] == 'tournaments'){
      tab = "#" + path_array[path_array.length - 1];

      if(tab == ''){
        tab = 'overview';
      }

      $("#tournament-tabs a[href=" + tab + "]").tab('show');
    }
  });

  $('#tournament-tabs a').each(function(e){
    $(this).attr('data-path', $(this).attr('href'));
    $(this).attr('href', $(this).attr('data-tab-id'));
  });

  $('#tournament-tabs a').click(function(e){
    e.preventDefault();
    $(this).tab('show');
  });

  $('#tournament-tabs').bind('show', function(e) {
    history.pushState('', '', $(e.target).attr('data-path'));

    var pattern = /#.+/gi;
    var content_id = e.target.toString().match(pattern)[0];
    var extension = '.js';

    $(content_id).load(content_id.replace('#','')+extension, function(){
      $('#tournament-tabs').tab(); //reinitialize tabs
    });
  });
})
