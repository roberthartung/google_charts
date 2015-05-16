part of google_visualization_api.base;

class NumberFormatOptions {
  /// A character to use as the decimal marker. The default is a dot (.).
  var decimalSymbol;

  /// A number specifying how many digits to display after the decimal. The
  /// default is 2. If you specify more digits than the number contains, it will
  /// display zeros for the smaller values. Truncated values will be rounded
  /// (5 rounded up).
  var fractionDigits;

  /// A character to be used to group digits to the left of the decimal into
  /// sets of three. Default is a comma (,).
  var groupingSymbol;

  /// The text color for negative values. No default value. Values can be any
  /// acceptable HTML color value, such as "red" or "#FF0000".
  var negativeColor;

  /// A boolean, where true indicates that negative values should be surrounded
  /// by parentheses. Default is true.
  var negativeParens;

  /// A format string. When provided, all other options are ignored, except
  /// negativeColor.
  ///
  /// The format string is a subset of the ICU pattern set . For instance,
  /// {pattern:'#,###%'} will result in output values "1,000%", "750%", and
  /// "50%" for values 10, 7.5, and 0.5.
  var pattern;

  /// A string prefix for the value, for example "$".
  var prefix;

  /// A string suffix for the value, for example "%".
  var suffix;

  NumberFormatOptions({String this.decimalSymbol: '.',
      int this.fractionDigits: 2, String this.groupingSymbol: ',',
      String this.negativeColor: null, bool this.negativeParens: true,
      String this.pattern, String this.prefix, String this.suffix});

  Map _toMap() {
    Map m = {
      'decimalSymbol': decimalSymbol,
      'fractionDigits': fractionDigits,
      'groupingSymbol': groupingSymbol,
      'negativeParens': negativeParens
    };
    if (negativeColor != null) {
      m['negativeColor'] = negativeColor;
    }
    if (pattern != null) {
      m['pattern'] = pattern;
    }
    if (prefix != null) {
      m['prefix'] = prefix;
    }
    if (suffix != null) {
      m['suffix'] = suffix;
    }
    return m;
  }
}

class NumberFormat {
  JsObject _jsObject;

  NumberFormat(options) {
    if (options is Map) {
      _jsObject =
          new JsObject(vis['NumberFormat'], [new JsObject.jsify(options)]);
    } else if (options is NumberFormatOptions) {
      _jsObject = new JsObject(
          vis['NumberFormat'], [new JsObject.jsify(options._toMap())]);
    } else {
      throw new ArgumentError.value(options, 'options');
    }
  }

  /// The standard [format] method to apply formatting to the specified
  /// [columnIndex].
  void format(DataTable dataTable, int columnIndex) {
    _jsObject.callMethod('format', [dataTable.jsProxy, columnIndex]);
  }

  formatValue(value) {
    return _jsObject.callMethod('formatValue', [value]);
  }
}
