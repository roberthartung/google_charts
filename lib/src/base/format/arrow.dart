part of google_visualization_api.base;

class ArrowFormatOptions {
  var base;

  ArrowFormatOptions({num this.base: 0});

  Map _toMap() {
    return {'base': base};
  }
}

class ArrowFormat {
  JsObject _jsObject;

  ArrowFormat([options]) {
    if (options is Map) {
      _jsObject =
          new JsObject(vis['ArrowFormat'], [new JsObject.jsify(options)]);
    } else if (options is ArrowFormatOptions) {
      _jsObject = new JsObject(
          vis['ArrowFormat'], [new JsObject.jsify(options._toMap())]);
    } else if (options == null) {
      _jsObject = new JsObject(vis['ArrowFormat']);
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
