$(function() {
    var filterState = {
        status: 'active'
    };
    var filters = {
        status: function(item) {
            //return true;
            if (filterState.status == '') return true;
            return item.values()['status'] == filterState.status;
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
        var listjs = new List(this, {
            valueNames: ['version','platforms','status','notes','updated'],
            searchColumns: ['version','notes'],
            plugins: [
                ListFuzzySearch()
            ]
        });
        $(this).data('listjs', listjs);
        listjs.filter(filterFunc);

        $(this).find('.status_filter').on('change', 'input', function() {
            filterState.status = $(this).val();
            listjs.filter(filterFunc);
        }).find('input[value="'+filterState.status+'"]').prop('checked', true);
    });
});