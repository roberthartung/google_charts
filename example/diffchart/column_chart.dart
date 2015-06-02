import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  /// No Need to load both [ColumnChart] and [BarChart] because both are using
  /// the corechart package!
  ColumnChart.load().then((_) {
    var oldData = arrayToDataTable([
      ['Name', 'Popularity'],
      ['Cesar', 250],
      ['Rachel', 4200],
      ['Patrick', 2900],
      ['Eric', 8200]
    ]);

    var newData = arrayToDataTable([
      ['Name', 'Popularity'],
      ['Cesar', 370],
      ['Rachel', 600],
      ['Patrick', 700],
      ['Eric', 1500]
    ]);

    var colChartBefore = new ColumnChart(
        document.getElementById('colchart_before'));
    var colChartAfter = new ColumnChart(
        document.getElementById('colchart_after'));
    var colChartDiff = new ColumnChart(
        document.getElementById('colchart_diff'));
    var barChartDiff = new BarChart(
        document.getElementById('barchart_diff'));

    var options = {'legend': {'position': 'top'}};

    colChartBefore.draw(oldData, options);
    colChartAfter.draw(newData, options);

    var diffData = colChartDiff.computeDiff(oldData, newData);
    colChartDiff.draw(diffData, options);
    barChartDiff.draw(diffData, options);
  });
}
