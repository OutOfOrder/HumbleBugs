$(function() {
  $('div.comment:target').effect('pulsate', {times:2}, 'slow');
  $('#comments').on('click', 'div.comment span.expand', function(e) {
    console.log('click me');
    var $comment = $(this).closest('.comment').find('.comment_entry');
    var $dialog = $comment.clone();

    $dialog.dialog({
      autoOpen: false,
      modal: true,
      resizable: false,
      show: 'scale',
      hide: 'scale',
      width: '90%',
      height: $(window).height() * 0.8,
      close: function(event, ui) {
        $(this).remove();
      }
    }).dialog('open');
  });
});