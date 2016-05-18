import 'dart:html';
import 'package:google_charts/google_charts.dart';

/// Taken from https://developers.google.com/chart/interactive/docs/gallery/barchart
void main() {
  Bar.load().then((_) {
    print('load1');

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
    /*
  });

  Bar.load().then((_) {
    */
    print('load2');
    var data2 = arrayToDataTable([
      ['Year', 'Sales', 'Expenses', 'Profit'],
      ['2014', 1000, 400, 200],
      ['2015', 1170, 460, 250],
      ['2016', 660, 1120, 300],
      ['2017', 1030, 540, 350]
    ]);

    var options2 = {
      'chart': {
        'title': 'Company Performance',
        'subtitle': 'Sales, Expenses, and Profit: 2014-2017',
      },
      'bars': 'horizontal' // Required for Material Bar Charts.
    };

    var chart2 = new Bar(document.getElementById('barchart_material'));
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
    chart2.draw(data2, options2);
  });
}
