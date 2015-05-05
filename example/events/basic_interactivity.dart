/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/gauge#Example

import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart'
    show PieChart, DataTable, arrayToDataTable, SelectEvent;

void main() {
  PieChart.load().then((_) {
    // Create the data table.
    var data = new DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([
      ['Mushrooms', 3],
      ['Onions', 1],
      ['Olives', 1],
      ['Zucchini', 1],
      ['Pepperoni', 2]
    ]);

    // Set chart options
    var options = {
      'title': 'How Much Pizza I Ate Last Night',
      'width': 400,
      'height': 300
    };

    // Instantiate and draw our chart, passing in some options.
    var chart = new PieChart(document.getElementById('chart_div'));

    selectHandler(_) {
      var selectedItem = chart.getSelection()[0];
      if (selectedItem != null) {
        var topping = data.getValue(selectedItem['row'], 0);
        window.alert('The user selected ' + topping);
      }
    }

    chart.onSelect.listen(selectHandler);
    chart.draw(data, options);
  });
}
