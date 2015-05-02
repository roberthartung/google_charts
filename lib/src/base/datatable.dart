part of google_visualization_api.base;

class DataTable {
  JsObject _jsProxy;

  JsObject get jsProxy => _jsProxy;

  static final ns = context["google"]["visualization"];

  DataTable([data, version = '0.6']) {
    if(data == null) {
      _jsProxy = new JsObject(ns["DataTable"], []);
    } else {
      _jsProxy = new JsObject(ns["DataTable"], [new JsObject.jsify(data), new JsObject.jsify(version)]);
    }
  }

  void addColumn(type_or_description_object, [String label, String id]) {
    if(type_or_description_object is Map) {
      jsProxy.callMethod('addColumn', [new JsObject.jsify(type_or_description_object)]);
    } else {
      jsProxy.callMethod('addColumn', [type_or_description_object, label, id]);
    }
  }

  void addRow([cellArray]) {
    if(cellArray == null) {
      jsProxy.callMethod('addRow');
    } else {
      jsProxy.callMethod('addRow', [new JsObject.jsify(cellArray)]);
    }
  }

  void addRows(num_or_array) {
    if(num_or_array is num) {
      jsProxy.callMethod('addRows', [num_or_array]);
    } else {
      jsProxy.callMethod('addRows', [new JsObject.jsify(num_or_array)]);
    }
  }
}