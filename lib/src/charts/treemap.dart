part of google_visualization_api.charts;

class TreeMap extends Chart {
  TreeMap(Element e) : super._(e, "TreeMap", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['treemap']);
  }
}