part of google_visualization_api.charts;

class ScatterChart extends Chart with _DiffChart {
  ScatterChart(Element e) : super._(e, "ScatterChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}