part of google_visualization_api.charts;

class ComboChart extends Chart {
  ComboChart(Element e) : super._(e, "ComboChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}