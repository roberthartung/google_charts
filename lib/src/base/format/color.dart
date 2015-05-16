part of google_visualization_api.base;

class ColorFormat {
  JsObject _jsObject;

  ColorFormat() {
    _jsObject = new JsObject(vis['ColorFormat']);
  }

  /// Specifies a foreground color and/or background color to a cell, depending
  /// on the cell value. Any cell with a value in the specified from—to range
  /// will be assigned color and bgcolor. It is important to realize that the
  /// range is non-inclusive, because creating a range from 1—1,000 and a second
  /// from 1,000— 2,000 will not cover the value 1,000!
  ///
  /// - [from] : (String, Number, Date, DateTime, or TimeOfDay) The lower
  ///   boundary (inclusive) of the range, or null. If null, it will match -∞.
  ///   String boundaries are compared alphabetically against string values.
  /// - [to] : (String, Number, Date, DateTime, or TimeOfDay) The high boundary
  ///   (non-inclusive) of the range, or null. If null, it will match +∞. String
  ///   boundaries are compared alphabetically against string values.
  /// - [color] : The color to apply to text in matching cells. Values can be
  ///   either '#RRGGBB' values or defined color constants, (example: '#FF0000'
  ///   or 'red').
  /// - [bgcolor] : The color to apply to the background of matching cells.
  ///   Values can be either '#RRGGBB' values or defined color constants,
  ///   (example: '#FF0000' or 'red').
  void addRange(from, to, color, bgcolor) {
    _jsObject.callMethod('addRange', [from, to, color, bgcolor]);
  }

  /// Assigns a background color from a range, according to the cell value. The
  /// color is scaled to match the cell's value within a range from a lower
  /// boundary color to an upper boundary color. Note that this method cannot
  /// compare string values, as addRange() can. Tip: Color ranges are often hard
  /// for viewers to gauge accurately; the simplest and easiest to read range is
  /// from a fully saturated color to white (e.g., #FF0000—FFFFFF).
  ///
  /// - [from] : (Number, Date, DateTime, or TimeOfDay) The lower boundary
  ///   (inclusive) of the range, or null. If null, it will match -∞.
  /// - [to] : [Number, Date, DateTime, or TimeOfDay] The higher boundary
  ///   (non-inclusive) of the range, or null. If null, it will match +∞.
  /// - [color] : The color to apply to text in matching cells. This color is
  ///   the same for all cells, no matter what their value.
  /// - [fromBgColor] : The background color for cells holding values at the
  ///   low end of the gradient. Values can be either '#RRGGBB' values or
  ///   defined color constants, (example: '#FF0000' or 'red').
  /// - [toBgColor] : The background color for cells holding values at the high
  ///   end of the gradient. Values can be either '#RRGGBB' values or defined
  ///   color constants, (example: '#FF0000' or 'red').
  void addGradientRange(from, to, color, fromBgColor, toBgColor) {
    _jsObject.callMethod('addRange', [from, to, color, fromBgColor, toBgColor]);
  }

  /// The standard [format] method to apply formatting to the specified
  /// [columnIndex].
  void format(DataTable dataTable, int columnIndex) {
    _jsObject.callMethod('format', [dataTable.jsProxy, columnIndex]);
  }
}
