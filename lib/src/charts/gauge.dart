part of google_visualization_api.charts;

class Gauge extends Chart {
  Gauge(Element e) : super._(e, "Gauge", vis) {

  }

  static Future load() {
    return Chart.load(['gauge']);
  }
}