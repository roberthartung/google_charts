/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/histogram#Example1

import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  ScatterChart.load().then((_) {
    var data = arrayToDataTable([
      ['Age', 'Weight'],
      [8, 12],
      [4, 5.5],
      [11, 14],
      [4, 5],
      [3, 3.5],
      [6.5, 7]
    ]);

    var options = {
      'title': 'Age vs. Weight comparison',
      'hAxis': {'title': 'Age', 'minValue': 0, 'maxValue': 15},
      'vAxis': {'title': 'Weight', 'minValue': 0, 'maxValue': 15},
      'legend': 'none'
    };

    var chart = new ScatterChart(document.getElementById('chart_div'));

    chart.draw(data, options);
  });
}
