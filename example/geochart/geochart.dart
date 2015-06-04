/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/gauge#Example

import 'dart:html';
import 'package:google_charts/google_charts.dart'
    show GeoChart, DataTable, arrayToDataTable;

void main() {
  GeoChart.load().then((_) {
    var data = arrayToDataTable([
        ['Country',   'Population', 'Area Percentage'],
        ['France',  65700000, 50],
        ['Germany', 81890000, 27],
        ['Poland',  38540000, 23]
      ]);

      var options = {
        'sizeAxis': { 'minValue': 0, 'maxValue': 100 },
        'region': '155', // Western Europe
        'displayMode': 'markers',
        'colorAxis': {'colors': ['#e7711c', '#4374e0']} // orange to blue
      };

      var chart = new GeoChart(document.getElementById('chart_div'));
      chart.draw(data, options);
  });
}
