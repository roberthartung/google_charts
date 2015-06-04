import 'dart:html';
import 'package:google_charts/google_charts.dart';

/// Taken from https://developers.google.com/chart/interactive/docs/gallery/barchart
void main() {
  BarChart.load().then((_) {
    var data = arrayToDataTable([
        ["Element", "Density", { 'role': "style" } ],
        ["Copper", 8.94, "#b87333"],
        ["Silver", 10.49, "silver"],
        ["Gold", 19.30, "gold"],
        ["Platinum", 21.45, "color: #e5e4e2"]
      ]);

      var view = new DataView(data);
      view.setColumns([0, 1,
                       { 'calc': "stringify",
                         'sourceColumn': 1,
                         'type': "string",
                         'role': "annotation" },
                       2]);

      var options = {
        'title': "Density of Precious Metals, in g/cm^3",
        'width': 600,
        'height': 400,
        'bar': {'groupWidth': "95%"},
        'legend': { 'position': "none" },
      };
      var chart = new BarChart(document.getElementById("barchart_values"));
      chart.draw(view, options);
  });
}
