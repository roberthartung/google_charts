part of google_visualization_api.charts;

class AreaChart extends Chart {
  AreaChart(Element e) : super._(e, "AreaChart", vis) {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}