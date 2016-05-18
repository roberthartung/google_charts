part of charts;

/// Material Column Charts
/// Experimental
class Line extends Chart {
  Line(Element e) : super._(e, "Line", charts) {}

  static Future load() {
    return Chart.load(packages: ['line']);
  }

  /// Converts regular options to Material chart options.
  ///
  /// Note: This requires to call [load] before.
  static JsObject convertOptions(options) {
    return charts['Line'].callMethod(
        'convertOptions', [new JsObject.jsify(options)]);
  }
}
