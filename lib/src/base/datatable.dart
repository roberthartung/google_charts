part of google_visualization_api.base;

/// Wrapper for the google.visualization.DataTable class
/// https://developers.google.com/chart/interactive/docs/reference#DataTable
class DataTable {
  /// Internal proxy
  JsObject _jsProxy;

  /// Public getter for the proxy
  JsObject get jsProxy => _jsProxy;

  /// Default Constructor
  DataTable([data, version = '0.6']) {
    if (data == null) {
      _jsProxy = new JsObject(vis["DataTable"], []);
    } else {
      _jsProxy = new JsObject(vis["DataTable"], [
        new JsObject.jsify(data),
        new JsObject.jsify(version)
      ]);
    }
  }

  /// Internal constructor used to clone a DataTable.
  DataTable._clone(DataTable other) {
    _jsProxy = other.jsProxy.callMethod('clone');
  }

  /// Temporary constructor
  DataTable.fromJsObject(this._jsProxy);

  num addColumn(type_or_description_object, [String label, String id]) {
    if (type_or_description_object is Map) {
      return jsProxy.callMethod(
          'addColumn', [new JsObject.jsify(type_or_description_object)]);
    } else {
      return jsProxy.callMethod(
          'addColumn', [type_or_description_object, label, id]);
    }
  }

  num addRow([cellArray]) {
    if (cellArray == null) {
      return jsProxy.callMethod('addRow');
    } else {
      return jsProxy.callMethod('addRow', [new JsObject.jsify(cellArray)]);
    }
  }

  num addRows(num_or_array) {
    if (num_or_array is num) {
      return jsProxy.callMethod('addRows', [num_or_array]);
    } else {
      return jsProxy.callMethod('addRows', [new JsObject.jsify(num_or_array)]);
    }
  }

  DataTable clone() {
    return new DataTable._clone(this);
  }

  String getColumnId(int columnIndex) {
    return jsProxy.callMethod('getColumnId', [columnIndex]);
  }

  String getColumnLabel(int columnIndex) {
    return jsProxy.callMethod('getColumnLabel', [columnIndex]);
  }

  String getColumnPattern(int columnIndex) {
    return jsProxy.callMethod('getColumnPattern', [columnIndex]);
  }

  JsObject getColumnProperties(int columnIndex) {
    return jsProxy.callMethod('getColumnProperties', [columnIndex]) as JsObject;
  }

  JsObject getColumnRange(int columnIndex) {
    return jsProxy.callMethod('getColumnRange', [columnIndex]) as JsObject;
  }

  int getNumberOfRows() {
    return jsProxy.callMethod('getNumberOfRows');
  }

  void removeColumn(int columnIndex) {
    return jsProxy.callMethod('removeColumn', [columnIndex]);
  }

  void setValue(int rowIndex, int columnIndex, value) {
    return jsProxy.callMethod('setValue', [rowIndex, columnIndex, value]);
  }
}
