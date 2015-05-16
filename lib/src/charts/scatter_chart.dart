part of google_visualization_api.charts;

class ScatterChart extends Chart {
  ScatterChart(Element e) : super._(e, "ScatterChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}

/// Experimental
class Scatter extends Chart {
  Scatter(Element e) : super._(e, "Scatter", charts) {

  }

  static Future load() {
    return Chart.load(packages: ['scatter'], version: "1.1");
  }
}