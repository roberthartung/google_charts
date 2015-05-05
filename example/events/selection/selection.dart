/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/gauge#Example

import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart'
    show PieChart, DataTable, arrayToDataTable, MouseEventArgs, ClickEventArgs;

void main() {
  PieChart.load().then((_) {
    var data = arrayToDataTable([
      ['Task', 'Hours per Day'],
      ['Work', 11],
      ['Eat', 2],
      ['Commute', 2],
      ['Watch TV', 2],
      ['Sleep', 7]
    ]);

    var options = {'title': 'My Daily Activities', 'pieHole': 0.4};

    PieChart chart = new PieChart(document.getElementById('donutchart'));
    chart.draw(data, options);

    onSelect(ev) {
      print('selection...');
    }

    onMouseOver(MouseEventArgs args) {
      print('MouseOver at row/column: ${args.row}/${args.column}');
    }

    onClick(ClickEventArgs args) {
      print('Click at target ${args.targetId}');
    }

    chart.onSelect.listen(onSelect);
    chart.onMouseOver.listen(onMouseOver);
    chart.onClick.listen(onClick);
  });
}
