part of google_visualization_api.charts;

class Timeline extends Chart {
  Timeline(Element e) : super._(e, "Timeline", vis) {

  }

  static Future load() {
    return Chart.load(['timeline']);
  }
}