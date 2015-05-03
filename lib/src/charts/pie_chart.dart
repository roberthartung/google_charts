part of google_visualization_api.charts;

class PieChart extends Chart with CoreChart {
  PieChart(Element e) : super._(e, "PieChart", vis) {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}