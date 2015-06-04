/// Example taken from the official website at
/// https://developers.google.com/chart/interactive/docs/gallery/histogram#Example1

import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  OrgChart.load().then((_) {
    var data = new DataTable();
    data.addColumn('string', 'Name');
    data.addColumn('string', 'Manager');
    data.addColumn('string', 'ToolTip');

    data.addRows([
      [
        {
          'v': 'Mike',
          'f': 'Mike<div style="color:red; font-style:italic">President</div>'
        },
        '',
        'The President'
      ],
      [
        {
          'v': 'Jim',
          'f': 'Jim<div style="color:red; font-style:italic">Vice President</div>'
        },
        'Mike',
        'VP'
      ],
      ['Alice', 'Mike', ''],
      ['Bob', 'Jim', 'Bob Sponge'],
      ['Carol', 'Bob', '']
    ]);

    var chart = new OrgChart(document.getElementById('chart_div'));
    chart.draw(data, {'allowHtml': true});
  });
}
