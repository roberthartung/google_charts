import 'dart:html';
import 'package:google_charts/google_charts.dart';

/// Taken from https://developers.google.com/chart/interactive/docs/gallery/barchart
void main() {
  LineChart.load().then((_) {
    var data = arrayToDataTable([
      ['Year', 'Sales', 'Expenses'],
      ['2004',  1000,      400],
      ['2005',  1170,      460],
      ['2006',  660,       1120],
      ['2007',  1030,      540]
    ]);

    var options = {
      'title': 'Company Performance',
      'curveType': 'function',
      'legend': { 'position': 'bottom' }
    };

    var chart = new LineChart(document.getElementById('curve_chart'));
    selectHandler(_) {
      var selectedItems = chart.getSelection();
      print(selectedItems.moveNext());
      SelectedObject item = selectedItems.current;
      print(item.row);
      print(item.column);
    }

    chart.onSelect.listen( selectHandler);
    chart.draw(data, options);
  });
}
