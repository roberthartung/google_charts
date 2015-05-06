/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/piechart

import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  PieChart.load().then((_) {
    var data = arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Work',     11],
        ['Eat',      2],
        ['Commute',  2],
        ['Watch TV', 2],
        ['Sleep',    7]
      ]);

      var options = {
        'title': 'My Daily Activities',
        'pieHole': 0.4
      };

      var chart = new PieChart(document.getElementById('donutchart'));

      chart.draw(data, options);
  });
}
