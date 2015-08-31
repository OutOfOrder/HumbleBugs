$(function() {
    var filterState = {
        status: 'open',
        priority: -1,
        platform: ''
    };
    var filters = {
        status: function(item) {
            if (filterState.status == '') return true;
            if (filterState.status in Types.Issue.STATUSES) {
                return (Types.Issue.STATUSES[filterState.status].indexOf(item.values()['status']) != -1);
            } else {
                return item.values()['status'] == filterState.status;
            }
        },
        priority: function(item) {
            if (filterState.priority == -1) return true;

            var i, max_priority = 100;
            for (i = 0; i < Types.Issue.PRIORITIES.length; ++i) {
                if (filterState.priority < Types.Issue.PRIORITIES[i]) {
                    max_priority = Types.Issue.PRIORITIES[i];
                } else {
                    break;
                }
            }

            var priority = parseInt(item.values()['priority']);

            return priority >= filterState.priority && priority < max_priority;
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

    $('table.issues-table').each(function() {
        var $this = $(this);
        var listjs = new List(this, {
            valueNames: ['game','updated','status','priority','platforms','summary','details'],
            searchColumns: ['game','summary','details'],
            plugins: [
                ListFuzzySearch()
            ]
        });
        $this.data('listjs', listjs);

        $this.find('.status_filter').on('change', 'input', function() {
            filterState.status = $(this).val();
            listjs.filter(filterFunc);
        }).find('input[value="'+filterState.status+'"]').prop('checked', true);
        $this.find('.priority_filter').on('change', 'input', function() {
            filterState.priority = parseInt($(this).val());
            listjs.filter(filterFunc);
        }).find('input[value="'+filterState.priority+'"]').prop('checked', true);

        $this.find('select.platform_filter').on('change', function() {
            filterState.platform = $(this).select2('val');
            listjs.filter(filterFunc);
        });
        filterState.platform = $this.find('select.platform_filter').val();

        listjs.filter(filterFunc);

        $this.on('click', '.refresh_issues:not(:disabled)', function() {
          var $self= $(this);
          var gameID = $self.data('gameId');
          $.rails.disableFormElement($self);
          $.get('/games/' + gameID + '/issues').done(function(data) {
              var $html = $(data);
              var $contents = $html.find('.list');
              $this.find('.list').replaceWith($contents);
              Controls.Setup($this.find('.list'))
              listjs.list = $this.find('.list').get(0);
              listjs.reIndex();
              listjs.filter(filterFunc);
          }).always(function() {
            $.rails.enableFormElement($self);
          });
        });
    });
});