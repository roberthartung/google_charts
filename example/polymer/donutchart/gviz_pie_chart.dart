import 'package:google_charts/google_charts.dart'
    show PieChart,  arrayToDataTable;
import 'package:polymer/polymer.dart';

@PolymerRegister('gviz-pie-chart')
class GvizPieChart extends PolymerElement {
  GvizPieChart.created() : super.created() {}

  void ready() {
    PieChart.load().then((_) {
      var data = arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Work',     11],
        ['Eat',      2],
        ['Commute',  2],
        ['Watch TV', 2],
        ['Sleep',    7]
      ]);

      var options = {
        'title': 'My Daily Activities',
        'pieHole': 0.4,
        'forceIFrame': true
      };

      var chart = new PieChart($['donutchart']);
      chart.draw(data, options);
    });
  }
}
