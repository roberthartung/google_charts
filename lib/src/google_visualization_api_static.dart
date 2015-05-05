library google_visualization_api.static;

import 'dart:js';
import 'google_visualization_api_base.dart';

part 'static/events.dart';
/// TODO(rh): Add error.dart
/// TODO(rh): Add data.dart

/// The google.visualization namespace
final JsObject vis = context["google"]["visualization"];
final JsObject charts = context["google"]["charts"];

DataTable arrayToDataTable(List<List> twoDArray, [bool firstRowIsData]) {
  return new DataTable.fromJsObject(vis.callMethod('arrayToDataTable', [new JsObject.jsify(twoDArray), firstRowIsData]));
}

/// TODO(rh): drawChart

/// TODO(rh): drawToolbar