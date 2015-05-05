part of google_visualization_api.static;

/// Static Events interface according to
/// https://developers.google.com/chart/interactive/docs/reference#events
///
/// You usually don't need this, because each chart has its own event streams
abstract class Events {
  /// Call this method to register to receive events fired by a visualization
  /// hosted on your page. You should document what event arguments, if any,
  /// will be passed to the handling function.
  static JsObject addListener(JsObject source_visualization, String event_name,
      Function handling_function) {
    return vis['events'].callMethod('addListener', [
      source_visualization,
      event_name,
      new JsFunction.withThis(handling_function)
    ]);
  }

  /// This is identical to [addListener], but is intended for events that should
  /// only be listened to once. Subsequent throws of the event will not invoke
  /// the handling function.
  ///
  /// An example of when this is useful: every draw causes a ready event to be
  /// thrown. If you want only the first ready to execute your code, you'll want
  /// [addOneTimeListener] rather than [addListener].
  static JsObject addOneTimeListener(
      JsObject source_visualization, String event_name, handling_function(e)) {
    return vis['events'].callMethod('addOneTimeListener', [
      source_visualization,
      event_name,
      new JsFunction.withThis(handling_function)
    ]);
  }

  /// Call this method to unregister an existing event listener.
  static void removeListener(listener_handler) {
    return vis['events'].callMethod('removeListener', [listener_handler]);
  }

  /// Call this method to unregister all event listeners of a specific
  /// visualization instance.
  static void removeAllListeners(JsObject source_visualization) {
    return vis['events'].callMethod(
        'removeAllListeners', [source_visualization]);
  }

  /// Called by visualization implementers. Call this method from your
  /// visualization to fire an event with an arbitrary name and set of values.
  static void trigger(JsObject source_visualization, String event_name,
      [Map args = null]) {
    if (args == null) {
      return vis['events'].callMethod(
          'trigger', [source_visualization, event_name, null]);
    } else {
      return vis['events'].callMethod('trigger', [
        source_visualization,
        event_name,
        new JsObject.jsify(args)
      ]);
    }
  }
}
