part of google_visualization_api.base;

class PatternFormat {
  JsObject _jsObject;

  PatternFormat(String format) {
    _jsObject = new JsObject(vis['PatternFormat'], [format]);
  }

  void format(DataTable dataTable, List<int> srcColumnIndices, [int dstColumnIndex]) {
    if(dstColumnIndex != null) {
      _jsObject.callMethod('format', [dataTable.jsProxy, new JsObject.jsify(srcColumnIndices), dstColumnIndex]);
    } else {
      _jsObject.callMethod('format', [dataTable.jsProxy, new JsObject.jsify(srcColumnIndices)]);
    }
  }
}