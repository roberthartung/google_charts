part of google_visualization_api.charts;

class SankeyDiagram extends Chart with CoreChart, Selection, Events {
  SankeyDiagram(Element e) : super._(e, "Sankey", vis) {

  }

  static Future load() {
    return Chart.load(['sankey']);
  }
}