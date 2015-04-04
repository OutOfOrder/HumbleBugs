$(function() {
    $(document).on('dialogopen', function(e, ui) {
        Controls.Setup(e.target);
    });
});
