part of google_visualization_api.charts;

class Map extends Chart {
  Map(Element e) : super._(e, "Map", vis) {

  }

  static Future load() {
    return Chart.load(['map']);
  }
}