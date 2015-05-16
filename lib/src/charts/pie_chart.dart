part of google_visualization_api.charts;

class PieChart extends _SelectReadyErrorMouseClickAnimationChart with CoreSelection {
  PieChart(Element e) : super._(e, "PieChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}