library google_visualization_api.charts;

/// Dart libraries
import 'dart:core' as core;
import 'dart:core';
import 'dart:html';
import 'dart:async';
import 'dart:js';

/// Internal
import 'base.dart';
import 'static.dart';
import 'events.dart';

/// Parts
part 'src/charts/wrapper.dart';
part 'src/charts/annotation_chart.dart';
part 'src/charts/area_chart.dart';
part 'src/charts/bar_chart.dart';
part 'src/charts/bubble_chart.dart';
part 'src/charts/calendar.dart';
part 'src/charts/candlestick_chart.dart';
part 'src/charts/column_chart.dart';
part 'src/charts/combo_chart.dart';
part 'src/charts/gauge.dart';
part 'src/charts/geo_chart.dart';
part 'src/charts/histogram.dart';
part 'src/charts/line_chart.dart';
part 'src/charts/map.dart';
part 'src/charts/org_chart.dart';
part 'src/charts/pie_chart.dart';
part 'src/charts/sankey_diagram.dart';
part 'src/charts/scatter_chart.dart';
part 'src/charts/stepped_area_chart.dart';
part 'src/charts/table.dart';
part 'src/charts/timeline.dart';
part 'src/charts/treemap.dart';
part 'src/charts/wordtree.dart';

/// Chart base that has no events
abstract class Chart {
  /// The instance of the chart in the javascript scope
  JsObject jsChart;

  Chart._(element, String chartName, JsObject ctx) : jsChart = new JsObject(ctx[chartName], [element]);

  void draw(data, [core.Map options = null]) {
    // final data = [['Label', 'Value'], ['A', 0]];
    // var jsTable = ns.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    var jsOptions = options == null ? null : new JsObject.jsify(options);
    if(data is DataTable || data is DataView) {
      jsChart.callMethod('draw', [data.jsProxy, jsOptions]);
    } else {
      throw new ArgumentError.value(data, 'data');
    }
  }

  void clearChart() {
    jsChart.callMethod('clearChart');
  }

  static Future load({List<String> packages, String version: "1"}) {
    Completer c = new Completer();
    JsObject args;
    if(packages != null) {
      args = new JsObject.jsify({
        'packages': packages,
        'callback': new JsFunction.withThis(c.complete)
      });
    } else {
      args = new JsObject.jsify({
        'callback': new JsFunction.withThis(c.complete)
      });
    }
    context["google"].callMethod('load', [
      'visualization',
      version,
      args
    ]);
    return c.future;
  }
}

abstract class _DiffChart {
  JsObject get jsChart;
  DataTable computeDiff(DataTable chartA, DataTable chartB) {
    return new DataTable.fromJsObject(jsChart.callMethod('computeDiff', [chartA.jsProxy, chartB.jsProxy]));
  }
}

// +select event
abstract class _SelectChart extends Chart {
  Stream get onSelect => _selectEventWrapper.onEvent;
  EventWrapper _selectEventWrapper;

  _SelectChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _selectEventWrapper = new EventWrapper(jsChart, 'select');
  }
}

// +ready event
abstract class _SelectReadyChart extends _SelectChart {
  Stream get onReady => _readyEventWrapper.onEvent;
  EventWrapper _readyEventWrapper;

  _SelectReadyChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _readyEventWrapper = new EventWrapper(jsChart, 'ready');
  }
}

// +error event
abstract class _SelectReadyErrorChart extends _SelectReadyChart {
  Stream<ErrorEventArgs> get onError => _errorEventWrapper.onEvent;
  EventWrapper<ErrorEventArgs> _errorEventWrapper;

  _SelectReadyErrorChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _errorEventWrapper = new EventWrapper<ErrorEventArgs>(jsChart, 'error', (p) => new ErrorEventArgs(p['id'], p['message']));
  }
}

// +mouse events
abstract class _SelectReadyErrorMouseChart extends _SelectReadyErrorChart {
  Stream<MouseEventArgs> get onMouseOver => _mouseOverWrapper.onEvent;
  EventWrapper<MouseEventArgs> _mouseOverWrapper;

  Stream<MouseEventArgs> get onMouseOut => _mouseOutWrapper.onEvent;
  EventWrapper<MouseEventArgs> _mouseOutWrapper;

  _SelectReadyErrorMouseChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _mouseOverWrapper = new EventWrapper<MouseEventArgs>(jsChart, 'onmouseover', (p) => new MouseEventArgs(p['row'], p['column']));
    _mouseOutWrapper = new EventWrapper<MouseEventArgs>(jsChart, 'onmouseout', (p) => new MouseEventArgs(p['row'], p['column']));
  }
}

// +click event
abstract class _SelectReadyErrorMouseClickChart extends _SelectReadyErrorMouseChart {
  Stream<ClickEventArgs> get onClick => _clickWrapper.onEvent;
  EventWrapper<ClickEventArgs> _clickWrapper;

  _SelectReadyErrorMouseClickChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _clickWrapper = new EventWrapper<ClickEventArgs>(jsChart, 'click', (p) => new ClickEventArgs(p['targetID']));
  }
}

// +animationfinish event
abstract class _SelectReadyErrorMouseClickAnimationChart extends _SelectReadyErrorMouseClickChart {
  Stream get onAnimationFinish => _animationFinishWrapper.onEvent;
  EventWrapper _animationFinishWrapper;

  _SelectReadyErrorMouseClickAnimationChart._(element, String chartName, JsObject ctx) : super._(element, chartName, vis) {
    _animationFinishWrapper = new EventWrapper(jsChart, 'animationfinish');
  }
}

abstract class CoreChart extends _SelectReadyErrorMouseClickAnimationChart {
  CoreChart._(element, String chartName) : super._(element, chartName, vis);

  void getImageURI() {

  }
}

abstract class CoreSelection {
  JsObject get jsChart;

  getSelection() {
    return jsChart.callMethod('getSelection');
  }

  void setSelection() {

  }
}

abstract class CoreActions {
  JsObject get jsChart;

  void getAction();

  void setAction();

  void removeAction();
}