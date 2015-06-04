/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/histogram#Example1

import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  Timeline.load().then((_) {
    var container = document.getElementById('timeline');
    var chart = new Timeline(container);
    var dataTable = new DataTable();

    dataTable.addColumn({'type': 'string', 'id': 'President'});
    dataTable.addColumn({'type': 'date', 'id': 'Start'});
    dataTable.addColumn({'type': 'date', 'id': 'End'});
    dataTable.addRows([
      ['Washington', new DateTime(1789, 3, 29), new DateTime(1797, 2, 3)],
      ['Adams', new DateTime(1797, 2, 3), new DateTime(1801, 2, 3)],
      ['Jefferson', new DateTime(1801, 2, 3), new DateTime(1809, 2, 3)]
    ]);

    chart.draw(dataTable);
  });
}
