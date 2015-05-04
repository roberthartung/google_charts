part of google_visualization_api.static;

class Event {

}

class SelectEvent {

}

class ReadyEvent {

}

class ErrorEvent {

}

class MouseOverEvent {
  final row;

  final column;

  MouseOverEvent(this.row, this.column);
}

class MouseOutEvent {
  final row;

  final column;

  MouseOutEvent(this.row, this.column);
}

class ClickEvent {
  final targetId;

  ClickEvent(this.targetId);
}

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
}

class EventWrapper<E> {
  JsObject _jsChart;

  String _eventName;

  JsObject _handler;

  Stream<E> get onEvent => _streamController.stream;
  StreamController<E> _streamController;

  Function _reviver;

  EventWrapper(this._jsChart, this._eventName, [reviver(p) = null]) {
    if(reviver == null) {
      this._reviver = (_window, properties) => _streamController.add(properties);
    } else {
      this._reviver = (_window, properties) => _streamController.add(reviver(properties));
    }
    print(_reviver);
    _streamController = new StreamController.broadcast(onListen: () => _onListen(_eventName), onCancel: () => _onCancel(_eventName));
  }

  void _onListen(String event) {
    _handler = Events.addListener(_jsChart, event, _reviver);
  }

  void _onCancel(String event) {
    Events.removeListener(_handler);
  }
}