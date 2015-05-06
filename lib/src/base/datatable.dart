part of google_visualization_api.base;

class ColumnType {
  static ColumnType STRING = const ColumnType._('string');
  static ColumnType NUMBER = const ColumnType._('number');
  static ColumnType BOOLEAN = const ColumnType._('boolean');
  static ColumnType DATE = const ColumnType._('date');
  static ColumnType DATETIME = const ColumnType._('datetime');
  static ColumnType TIMEOFDAY = const ColumnType._('timeofday');

  final String value;

  const ColumnType._(this.value);
}

class ColumnDescriptionObject {
  final ColumnType type;

  final String label;

  final String id;

  final String role;

  final String pattern;

  ColumnDescriptionObject(this.type,
      {this.label, this.id, this.role, this.pattern});

  Map toJson() {
    Map m = {'type': type.value};
    if (label != null) {
      m['label'] = label;
    }
    if (id != null) {
      m['id'] = id;
    }
    if (role != null) {
      m['role'] = role;
    }
    if (pattern != null) {
      m['pattern'] = pattern;
    }
    return m;
  }
}

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

  /// Adds a new column to the data table, and returns the index of the new
  /// column. All the cells of the new column are assigned a null value.
  num addColumn(type_or_description_object, [String label, String id]) {
    if (type_or_description_object is ColumnDescriptionObject || type_or_description_object is Map) {
      return jsProxy.callMethod(
          'addColumn', [new JsObject.jsify(type_or_description_object)]);
    } else if (type_or_description_object is String) {
      return jsProxy.callMethod(
          'addColumn', [type_or_description_object, label, id]);
    } else {
      throw new ArgumentError.value(type_or_description_object,
          'type_or_description_object',
          'Invalid type for argument type_or_description_object: Expecting Map or ColumnDescriptionObject');
    }
  }

  /// Adds a new row to the data table, and returns the index of the new row.
  num addRow([cellArray]) {
    if (cellArray == null) {
      return jsProxy.callMethod('addRow');
    } else {
      return jsProxy.callMethod('addRow', [new JsObject.jsify(cellArray)]);
    }
  }

  /// Adds new rows to the data table, and returns the index of the last added
  /// row. You can call this method to create new empty rows, or with data used
  /// to populate the rows, as described below.
  num addRows(num_or_array) {
    if (num_or_array is num) {
      return jsProxy.callMethod('addRows', [num_or_array]);
    } else {
      return jsProxy.callMethod('addRows', [new JsObject.jsify(num_or_array)]);
    }
  }

  /// Returns a clone of the data table. The result is a deep copy of the data
  /// table except for the cell properties, row properties, table properties and
  /// column properties, which are shallow copies; this means that non-primitive
  /// properties are copied by reference, but primitive properties are copied by
  /// value.
  DataTable clone() {
    return new DataTable._clone(this);
  }

  /// Returns the identifier of a given column specified by the column index in
  /// the underlying table.
  String getColumnId(int columnIndex) {
    return jsProxy.callMethod('getColumnId', [columnIndex]);
  }

  /// Returns the label of a given column specified by the column index in the
  /// underlying table.
  String getColumnLabel(int columnIndex) {
    return jsProxy.callMethod('getColumnLabel', [columnIndex]);
  }

  /// Returns the formatting pattern used to format the values of the specified
  /// column.
  String getColumnPattern(int columnIndex) {
    return jsProxy.callMethod('getColumnPattern', [columnIndex]);
  }

  /// Returns a map of all properties for the specified column.
  ///
  /// Note that the properties object is returned by reference, so changing
  /// values in the retrieved object changes them in the DataTable.
  JsObject getColumnProperties(int columnIndex) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getColumnProperties', [columnIndex]) as JsObject;
  }

  /// Returns the minimal and maximal values of values in a specified column.
  JsObject getColumnRange(int columnIndex) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getColumnRange', [columnIndex]) as JsObject;
  }

  /// Returns the role of the specified column.
  String getColumnRole(int columnIndex) {
    return jsProxy.callMethod('getColumnRole', [columnIndex]);
  }

  /// Returns the type of a given column specified by the column index.
  ///
  /// [columnIndex] should be a number greater than or equal to zero, and less
  /// than the number of columns as returned by the [getNumberOfColumns] method.
  String getColumnType(int columnIndex) {
    return jsProxy.callMethod('getColumnType', [columnIndex]);
  }

  /// Returns the unique values in a certain column, in ascending order.
  ///
  /// [columnIndex] should be a number greater than or equal to zero, and less
  /// than the number of columns as returned by the [getNumberOfColumns] method.
  JsObject getDistinctValues(int columnIndex) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getDistinctValues', [columnIndex]) as JsObject;
  }

  /// Returns the row indexes for rows that match all of the given filters. The
  /// indexes are returned in ascending order. The output of this method can be
  /// used as input to DataView.setRows() to change the displayed set of rows in
  /// a visualization.
  JsObject getFilteredRows(List filters) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getDistinctValues', [new JsObject.jsify(filters)]) as JsObject;
  }

  /// Returns the formatted value of the cell at the given row and column
  /// indexes.
  String getFormattedValue(int rowIndex, int columnIndex) {
    return jsProxy.callMethod('getFormattedValue', [rowIndex, columnIndex]);
  }

  /// Returns the number of columns in the table.
  int getNumberOfColumns() {
    return jsProxy.callMethod('getNumberOfColumns');
  }

  /// Returns the number of rows in the table.
  int getNumberOfRows() {
    return jsProxy.callMethod('getNumberOfRows');
  }

  /// Returns a map of all the properties for the specified cell.
  ///
  /// - [rowIndex] is the cell's row index.
  /// - [columnIndex] is the cell's column index.
  ///
  /// Note that the properties object is returned by reference, so changing
  /// values in the retrieved object changes them in the DataTable.
  JsObject getProperties(int rowIndex, int columnIndex) {
    return jsProxy.callMethod('getProperties', [rowIndex, columnIndex]);
  }

  /// Returns the value of a named property, or null if no such property is set
  /// for the specified cell. The return type varies, depending on the property.
  JsObject getProperty(int rowIndex, int columnIndex, String name) {
    return jsProxy.callMethod('getProperties', [rowIndex, columnIndex, name]);
  }

  /// Returns a map of all properties for the specified row.
  ///
  /// - [rowIndex] is the index of the row to retrieve properties for.
  ///
  /// Note that theproperties object is returned by reference, so changing
  /// values in the retrieved object changes them in the DataTable.
  JsObject getRowProperties(int rowIndex) {
    return jsProxy.callMethod('getProperties', [rowIndex]);
  }

  /// Returns the value of a named property, or null if no such property is set
  /// for the specified row. The return type varies, depending on the property.
  JsObject getRowProperty(int rowIndex) {
    return jsProxy.callMethod('getRowProperty', [rowIndex]);
  }

  /// Returns a sorted version of the table without modifying the order of the
  /// underlying data. To permanently sort the underlying data, call sort(). You
  /// can specify sorting in a number of ways, depending on the type you pass in
  /// to the sortColumns parameter:
  JsObject getSortedRows(dynamic sortColumns) {
    return jsProxy.callMethod('getSortedRows', [sortColumns]);
  }

  /// Returns a map of all properties for the table.
  JsObject getTableProperties() {
    return jsProxy.callMethod('getTableProperties');
  }

  /// Returns a map of all properties for the table.
  JsObject getTableProperty(String name) {
    return jsProxy.callMethod('getTableProperty', [name]);
  }

  /// Returns the value of the cell at the given row and column indexes.
  dynamic getValue(int rowIndex, int columnIndex) {
    return jsProxy.callMethod('getValue', [rowIndex, columnIndex]);
  }

  /// Inserts a new column to the data table, at the specifid index. All
  /// existing columns at or after the specified index are shifted to a higher
  /// index.
  void insertColumn(columnIndex, type, [label = '', id = '']) {
    jsProxy.callMethod('insertColumn', [columnIndex, type, label, id]);
  }

  void removeColumn(int columnIndex) {
    return jsProxy.callMethod('removeColumn', [columnIndex]);
  }

  void setValue(int rowIndex, int columnIndex, value) {
    return jsProxy.callMethod('setValue', [rowIndex, columnIndex, value]);
  }


}
