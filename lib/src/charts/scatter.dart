part of charts;

/// Material Column Charts
/// Experimental
class Scatter extends Chart {
  Scatter(Element e) : super._(e, "Scatter", charts);

  static Future load() {
    return Chart.load(packages: ['scatter'], version: "1.1");
  }

  /// Converts regular options to Material chart options.
  ///
  /// Note: This requires to call [load] before.
  static JsObject convertOptions(options) {
    return charts['Scatter'].callMethod(
        'convertOptions', [new JsObject.jsify(options)]);
  }
}
