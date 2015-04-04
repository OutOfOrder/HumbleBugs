$.timeago.settings.allowFuture = true;

Controls.Register('timeago', function($parent) {
    $parent.find('time.timeago').timeago();
});
