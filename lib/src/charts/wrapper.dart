part of google_visualization_api.charts;

class ChartWrapper {
  ChartWrapper([spec]) {
    if (spec is String) {} else if (spec is ChartSpec) {}
  }

  void draw([Element container_ref]) {}
}
