import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  Table.load().then((_) {
    var data = new DataTable();
    data.addColumn('string', 'Department');
    data.addColumn('number', 'Revenues');
    data.addRows([
      ['Shoes', 10700],
      ['Sports', -15400],
      ['Toys', 12500],
      ['Electronics', -2100],
      ['Food', 22600],
      ['Art', 1100]
    ]);

    var table = new Table(document.getElementById('colorformat_div'));

    var formatter = new ColorFormat();
    formatter.addRange(-20000, 0, 'white', 'orange');
    formatter.addRange(20000, null, 'red', '#33ff33');
    formatter.format(data, 1); // Apply formatter to second column

    table.draw(data, {'allowHtml': true, 'showRowNumber': true});
  });
}
