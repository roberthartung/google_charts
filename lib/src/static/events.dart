part of google_visualization_api.static;

abstract class Events {
  static JsObject addListener(source_visualization, event_name, Function handling_function) {
    return vis['events'].callMethod('addListener', [source_visualization, event_name, new JsFunction.withThis(handling_function)]);
  }

  static JsObject addOneTimeListener(source_visualization, event_name, handling_function(e)) {
    return vis['events'].callMethod('addOneTimeListener', [source_visualization, event_name, new JsFunction.withThis(handling_function)]);
  }

  static void removeListener(listener_handler) {
    return vis['events'].callMethod('addOneTimeListener', [listener_handler]);
  }

  /// TODO(rh): removeAllListeners
}