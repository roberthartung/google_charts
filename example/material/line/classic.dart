import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  Line.load().then((_) {
    var data = new DataTable();
    data.addColumn('date', 'Month');
    data.addColumn('number', "Average Temperature");
    data.addColumn('number', "Average Hours of Daylight");

    data.addRows([
      [new DateTime(2014, 0),  -.5,  5.7],
      [new DateTime(2014, 1),   .4,  8.7],
      [new DateTime(2014, 2),   .5,   12],
      [new DateTime(2014, 3),  2.9, 15.3],
      [new DateTime(2014, 4),  6.3, 18.6],
      [new DateTime(2014, 5),    9, 20.9],
      [new DateTime(2014, 6), 10.6, 19.8],
      [new DateTime(2014, 7), 10.3, 16.6],
      [new DateTime(2014, 8),  7.4, 13.3],
      [new DateTime(2014, 9),  4.4,  9.9],
      [new DateTime(2014, 10), 1.1,  6.6],
      [new DateTime(2014, 11), -.2,  4.5]
    ]);

    var classicOptions = {
      'title': 'Average Temperatures and Daylight in Iceland Throughout the Year',
      'width': 900,
      'height': 500,
      // Gives each series an axis that matches the vAxes number below.
      'series': {
        0: {'targetAxisIndex': 0},
        1: {'targetAxisIndex': 1}
      },
      'vAxes': {
        // Adds titles to each axis.
        0: {'title': 'Temps (Celsius)'},
        1: {'title': 'Daylight'}
      },
      'hAxis': {
        'ticks': [new DateTime(2014, 0), new DateTime(2014, 1), new DateTime(2014, 2), new DateTime(2014, 3),
                new DateTime(2014, 4),  new DateTime(2014, 5), new DateTime(2014, 6), new DateTime(2014, 7),
                new DateTime(2014, 8), new DateTime(2014, 9), new DateTime(2014, 10), new DateTime(2014, 11)
               ]
      },
      'vAxis': {
        'viewWindow': {
          'max': 30
        }
      }
    };

    var classicChart = new Line(document.getElementById('classic'));
    classicChart.draw(data, Line.convertOptions(classicOptions));
  });
}
