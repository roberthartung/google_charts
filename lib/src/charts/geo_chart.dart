part of google_visualization_api.charts;

class GeoChart extends Chart {
  GeoChart(Element e) : super._(e, "GeoChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['geochart']);
  }
}