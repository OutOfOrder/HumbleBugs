$(function() {
  $('table.issues-table').each(function() {
    $(this).data('listjs', new List(this, {
      valueNames: ['game','updated','status','priority','platforms','summary','details'],
      searchColumns: ['game','summary','details'],
      plugins: [
        ListFuzzySearch()
      ]
    }));
  });
});