part of google_visualization_api.charts;

class ScatterChart extends Chart {
  ScatterChart(Element e) : super._(e, "ScatterChart", vis) {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}

/// Experimental
class Scatter extends Chart {
  Scatter(Element e) : super._(e, "Scatter", charts) {

  }

  static Future load() {
    return Chart.load(['scatter'], "1.1");
  }
}