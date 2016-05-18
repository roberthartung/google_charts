/// Thanks to [Teddy Clark] for making me aware of this issue

import 'package:google_charts/google_charts.dart'
    show Table, DataTable;
import 'package:polymer/polymer.dart';

@PolymerRegister('gviz-table')
class GvizTable extends PolymerElement {
  GvizTable.created() : super.created() {}

  void ready() {
    Table.load().then((_) {
      var data = new DataTable();
      data.addColumn('string', 'Name');
      data.addColumn('number', 'Salary');
      data.addColumn('boolean', 'Full Time Employee');
      data.addRows([
        ['Mike', {'v': 10000, 'f': '\$10,000'}, true],
        ['Jim', {'v': 8000, 'f': '\$8,000'}, false],
        ['Alice', {'v': 12500, 'f': '\$12,500'}, true],
        ['Bob', {'v': 7000, 'f': '\$7,000'}, true]
      ]);

      var table = new Table($['table_div']);
      var options = {
        'title': 'My First Table Chart',
        'showRowNumber': true,
        'alternatingRowStyle': true,
        'width': 500,
        'height': 200
      };

      table.draw(data, options);
    });
  }
}
