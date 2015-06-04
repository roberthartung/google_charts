/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/piechart

import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  PieChart.load().then((_) {
    var data = arrayToDataTable([
      ['Language', 'Speakers (in millions)'],
      ['Assamese', 13],
      ['Bengali', 83],
      ['Bodo', 1.4],
      ['Dogri', 2.3],
      ['Gujarati', 46],
      ['Hindi', 300],
      ['Kannada', 38],
      ['Kashmiri', 5.5],
      ['Konkani', 5],
      ['Maithili', 20],
      ['Malayalam', 33],
      ['Manipuri', 1.5],
      ['Marathi', 72],
      ['Nepali', 2.9],
      ['Oriya', 33],
      ['Punjabi', 29],
      ['Sanskrit', 0.01],
      ['Santhali', 6.5],
      ['Sindhi', 2.5],
      ['Tamil', 61],
      ['Telugu', 74],
      ['Urdu', 52]
    ]);

    var options = {
      'title': 'Indian Language Use',
      'legend': 'none',
      'pieSliceText': 'label',
      'slices': {
        4: {'offset': 0.2},
        12: {'offset': 0.3},
        14: {'offset': 0.4},
        15: {'offset': 0.5},
      },
    };

    var chart =
        new PieChart(document.getElementById('piechart'));
    chart.draw(data, options);
  });
}
