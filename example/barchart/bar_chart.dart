import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

/// Taken from https://developers.google.com/chart/interactive/docs/gallery/barchart
void main() {
  Bar.load().then((_) {
    var data = arrayToDataTable([
      ['Galaxy', 'Distance', 'Brightness'],
      ['Canis Major Dwarf', 8000, 23.3],
      ['Sagittarius Dwarf', 24000, 4.5],
      ['Ursa Major II Dwarf', 30000, 14.3],
      ['Lg. Magellanic Cloud', 50000, 0.9],
      ['Bootes I', 60000, 13.1]
    ]);

    var options = {
      'width': 900,
      'chart': {
        'title': 'Nearby galaxies',
        'subtitle': 'distance on the left, brightness on the right'
      },
      'bars': 'horizontal', // Required for Material Bar Charts.
      'series': {
        0: {'axis': 'distance'}, // Bind series 0 to an axis named 'distance'.
        1: {
          'axis': 'brightness'
        } // Bind series 1 to an axis named 'brightness'.
      },
      'axes': {
        'x': {
          'distance': {'label': 'parsecs'}, // Bottom x-axis.
          'brightness': {
            'side': 'top',
            'label': 'apparent magnitude'
          } // Top x-axis.
        }
      }
    };

    var chart = new Bar(document.getElementById('dual_x_div'));
    chart.draw(data, options);
  });

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
