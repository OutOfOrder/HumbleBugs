(function ($) {

  var flash = function (message) {
    flash.notify(message);
  }
  window.flash = flash;

  $.extend(flash, {
    notify: function(message) {

    },
    load: function() {
      var $flash = $('#flash');
      if ($flash.children().length > 0) {
        $flash.fadeIn('fast').delay(3000).fadeOut('slow');
      }
    }
  });

  $(function () {
    flash.load();
  });
})(jQuery);
