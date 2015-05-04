library google_visualization_api.charts;

/// Dart libraries
import 'dart:core' as core;
import 'dart:core';
import 'dart:html';
import 'dart:async';
import 'dart:js';

/// Internal
import 'google_visualization_api_base.dart';
import 'google_visualization_api_static.dart';

/// Parts
part 'charts/annotation_chart.dart';
part 'charts/area_chart.dart';
part 'charts/bar_chart.dart';
part 'charts/bubble_chart.dart';
part 'charts/calendar.dart';
part 'charts/candlestick_chart.dart';
part 'charts/column_chart.dart';
part 'charts/combo_chart.dart';
part 'charts/gauge.dart';
part 'charts/geo_chart.dart';
part 'charts/histogram.dart';
part 'charts/line_chart.dart';
part 'charts/map.dart';
part 'charts/org_chart.dart';
part 'charts/pie_chart.dart';
part 'charts/sankey_diagram.dart';
part 'charts/scatter_chart.dart';
part 'charts/stepped_area_chart.dart';
part 'charts/table.dart';
part 'charts/timeline.dart';
part 'charts/treemap.dart';
part 'charts/wordtree.dart';

/// Chart base
abstract class Chart {
  /// The instance of the chart in the javascript scope
  JsObject jsChart;

  Chart._(element, String chartName, JsObject ctx) : jsChart = new JsObject(ctx[chartName], [element]);

  void draw(data, [core.Map options = null]) {
    // final data = [['Label', 'Value'], ['A', 0]];
    // var jsTable = ns.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    var jsOptions = options == null ? null : new JsObject.jsify(options);
    if(data is DataTable) {
      jsChart.callMethod('draw', [data.jsProxy, jsOptions]);
    } else {
      print('err');
    }
  }

  void clearChart() {
    jsChart.callMethod('clearChart');
  }

  static Future load(List<String> packages, [String version = "1"]) {
    Completer c = new Completer();
    context["google"].callMethod('load', [
      'visualization',
      version,
      new JsObject.jsify({
        'packages': packages,
        'callback': new JsFunction.withThis(c.complete)
      })
    ]);
    return c.future;
  }
}

abstract class Selection {
  JsObject get jsChart;

  List getSelection() {
    return null;
  }

  void setSelection() {

  }
}

abstract class Actions {
  JsObject get jsChart;

  void getAction();

  void setAction();

  void removeAction();
}

abstract class CoreChart {
  ///
  void getImageURI() {

  }
}