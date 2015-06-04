/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/histogram#Example1

import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  Table.load().then((_) {
    var data = new DataTable();
            data.addColumn('string', 'Name');
            data.addColumn('number', 'Salary');
            data.addColumn('boolean', 'Full Time Employee');
            data.addRows([
              ['Mike',  {'v': 10000, 'f': '\$10,000'}, true],
              ['Jim',   {'v' :8000,   'f': '\$8,000'},  false],
              ['Alice', {'v': 12500, 'f': '\$12,500'}, true],
              ['Bob',   {'v': 7000,  'f': '\$7,000'},  true]
            ]);

            var table = new Table(document.getElementById('table_div'));

            table.draw(data, {'showRowNumber': true});
  });
}
