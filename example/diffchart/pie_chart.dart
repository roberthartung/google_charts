import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  PieChart.load().then((_) {
    var oldData = arrayToDataTable([
      ['Major', 'Degrees'],
      ['Business', 256070], ['Education', 108034],
      ['Social Sciences & History', 127101], ['Health', 81863],
      ['Psychology', 74194]]);

    var newData = arrayToDataTable([
      ['Major', 'Degrees'],
      ['Business', 358293], ['Education', 101265],
      ['Social Sciences & History', 172780], ['Health', 129634],
      ['Psychology', 97216]]);

    var options = { 'pieSliceText': 'none' };

    var chartBefore = new PieChart(document.getElementById('piechart_before'));
    var chartAfter = new PieChart(document.getElementById('piechart_after'));
    var chartDiff = new PieChart(document.getElementById('piechart_diff'));

    chartBefore.draw(oldData, options);
    chartAfter.draw(newData, options);

    var diffData = chartDiff.computeDiff(oldData, newData);
    chartDiff.draw(diffData, options);
  });
}