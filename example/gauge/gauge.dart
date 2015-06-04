/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/gauge#Example

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:google_charts/google_charts.dart'
    show Gauge, DataTable, arrayToDataTable;

void main() {
  Gauge.load().then((_) {
    var data = arrayToDataTable(
        [['Label', 'Value'], ['Memory', 80], ['CPU', 55], ['Network', 68]]);

    var options = {
      'width': 400,
      'height': 120,
      'redFrom': 90,
      'redTo': 100,
      'yellowFrom': 75,
      'yellowTo': 90,
      'minorTicks': 5
    };

    var chart = new Gauge(document.getElementById('chart_div'));

    chart.draw(data, options);

    new Timer.periodic(new Duration(milliseconds: 13000), (Timer t) {
      data.setValue(0, 1, 40 + (60 * new Random().nextDouble()).round());
      chart.draw(data, options);
    });

    new Timer.periodic(new Duration(milliseconds: 5000), (Timer t) {
      data.setValue(1, 1, 40 + (60 * new Random().nextDouble()).round());
      chart.draw(data, options);
    });

    new Timer.periodic(new Duration(milliseconds: 26000), (Timer t) {
      data.setValue(2, 1, 40 + (60 * new Random().nextDouble()).round());
      chart.draw(data,  options);
    });
  });
}
