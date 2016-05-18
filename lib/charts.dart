library charts;

/// Dart libraries
import 'dart:core' as core;
import 'dart:core';
import 'dart:html';
import 'dart:async';
import 'dart:js';

/// Internal
import 'base.dart';
import 'static.dart';

part 'src/charts/bar.dart';
part 'src/charts/line.dart';
part 'src/charts/scatter.dart';

/// Chart base that has no events
abstract class Chart {
/// The instance of the chart in the javascript scope
  JsObject jsChart;

  Chart._(element, String chartName, JsObject ctx)
      : jsChart = new JsObject(ctx[chartName], [element]);

  void draw(data, [options = null]) {
    // final data = [['Label', 'Value'], ['A', 0]];
    // var jsTable = ns.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    var jsOptions = null;
    // core.Map
    if(options != null) {
      if(options is! JsObject) {
        jsOptions = new JsObject.jsify(options);
      } else {
        jsOptions = options;
      }
    }

    // var jsOptions = options == null ? null : new JsObject.jsify(options);
    if (data is DataTable || data is DataView) {
      jsChart.callMethod('draw', [data.jsProxy, jsOptions]);
    } else {
      throw new ArgumentError.value(data, 'data');
    }
  }

  void clearChart() {
    jsChart.callMethod('clearChart');
  }

  static Future load({List<String> packages, String version: "current"}) {
    Completer c = new Completer();
    JsObject args;
    if (packages != null) {
      args = new JsObject.jsify({
        'packages': packages,
        'callback': new JsFunction.withThis(c.complete)
      });
    } else {
      args =
          new JsObject.jsify({'callback': new JsFunction.withThis(c.complete)});
    }
    // context["google"].callMethod('load', ['visualization', version, args]);
    // google.charts.load("", {packages:["corechart"]});
    context["google"]['charts'].callMethod('load', [version, args]);
    return c.future;
  }
}
