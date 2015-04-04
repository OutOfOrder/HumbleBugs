Controls.Register('select2', function($parent) {
    $parent.find('select').each(function () {
        var $this = $(this);
        var options = $.extend({
            containerCss: {minWidth: '15em'},
            dropdownAutoWidth: true
        }, $this.data('select2Options') || {});
        $this.select2(options);
    });
});
