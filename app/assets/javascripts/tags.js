$(function() {
  $('.tags').each(function() {
    var $this = $(this);
    var options = $this.data('tagsInput') || {};
    $this.tagsInput(options);
  });
});