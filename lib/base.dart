library google_visualization_api.base;

import 'dart:js';

import 'static.dart';

part 'src/base/datatable.dart';
part 'src/base/dataview.dart';
part 'src/base/query.dart';
part 'src/base/format/pattern.dart';
part 'src/base/format/number.dart';
part 'src/base/format/date.dart';
part 'src/base/format/color.dart';
part 'src/base/format/bar.dart';
part 'src/base/format/arrow.dart';
/// TODO(rh): Add GadgetHelper

abstract class _DataBase {
  /// Internal proxy
  JsObject _jsProxy;

  /// Public getter for the proxy
  JsObject get jsProxy => _jsProxy;

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

  getColumnProperty(int columnIndex, String name) {
    return jsProxy.callMethod('getColumnProperty', [columnIndex, name]);
  }

  /// Returns the minimal and maximal values of values in a specified column.
  JsObject getColumnRange(int columnIndex) {
    // TODO(rh): Wrapper for return value
    return jsProxy.callMethod('getColumnRange', [columnIndex]) as JsObject;
  }

  /// Returns the type of a given column specified by the column index.
  ///
  /// [columnIndex] should be a number greater than or equal to zero, and less
  /// than the number of columns as returned by the [getNumberOfColumns] method.
  String getColumnType(int columnIndex) {
    // TODO(rh): Change return type to [ColumnType]
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
    return jsProxy.callMethod(
        'getFilteredRows', [new JsObject.jsify(filters)]) as JsObject;
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
    return jsProxy.callMethod('getProperty', [rowIndex, columnIndex, name]);
  }

  /// Returns a sorted version of the table without modifying the order of the
  /// underlying data. To permanently sort the underlying data, call sort(). You
  /// can specify sorting in a number of ways, depending on the type you pass in
  /// to the sortColumns parameter:
  JsObject getSortedRows(dynamic sortColumns) {
    return jsProxy.callMethod('getSortedRows', [sortColumns]);
  }

  /// Returns the value of the cell at the given row and column indexes.
  dynamic getValue(int rowIndex, int columnIndex) {
    return jsProxy.callMethod('getValue', [rowIndex, columnIndex]);
  }

  /// Returns the value of a named property, or null if no such property is set
  /// for the specified row. The return type varies, depending on the property.
  JsObject getRowProperty(int rowIndex) {
    return jsProxy.callMethod('getRowProperty', [rowIndex]);
  }

/// Returns a map of all properties for the table.
  JsObject getTableProperty(String name) {
    return jsProxy.callMethod('getTableProperty', [name]);
  }
}
