part of google_visualization_api.charts;

class AnnotationChart extends Chart {
  AnnotationChart(Element e) : super._(e, "AnnotationChart") {

  }

  static Future load() {
    return Chart.load(['annotationchart']);
  }
}