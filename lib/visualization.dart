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
part 'src/visualization/wrapper.dart';
part 'src/visualization/annotation_chart.dart';
part 'src/visualization/area_chart.dart';
part 'src/visualization/bar_chart.dart';
part 'src/visualization/bubble_chart.dart';
part 'src/visualization/calendar.dart';
part 'src/visualization/candlestick_chart.dart';
part 'src/visualization/column_chart.dart';
part 'src/visualization/combo_chart.dart';
part 'src/visualization/gauge.dart';
part 'src/visualization/geo_chart.dart';
part 'src/visualization/histogram.dart';
part 'src/visualization/line_chart.dart';
part 'src/visualization/map.dart';
part 'src/visualization/org_chart.dart';
part 'src/visualization/pie_chart.dart';
part 'src/visualization/sankey_diagram.dart';
part 'src/visualization/scatter_chart.dart';
part 'src/visualization/stepped_area_chart.dart';
part 'src/visualization/table.dart';
part 'src/visualization/timeline.dart';
part 'src/visualization/treemap.dart';
part 'src/visualization/wordtree.dart';

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
    if (options != null) {
      if (options is! JsObject) {
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
    //context["google"].callMethod('load', ['visualization', version, args]);
    context["google"]['charts'].callMethod('load', [version, args]);
    return c.future;
  }
}

abstract class _DiffChart {
  JsObject get jsChart;
  DataTable computeDiff(DataTable chartA, DataTable chartB) {
    return new DataTable.fromJsObject(
        jsChart.callMethod('computeDiff', [chartA.jsProxy, chartB.jsProxy]));
  }
}

// +select event
abstract class _SelectChart extends Chart {
  Stream get onSelect => _selectEventWrapper.onEvent;
  EventWrapper _selectEventWrapper;

  _SelectChart._(element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _selectEventWrapper = new EventWrapper(jsChart, 'select');
  }
}

// +ready event
abstract class _SelectReadyChart extends _SelectChart {
  Stream get onReady => _readyEventWrapper.onEvent;
  EventWrapper _readyEventWrapper;

  _SelectReadyChart._(element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _readyEventWrapper = new EventWrapper(jsChart, 'ready');
  }
}

// +error event
abstract class _SelectReadyErrorChart extends _SelectReadyChart {
  Stream<ErrorEventArgs> get onError => _errorEventWrapper.onEvent;
  EventWrapper<ErrorEventArgs> _errorEventWrapper;

  _SelectReadyErrorChart._(element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _errorEventWrapper = new EventWrapper<ErrorEventArgs>(
        jsChart, 'error', (p) => new ErrorEventArgs(p['id'], p['message']));
  }
}

// +mouse events
abstract class _SelectReadyErrorMouseChart extends _SelectReadyErrorChart {
  Stream<MouseEventArgs> get onMouseOver => _mouseOverWrapper.onEvent;
  EventWrapper<MouseEventArgs> _mouseOverWrapper;

  Stream<MouseEventArgs> get onMouseOut => _mouseOutWrapper.onEvent;
  EventWrapper<MouseEventArgs> _mouseOutWrapper;

  _SelectReadyErrorMouseChart._(element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _mouseOverWrapper = new EventWrapper<MouseEventArgs>(jsChart, 'onmouseover',
        (p) => new MouseEventArgs(p['row'], p['column']));
    _mouseOutWrapper = new EventWrapper<MouseEventArgs>(jsChart, 'onmouseout',
        (p) => new MouseEventArgs(p['row'], p['column']));
  }
}

// +click event
abstract class _SelectReadyErrorMouseClickChart
    extends _SelectReadyErrorMouseChart {
  Stream<ClickEventArgs> get onClick => _clickWrapper.onEvent;
  EventWrapper<ClickEventArgs> _clickWrapper;

  _SelectReadyErrorMouseClickChart._(element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _clickWrapper = new EventWrapper<ClickEventArgs>(
        jsChart, 'click', (p) => new ClickEventArgs(p['targetID']));
  }
}

// +animationfinish event
abstract class _SelectReadyErrorMouseClickAnimationChart
    extends _SelectReadyErrorMouseClickChart {
  Stream get onAnimationFinish => _animationFinishWrapper.onEvent;
  EventWrapper _animationFinishWrapper;

  _SelectReadyErrorMouseClickAnimationChart._(
      element, String chartName, JsObject ctx)
      : super._(element, chartName, vis) {
    _animationFinishWrapper = new EventWrapper(jsChart, 'animationfinish');
  }
}

abstract class CoreChart extends _SelectReadyErrorMouseClickAnimationChart {
  CoreChart._(element, String chartName) : super._(element, chartName, vis);

  void getImageURI() {}
}

class SelectedObject {
  JsObject _jsObject;

  int get row => _jsObject['row'];

  int get column => _jsObject['column'];

  SelectedObject(this._jsObject);
}

class SelectionObjects implements Iterator<SelectedObject> {
  JsObject _jsObject;

  int get length => _jsObject['length'];

  int _current = -1;

  SelectionObjects(this._jsObject);

  bool moveNext() {
    return (_current++) < length;
  }

  SelectedObject get current => new SelectedObject(_jsObject[_current]);
}

abstract class CoreSelection {
  JsObject get jsChart;

  SelectionObjects getSelection() {
    return new SelectionObjects(jsChart.callMethod('getSelection'));
  }

  void setSelection() {}
}

abstract class CoreActions {
  JsObject get jsChart;

  void getAction();

  void setAction();

  void removeAction();
}
