part of charts;

/// Material Column Charts
/// Experimental
class Bar extends Chart {
  Bar(Element e) : super._(e, "Bar", charts) {}

  static Future load() {
    return Chart.load(packages: ['bar']);
  }

  /// Converts regular options to Material chart options.
  ///
  /// Note: This requires to call [load] before.
  static JsObject convertOptions(options) {
    return charts['Bar'].callMethod(
        'convertOptions', [new JsObject.jsify(options)]);
  }
}
