$(function () {
    $('.select2').each(function () {
        var $this = $(this);
        var options = $this.data('select2Options') || {};
        $this.select2(options);
    });
});