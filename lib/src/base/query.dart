part of google_visualization_api.base;

/// Represents a query that is sent to a data source.
class Query {
  JsObject _jsQuery;

  JsObject get jsQuery => _jsQuery;

  /// [dataSourceUrl] is a URL to send the query to. See the Charts and
  /// Spreadsheets documentation for Google Spreadsheets.
  Query(String dataSourceUrl, [Map options]) {
    if (options != null) {
      _jsQuery = new JsObject(
          vis['Query'], [dataSourceUrl, new JsObject.jsify(options)]);
    } else {
      _jsQuery = new JsObject(vis['Query'], [dataSourceUrl]);
    }
  }

  /// Stops the automated query sending that was started with
  /// [setRefreshInterval].
  void abort() {
    jsQuery.callMethod('abort');
  }

  /// Sets the query to automatically call the [send] method every specified
  /// duration (number of seconds), starting from the first explicit call to
  /// send. seconds is a number greater than or equal to zero.
  ///
  /// If you use this method, you should call it before calling the send method.
  ///
  /// Cancel this method either by calling it again with zero (the default), or
  /// by calling [abort].
  void setRefreshInterval(int seconds) {
    jsQuery.callMethod('setRefreshInterval', [seconds]);
  }

  /// Sets the number of seconds to wait for the data source to respond before
  /// raising a timeout error.
  ///
  /// - [seconds] is a number greater than zero.
  ///
  /// The default timeout is 30 seconds. This method, if used, should be called
  /// before calling the send method.
  void setTimeout(int seconds) {
    jsQuery.callMethod('setTimeout', [seconds]);
  }

  /// Sets the query string. The value of the [string] parameter should be a valid query.
  /// This method, if used, should be called before calling the send method.
  void setQuery(String string) {
    jsQuery.callMethod('setQuery', [string]);
  }

  /// Sends the query to the data source. callback should be a function that
  /// will be called when the data source responds.
  void send(cb(QueryResponse qr)) {
    //Completer m = new Completer();
    jsQuery.callMethod('send', [
      new JsFunction.withThis((x, JsObject data) {
        /*m.complete(new QueryResponse._(data));*/
        cb(new QueryResponse._(data));
      })
    ]);
    //return m.future;
  }
}

/// Represents a response of a query execution as received from the data source.
class QueryResponse {
  JsObject _jsObject;

  JsObject get jsObject => _jsObject;

  QueryResponse._(this._jsObject);

  /// Returns the data table as returned by the data source. Returns null if the
  /// query execution failed and no data was returned.
  DataTable getDataTable() {
    return new DataTable.fromJsObject(jsObject.callMethod('getDataTable'));
  }

  /// Returns a detailed error message for queries that failed. If the query
  /// execution was successful, this method returns an empty string. The message
  /// returned is a message that is intended for developers, and may contain
  /// technical information, for example 'Column {salary} does not exist'.
  String getDetailedMessage() {
    return jsObject.callMethod('getDetailedMessage');
  }

  /// Returns a short error message for queries that failed. If the query
  /// execution was successful, this method returns an empty string. The message
  /// returned is a short message that is intended for end users, for example
  /// 'Invalid Query' or 'Access Denied'.
  String getMessage() {
    return jsObject.callMethod('getMessage');
  }

  /// Returns an array of zero of more entries. Each entry is a short string
  /// with an error or warning code that was raised while executing the query.
  JsObject getReasons() {
    return jsObject.callMethod('getReasons');
  }

  /// Returns true if the query execution has any warning messages.
  bool hasWarning() {
    return jsObject.callMethod('hasWarning');
  }

  /// Returns `true` if the query execution failed, and the response does not
  /// contain any data table. Returns `false` if the query execution was
  /// successful and the response contains a data table.
  bool isError() {
    return jsObject.callMethod('isError');
  }
}
