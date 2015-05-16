part of google_visualization_api.base;

class BarFormatOptions {
  var base;

  var colorNegative;

  var colorPositive;

  var drawZeroLine;

  var min;

  var max;

  var showValue;

  var width;

  BarFormatOptions({int this.base: 0, String this.colorNegative: 'red',
      this.colorPositive: 'blue', bool this.drawZeroLine: false, num this.min,
      num this.max, bool this.showValue: true, int this.width: 100});

  Map _toMap() {
    Map m = {
      'base': base,
      'colorNegative': colorNegative,
      'colorPositive': colorPositive,
      'drawZeroLine': drawZeroLine,
      'showValue': showValue,
      'width': width,
    };
    if (min != null) {
      m['min'] = min;
    }
    if (max != null) {
      m['max'] = max;
    }
    return m;
  }
}

class BarFormat {
  JsObject _jsObject;

  BarFormat(options) {
    if (options is Map) {
      _jsObject = new JsObject(vis['BarFormat'], [new JsObject.jsify(options)]);
    } else if (options is BarFormatOptions) {
      _jsObject = new JsObject(
          vis['BarFormat'], [new JsObject.jsify(options._toMap())]);
    } else {
      throw new ArgumentError.value(options, 'options');
    }
  }

  /// The standard [format] method to apply formatting to the specified
  /// [columnIndex].
  void format(DataTable dataTable, int columnIndex) {
    _jsObject.callMethod('format', [dataTable.jsProxy, columnIndex]);
  }
}
