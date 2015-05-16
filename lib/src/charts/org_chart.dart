part of google_visualization_api.charts;

class OrgChart extends Chart {
  OrgChart(Element e) : super._(e, "OrgChart", vis) {

  }

  static Future load() {
    return Chart.load(packages: ['orgchart']);
  }
}