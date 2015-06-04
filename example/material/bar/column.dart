import 'dart:html';
import 'package:google_charts/google_charts.dart';

/// Taken from https://developers.google.com/chart/interactive/docs/gallery/barchart
void main() {
  Bar.load().then((_) {
    var data = arrayToDataTable([
      ['Year', 'Sales', 'Expenses', 'Profit'],
      ['2014', 1000, 400, 200],
      ['2015', 1170, 460, 250],
      ['2016', 660, 1120, 300],
      ['2017', 1030, 540, 350]
    ]);

    var options = {
      'chart': {
        'title': 'Company Performance',
        'subtitle': 'Sales, Expenses, and Profit: 2014-2017',
      }
    };

    var chart = new Bar(document.getElementById('columnchart_material'));

    chart.draw(data, options);
  });
}
