/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/annotationchart

import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  AnnotationChart.load().then((_) {
    var data = new DataTable();
    data.addColumn('date', 'Date');
    data.addColumn('number', 'Kepler-22b mission');
    data.addColumn('string', 'Kepler title');
    data.addColumn('string', 'Kepler text');
    data.addColumn('number', 'Gliese 163 mission');
    data.addColumn('string', 'Gliese title');
    data.addColumn('string', 'Gliese text');
    data.addRows([
      [new DateTime(2314, 2, 15), 12400, null, null,
                              10645, null, null],
      [new DateTime(2314, 2, 16), 24045, 'Lalibertines', 'First encounter',
                              12374, null, null],
      [new DateTime(2314, 2, 17), 35022, 'Lalibertines', 'They are very tall',
                              15766, 'Gallantors', 'First Encounter'],
      [new DateTime(2314, 2, 18), 12284, 'Lalibertines', 'Attack on our crew!',
                              34334, 'Gallantors', 'Statement of shared principles'],
      [new DateTime(2314, 2, 19), 8476, 'Lalibertines', 'Heavy casualties',
                              66467, 'Gallantors', 'Mysteries revealed'],
      [new DateTime(2314, 2, 20), 0, 'Lalibertines', 'All crew lost',
                              79463, 'Gallantors', 'Omniscience achieved']
    ]);

    var chart = new AnnotationChart(document.getElementById('chart_div'));

    var options = {
      'displayAnnotations': true
    };

    chart.draw(data, options);
  });
}