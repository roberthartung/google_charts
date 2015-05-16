import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  Table.load().then((_) {
    var data = new DataTable();
    data.addColumn('string', 'Department');
    data.addColumn('number', 'Revenues Change');
    data.addRows([
      ['Shoes', {'v':12, 'f':'12.0%'}],
      ['Sports', {'v':-7.3, 'f':'-7.3%'}],
      ['Toys', {'v':0, 'f':'0%'}],
      ['Electronics', {'v':-2.1, 'f':'-2.1%'}],
      ['Food', {'v':22, 'f':'22.0%'}]
    ]);

    var table = new Table(document.getElementById('arrowformat_div'));

    var formatter = new ArrowFormat();
    formatter.format(data, 1); // Apply formatter to second column

    table.draw(data, {'allowHtml': true, 'showRowNumber': true});
  });
}
