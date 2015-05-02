part of google_visualization_api.charts;

class ColumnChart extends Chart {
  ColumnChart(Element e) : super._(e, "ColumnChart") {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}