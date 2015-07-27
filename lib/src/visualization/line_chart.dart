part of google_visualization_api.charts;

class LineChart extends _SelectReadyErrorMouseClickAnimationChart with CoreSelection {
  LineChart(Element e) : super._(e, "LineChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}