part of google_visualization_api.charts;

class WordTree extends Chart {
  WordTree(Element e) : super._(e, "WordTree", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['wordtree']);
  }
}