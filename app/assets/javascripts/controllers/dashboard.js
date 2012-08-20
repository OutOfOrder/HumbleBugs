$(function() {
  $('div.dashboard_column').sortable({
    connectWith: 'div.dashboard_column',
    distance: 5,
    cursor: 'crosshair',
    cancel: '.content'
  });
});