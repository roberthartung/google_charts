part of google_visualization_api.charts;

class BubbleChart extends Chart {
  BubbleChart(Element e) : super._(e, "BubbleChart", vis) {

  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}