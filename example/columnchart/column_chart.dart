import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  LineChart.load().then((_) {
    Chart chart = new ColumnChart(querySelector('#chart'));
    DataTable data = new DataTable();
    data.addColumn('string', 'year');
    data.addColumn('number', 'Germany');
    data.addColumn('number', 'France');
    data.addRows([
      ['2011', 81800000, 65340000],
      ['2012', 80430000, 65680000],
      ['2013', 80620000, 66030000]
      ]);

    chart.draw(data, {'title': 'Population', 'vAxis': {'minValue': 0}});
  });
}