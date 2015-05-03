part of google_visualization_api.charts;

class Table extends Chart {
  Table(Element e) : super._(e, "Table", vis) {

  }

  static Future load() {
    return Chart.load(['table']);
  }
}