part of google_visualization_api.charts;

/// ColumnCharts
class ColumnChart extends Chart {
  ColumnChart(Element e) : super._(e, "ColumnChart", vis) {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}

/// Material Column Charts
/// Experimental
class Bar extends Chart {
  Bar(Element e) : super._(e, "Bar", charts) {

  }

  /// TODO(rh): Convert options according to https://developers.google.com/chart/interactive/docs/gallery/columnchart#Material
  /// chart.draw(data, options);
  /// to
  /// chart.draw(data, google.charts.Column.convertOptions(options));

  static Future load() {
    return Chart.load(['bar']);
  }
}