part of google_visualization_api.base;

/// A read-only view of an underlying [DataTable]. A DataView allows selection
/// of only a subset of the columns and/or rows. It also allows reordering
/// columns/rows, and duplicating columns/rows.
class DataView extends _DataBase {
  /// [data] is a [DataTable] or [DataView]
  DataView(data) {
    if(data is DataTable || data is DataView) {
      _jsProxy = new JsObject(vis['DataView'], [data.jsProxy]);
    } else {
      throw new ArgumentError.value(data, 'data');
    }
  }

  DataView.fromJson(data, String viewAsJson) {
    _jsProxy = new JsObject(vis['DataView'], [data.jsProxy, viewAsJson]);
  }

  int getTableColumnIndex(int viewColumnIndex) {
    return jsProxy.callMethod('getTableColumnIndex', [viewColumnIndex]);
  }

  int getTableRowIndex(int viewRowIndex) {
    return jsProxy.callMethod('getTableRowIndex', [viewRowIndex]);
  }

  int getViewColumnIndex(int tableColumnIndex) {
    return jsProxy.callMethod('getViewColumnIndex', [tableColumnIndex]);
  }

  JsObject getViewColumns() {
    return jsProxy.callMethod('getViewColumns');
  }

  int getViewRowIndex(int tableRowIndex) {
    return jsProxy.callMethod('getViewRowIndex', [tableRowIndex]);
  }

  JsObject getViewRows() {
    return jsProxy.callMethod('getViewRows');
  }

  void hideColumns(List<int> columnIndexes) {
    jsProxy.callMethod('hideColumns', [new JsObject.jsify(columnIndexes)]);
  }

  hideRows(minOrRowIndexes, [int max]) {
    if(max != null) {
      jsProxy.callMethod('hideRows', [minOrRowIndexes, max]);
    } else {
      jsProxy.callMethod('hideRows', [new JsObject.jsify(minOrRowIndexes)]);
    }
  }

  void setColumns(columnIndexes) {
    jsProxy.callMethod('setColumns', [new JsObject.jsify(columnIndexes)]);
  }

  void setRows(minOrRowIndexes, [int max]) {
    if(max != null) {
      jsProxy.callMethod('setRows', [minOrRowIndexes, max]);
    } else {
      jsProxy.callMethod('setRows', [new JsObject.jsify(minOrRowIndexes)]);
    }
  }

  DataTable toDataTable() {
    return new DataTable.fromJsObject(jsProxy.callMethod('toDataTable'));
  }

  String toJSON() {
    return jsProxy.callMethod('toJSON');
  }
}