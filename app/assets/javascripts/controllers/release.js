$(function() {
    var filterState = {
        status: 'active',
        platform: ''
    };
    var filters = {
        status: function(item) {
            if (filterState.status == '') return true;
            return item.values()['status'] == filterState.status;
        },
        platform: function(item) {
            if (filterState.platform == '') return true;
            var plats = item.values()['platforms'].split(/\s*,\s*/);
            return (plats.indexOf(filterState.platform) != -1);
        }
    };
    function filterFunc(item) {
        for(var k in filters) {
            var ret = filters[k](item);
            if (!ret) return false;
        }
        return true;
    }

    $('table.releases-table').each(function() {
        var $this = $(this);
        var listjs = new List(this, {
            valueNames: ['version','platforms','status','notes','updated'],
            searchColumns: ['version','notes'],
            plugins: [
                ListFuzzySearch()
            ]
        });
        $this.data('listjs', listjs);

        $this.find('.status_filter').on('change', 'input', function() {
            filterState.status = $(this).val();
            listjs.filter(filterFunc);
        }).find('input[value="'+filterState.status+'"]').prop('checked', true);


        $this.find('select.platform_filter').on('change', function() {
            filterState.platform = $(this).select2('val');
            listjs.filter(filterFunc);
        });
        filterState.platform = $this.find('select.platform_filter').val();

        listjs.filter(filterFunc);
    });
});