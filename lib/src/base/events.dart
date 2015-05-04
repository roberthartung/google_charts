part of google_visualization_api.base;

abstract class Event {

}

class SelectEvent implements Event {

}

class ReadyEvent implements Event {

}

class ErrorEvent implements Event {

}

class MouseOverEvent implements Event {
  final row;

  final column;

  MouseOverEvent(this.row, this.column);
}

class MouseOutEvent implements Event {
  final row;

  final column;

  MouseOutEvent(this.row, this.column);
}

class ClickEvent implements Event {
  final targetId;

  ClickEvent(this.targetId);
}

/// ...
class EventWrapper<E extends Event> {
  JsObject _jsChart;

  String _eventName;

  JsObject _handler;

  Stream<E> get onEvent => _streamController.stream;
  StreamController<E> _streamController;

  Function _reviver;

  EventWrapper(this._jsChart, this._eventName, E reviver(p)) {
    this._reviver = (_window, properties) => _streamController.add(reviver(properties));
    _streamController = new StreamController.broadcast(onListen: () => _onListen(_eventName), onCancel: () => _onCancel(_eventName));
  }

  void _onListen(String event) {
    _handler = Events.addListener(_jsChart, event, _reviver);
  }

  void _onCancel(String event) {
    Events.removeListener(_handler);
  }
}