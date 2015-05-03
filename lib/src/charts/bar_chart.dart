part of google_visualization_api.charts;

class BarChart extends Chart {
  BarChart(Element e) : super._(e, "BarChart", vis) {

  }

  static Future load() {
    return Chart.load(['bar']);
  }
}