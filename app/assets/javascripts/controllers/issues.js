$(function() {
    var filterState = {
        status: 'open'
    };
    var filters = {
        status: function(item) {
            if (filterState.status == '') return true;
            if (filterState.status in Types.Issue.STATUSES) {
                return (Types.Issue.STATUSES[filterState.status].indexOf(item.values()['status']) != -1);
            } else {
                return item.values()['status'] == filterState.status;
            }
        }
    };
    function filterFunc(item) {
        for(var k in filters) {
            var ret = filters[k](item);
            if (!ret) return false;
        }
        return true;
    }

    $('table.issues-table').each(function() {
        var listjs = new List(this, {
            valueNames: ['game','updated','status','priority','platforms','summary','details'],
            searchColumns: ['game','summary','details'],
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