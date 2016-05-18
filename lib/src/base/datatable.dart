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
class DataTable extends _DataBase {
  /// Default Constructor
  DataTable([data = null, version = null]) {
    if (data == null) {
      _jsProxy = new JsObject(vis["DataTable"]);
    } else if(version != null) {
      _jsProxy = new JsObject(vis["DataTable"], [
        new JsObject.jsify(data),
        version
      ]);
    } else if(data is Map || data is String) {
      _jsProxy = new JsObject(vis["DataTable"], [
        new JsObject.jsify(data)
      ]);
    }
  }

  /// Internal constructor used to clone a DataTable.
  DataTable._clone(DataTable other) {
    _jsProxy = other.jsProxy.callMethod('clone');
  }

  /// Temporary constructor
  DataTable.fromJsObject(jsProxy) {
   _jsProxy = jsProxy;
  }

  /// Adds a new column to the data table, and returns the index of the new
  /// column. All the cells of the new column are assigned a null value.
  num addColumn(type_or_description_object, [String label, String id]) {
    if (type_or_description_object is ColumnDescriptionObject ||
        type_or_description_object is Map) {
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

  /// Returns a map of all properties for the specified column.
  ///
  /// Note that the properties object is returned by reference, so changing
  /// values in the retrieved object changes them in the DataTable.
  JsObject getColumnProperties(int columnIndex) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getColumnProperties', [columnIndex]) as JsObject;
  }

  /// Returns the role of the specified column.
  String getColumnRole(int columnIndex) {
    return jsProxy.callMethod('getColumnRole', [columnIndex]);
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

  /// Returns a map of all properties for the table.
  JsObject getTableProperties() {
    return jsProxy.callMethod('getTableProperties');
  }

  /// Inserts a new column to the data table, at the specifid index. All
  /// existing columns at or after the specified index are shifted to a higher
  /// index.
  void insertColumn(int columnIndex, ColumnType type, [label = '', id = '']) {
    jsProxy.callMethod('insertColumn', [columnIndex, type.value, label, id]);
  }

  /// Insert the specified number of rows at the specified row index.
  ///
  /// [rowIndex] is the index number where to insert the new row(s). Rows will be
  /// added, starting at the index number specified.
  ///
  /// [numberOrArray] is either a number of new, empty rows to add, or an array
  /// of one or more populated rows to add at the index. See [addRows] for the
  /// syntax for adding an array of row objects.
  void insertRows(int rowIndex, numberOrArray) {
    if (numberOrArray is List) {
      jsProxy.callMethod(
          'insertRows', [rowIndex, new JsObject.jsify(numberOrArray)]);
    } else if (numberOrArray is num) {
      jsProxy.callMethod('insertRows', [rowIndex, numberOrArray]);
    } else {
      throw new ArgumentError.value(numberOrArray, 'numberOrArray');
    }
  }

  /// Removes the column at the specified index.
  ///
  /// [columnIndex] should be a number with a valid column index.
  void removeColumn(int columnIndex) {
    jsProxy.callMethod('removeColumn', [columnIndex]);
  }

  /// Removes the specified number of columns starting from the column at the
  /// specified index.
  ///
  /// [numberOfColumns] is the number of columns to remove.
  /// [columnIndex] should be a number with a valid column index.
  void removeColumns(int columnIndex, int numberOfColumns) {
    jsProxy.callMethod('removeColumns', [columnIndex, numberOfColumns]);
  }

  /// Removes the row at the specified index.
  ///
  /// [rowIndex] should be a number with a valid row index.
  void removeRow(int rowIndex) {
    jsProxy.callMethod('removeRow', [rowIndex]);
  }

  /// Removes the specified number of rows starting from the row at the
  /// specified index.
  ///
  /// [numberOfRows] is the number of rows to remove.
  /// [rowIndex] should be a number with a valid row index.
  void removeRows(int rowIndex, int numberOfRows) {
    jsProxy.callMethod('removeRows', [rowIndex, numberOfRows]);
  }

  /// Sets the value, formatted value, and/or properties, of a cell.
  ///
  /// - [rowIndex] should be a number greater than or equal to zero, and less
  ///   than the number of rows as returned by the getNumberOfRows() method.
  /// - [columnIndex] should be a number greater than or equal to zero, and less
  ///   than the number of columns as returned by the getNumberOfColumns() method.
  /// - [value] is the value assigned to the specified cell. To avoid
  ///   overwriting this value, set this parameter to undefined; to clear this
  ///   value, set it to null. The type of the value depends on the column type
  ///   (see [getColumnType]):
  ///    - If the column type is 'string', the value should be a string.
  ///    - If the column type is 'number', the value should be a number.
  ///    - If the column type is 'boolean', the value should be a boolean.
  ///    - If the column type is 'date' or 'datetime', the value should be a
  ///      Date object.
  ///    - If the column type is 'timeofday', the value should be an array of
  ///      four numbers: hour, minute, second, milliseconds.
  /// - [formattedValue] is a string with the value formatted as a string. To
  ///   avoid overwriting this value, set this parameter to undefined; to clear
  ///   this value and have the API apply default formatting to value as needed,
  ///   set it to null; to explicitly set an empty formatted value, set it to an
  ///   empty string. The formatted value is typically used by visualizations to
  ///   display value labels. For example the formatted value can appear as a
  ///   label text within a pie chart.
  /// -  [properties] is an Object (a name/value map) with additional properties
  /// for this cell. To avoid overwriting this value, set this parameter to
  /// undefined; to clear this value, set it to null. Some visualizations
  /// support row, column, or cell properties to modify their display or
  /// behavior; see the visualization documentation to see what properties are
  /// supported.
  void setCell(int rowIndex, int columnIndex, [dynamic value = null,
      String formattedValue = null, Map properties = null]) {
    if (value is List) {
      value = new JsObject.jsify(value);
    }
    if (properties != null) {
      jsProxy.callMethod('setCell', [
        rowIndex,
        columnIndex,
        value,
        formattedValue,
        new JsObject.jsify(properties)
      ]);
    } else if (formattedValue != null) {
      jsProxy.callMethod(
          'setCell', [rowIndex, columnIndex, value, formattedValue]);
    } else {
      jsProxy.callMethod('setCell', [rowIndex, columnIndex, value]);
    }
  }

  /// Sets the label of a column.
  /// - [columnIndex] should be a number greater than or equal to zero, and less
  ///   than the number of columns as returned by the [getNumberOfColumns]
  ///   method.
  /// - [label] is a string with the label to assign to the column. The column
  ///   label is typically displayed as part of the visualization. For example
  ///   the column label can be displayed as a column header in a table, or as
  ///   the legend label in a pie chart.
  void setColumnLabel(int columnIndex, String label) {
    jsProxy.callMethod('setColumnLabel', [columnIndex, label]);
  }

  /// Sets a single column property. Some visualizations support row, column, or
  /// cell properties to modify their display or behavior; see the visualization
  /// documentation to see what properties are supported.
  ///
  /// - [columnIndex] should be a number greater than or equal to zero, and less
  ///   than the number of columns as returned by the [getNumberOfColumns]
  ///   method.
  /// - [name] is a string with the property name.
  /// - [value] is a value of any type to assign to the specified named property
  ///   of the specified column.
  void setColumnProperty(int columnIndex, String name, dynamic value) {
    if (value is List || value is Map) {
      value = new JsObject.jsify(value);
    }
    jsProxy.callMethod('setColumnProperty', [columnIndex, name, value]);
  }

  /// Sets multiple column properties. Some visualizations support row, column,
  /// or cell properties to modify their display or behavior; see the
  /// visualization documentation to see what properties are supported.
  void setColumnProperties(int columnIndex, Map properties) {
    jsProxy.callMethod(
        'setColumnProperties', [columnIndex, new JsObject.jsify(properties)]);
  }

  /// Sets the formatted value of a cell.
  void setFormattedValue(int rowIndex, int columnIndex, String formattedValue) {
    jsProxy.callMethod(
        'setFormattedValue', [rowIndex, columnIndex, formattedValue]);
  }

  /// Sets a cell property. Some visualizations support row, column, or cell
  /// properties to modify their display or behavior; see the visualization
  /// documentation to see what properties are supported.
  void setProperty(rowIndex, columnIndex, name, value) {
    jsProxy.callMethod('setProperty', [rowIndex, columnIndex, name, value]);
  }

  /// Sets multiple cell properties. Some visualizations support row, column, or
  /// cell properties to modify their display or behavior; see the visualization
  /// documentation to see what properties are supported.
  void setProperties(rowIndex, columnIndex, properties) {
    jsProxy.callMethod('setProperties', [
      rowIndex,
      columnIndex,
      new JsObject.jsify(properties)
    ]);
  }

  /// Sets a row property. Some visualizations support row, column, or cell
  /// properties to modify their display or behavior; see the visualization
  /// documentation to see what properties are supported.
  void setRowProperty(rowIndex, name, value) {
    jsProxy.callMethod(
        'setRowProperty', [rowIndex, name, new JsObject.jsify(value)]);
  }

  /// Sets multiple row properties. Some visualizations support row, column,
  /// or cell properties to modify their display or behavior; see the
  /// visualization documentation to see what properties are supported.
  void setRowProperties(rowIndex, properties) {
    jsProxy.callMethod(
        'setRowProperties', [rowIndex, new JsObject.jsify(properties)]);
  }

  /// Sets a single table property. Some visualizations support table, row,
  /// column, or cell properties to modify their display or behavior; see the
  /// visualization documentation to see what properties are supported.
  void setTableProperty(name, value) {
    jsProxy.callMethod('setTableProperty', [name, value]);
  }

  /// Sets multiple table properties. Some visualizations support table, row,
  /// column, or cell properties to modify their display or behavior; see the
  /// visualization documentation to see what properties are supported.
  void setTableProperties(properties) {
    jsProxy.callMethod('setTableProperties', [new JsObject.jsify(properties)]);
  }

  /// Sets the value of a cell. In addition to overwriting any existing cell
  /// value, this method will also clear out any formatted value and properties
  /// for the cell.
  void setValue(int rowIndex, int columnIndex, value) {
    jsProxy.callMethod('setValue', [rowIndex, columnIndex, value]);
  }

  /// Sorts the rows, according to the specified sort columns. The DataTable is
  /// modified by this method. See [getSortedRows] for a description of the
  /// sorting details. This method does not return the sorted data.
  void sort(sortColumns) {
    jsProxy.callMethod('sort', [new JsObject.jsify(sortColumns)]);
  }

  /// Returns a JSON representation of the DataTable that can be passed into the
  /// [DataTable] constructor.
  String toJSON() {
    return jsProxy.callMethod('toJSON');
  }
}
