library google_visualization_api.charts;

/// Dart libraries
import 'dart:html';
import 'dart:async';
import 'dart:js';

/// Internal
import 'google_visualization_api_base.dart';

/// Parts
part 'charts/stepped_area_chart.dart';
part 'charts/line_chart.dart';
part 'charts/area_chart.dart';

/// Chart base
abstract class Chart {
  /// The google.visualization namespace
  static final ns = context["google"]["visualization"];

  /// The instance of the chart in the javascript scope
  var jsChart;

  Chart._(element, String chartName) : jsChart = new JsObject(ns[chartName], [element]);

  void draw(data, [Map options = null]) {
    // final data = [['Label', 'Value'], ['A', 0]];
    // var jsTable = ns.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    var jsOptions = options == null ? null : new JsObject.jsify(options);
    if(data is DataTable) {
      jsChart.callMethod('draw', [data.jsProxy, jsOptions]);
    } else {
      print('err');
    }
  }

  static Future load(List<String> packages) {
    Completer c = new Completer();
    context["google"].callMethod('load', [
      'visualization',
      '1',
      new JsObject.jsify({
        'packages': packages,
        'callback': new JsFunction.withThis(c.complete)
      })
    ]);
    return c.future;
  }
}
