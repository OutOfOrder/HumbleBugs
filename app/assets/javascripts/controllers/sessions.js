$(function () {
    var tz_form = $('.login_form #time_zone');
    if (tz_form.length) {
        tz = jstz.determine_timezone();
        tz_form.val(tz.name());
    }
});
