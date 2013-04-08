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
        }
    };

    $(function() {
      $('div.dashboard_column').sortable({
        connectWith: 'div.dashboard_column',
        distance: 5,
        cursor: 'crosshair',
        cancel: '.content',
        update: Dashboard.saveDashboard
      });
    });
})();
