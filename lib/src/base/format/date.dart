part of google_visualization_api.base;

/*
enum DateFormatType {
  SHORT, MEDIUM, LONG
}
*/

class DateFormatOptions {
  var formatType;

  var pattern;

  var timeZone;

  DateFormatOptions(
      {String this.formatType, String this.pattern, int this.timeZone});

  Map _toMap() {
    Map m = {};

    if (formatType != null) {
      m['formatType'] = formatType;
    }

    if (pattern != null) {
      m['pattern'] = pattern;
    }

    if (timeZone != null) {
      m['timeZone'] = timeZone;
    }

    return m;
  }
}

class DateFormat {
  JsObject _jsObject;

  DateFormat(options) {
    if (options is Map) {
      _jsObject =
          new JsObject(vis['DateFormat'], [new JsObject.jsify(options)]);
    } else if (options is DateFormatOptions) {
      _jsObject = new JsObject(
          vis['DateFormat'], [new JsObject.jsify(options._toMap())]);
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
