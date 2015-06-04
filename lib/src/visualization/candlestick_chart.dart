part of google_visualization_api.charts;

class CandlestickChart extends Chart {
  CandlestickChart(Element e) : super._(e, "CandlestickChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['corechart']);
  }
}