(function() {
    function mapConfig() {
        return $(this).data('widget');
    }

    window.Dashboard = {
        serializeColumn: function(col) {
            return $('div.dashboard_column:nth-child('+col+') fieldset.widget').map(mapConfig).get();
        },
        serialize: function() {
            return [
                Dashboard.serializeColumn(1),
                Dashboard.serializeColumn(2),
                Dashboard.serializeColumn(3)
            ];
        },
        saveDashboard: function() {
            var config = Dashboard.serialize();
            console.log('Dashboard Change', config);
            $.ajax({
                type: 'PUT',
                url: '/dashboard',
                data: JSON.stringify({dashboard: config }),
                contentType: 'application/json; charset=UTF-8',
                processData: false,
                dataType: 'json'
            }).done(function(data, status, XHR) {
                console.log('Success?', data);
            }).fail(function(XHR, status, error) {
                console.log('Fail!');
            });
        }
    };

    $(function() {
      $('div.dashboard_column').sortable({
        connectWith: 'div.dashboard_column',
        distance: 5,
        cursor: 'crosshair',
        cancel: '.content',
        update: function(e, ui) { if (ui.sender == null) Dashboard.saveDashboard(); }
      });
    });
})();
