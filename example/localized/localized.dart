import 'dart:html';
import 'package:google_charts/google_charts.dart';

/// Localization example using Dutch localization.
void main() {
  Chart.load(packages: ['corechart'], language: 'nl').then((_) {
    var data = arrayToDataTable([
      ['Jaar', 'Verkoop', 'Uitgaven'],
      ['2004',  1000,      400],
      ['2005',  1170,      460],
      ['2006',  660,       1120],
      ['2007',  1030,      540]
    ]);

    var options = {
      'title': 'Bedrijfsresultaat',
      'curveType': 'function',
      'legend': { 'position': 'bottom' },
      'vAxis': {'format': 'currency'}
    };

    var chart = new LineChart(document.getElementById('chart'));
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
