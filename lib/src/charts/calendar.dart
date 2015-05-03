part of google_visualization_api.charts;

class Calendar extends Chart {
  Calendar(Element e) : super._(e, "Calendar", vis) {

  }

  static Future load() {
    return Chart.load(['calendar']);
  }
}