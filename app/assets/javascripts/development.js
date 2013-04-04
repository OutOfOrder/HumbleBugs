function SwitchUser(id) {
    $.post('/secret_login', {id: id})
        .success(function() {
            window.location.reload();
        });
}
$(function() {
    $('#switch_user_id').change(function() {
        SwitchUser($(this).val());
    });
});