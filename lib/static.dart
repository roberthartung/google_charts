library google_visualization_api.static;

import 'dart:js';
import 'dart:html';

import 'base.dart';

/// TODO(rh): Add error.dart
/// TODO(rh): Add data.dart

/// The google.visualization namespace
final JsObject vis = context["google"]["visualization"];
final JsObject charts = context["google"]["charts"];

class ChartSpec {
  var chartType;

  var containerId;

  var options;

  DataTable dataTable;

  var dataSourceUrl;

  var query;

  var refreshInterval;

  var view;

  ChartSpec(String this.chartType, String this.containerId, {Map this.options,
      DataTable this.dataTable, String this.dataSourceUrl, String this.query,
      this.refreshInterval, this.view});

  Map toMap() {
    Map m = {'chartType': chartType, 'containerId': containerId};

    if (options != null) {
      m['options'] = options;
    }
    if (dataTable != null) {
      m['dataTable'] = dataTable.jsProxy;
    }
    if (dataSourceUrl != null) {
      m['dataSourceUrl'] = dataSourceUrl;
    }
    if (query != null) {
      m['query'] = query;
    }
    if (refreshInterval != null) {
      m['refreshInterval'] = refreshInterval;
    }
    if (view != null) {
      m['view'] = view;
    }

    return m;
  }
}

DataTable arrayToDataTable(List<List> twoDArray, [bool firstRowIsData]) {
  return new DataTable.fromJsObject(vis.callMethod(
      'arrayToDataTable', [new JsObject.jsify(twoDArray), firstRowIsData]));
}

void drawChart(spec) {
  if(spec is ChartSpec) {
    vis.callMethod('drawChart', [spec.toMap()]);
  } else if(spec is Map) {
    vis.callMethod('drawChart', [new JsObject.jsify(spec)]);
  } else if(spec is String) {
    vis.callMethod('drawChart', [spec]);
  } else {
    throw new ArgumentError.value(spec, 'spec');
  }
}

void drawToolbar(Element element, List<Map> components) {
  vis.callMethod('drawToolbar', [element, new JsObject.jsify(components)]);
}
