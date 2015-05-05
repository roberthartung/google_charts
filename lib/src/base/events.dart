part of google_visualization_api.base;

/// Baseic event interface shared across all chart events
abstract class ChartEventArgs {

}

class ErrorEventArgs implements ChartEventArgs {
  final id;

  final message;

  ErrorEventArgs(this.id, this.message);
}

class MouseEventArgs implements ChartEventArgs {
  final row;

  final column;

  MouseEventArgs(this.row, this.column);
}

class ClickEventArgs implements ChartEventArgs {
  final targetId;

  ClickEventArgs(this.targetId);
}

/// ...
class EventWrapper<E extends ChartEventArgs> {
  JsObject _jsChart;

  String _eventName;

  JsObject _handler;

  Stream<E> get onEvent => _streamController.stream;
  StreamController<E> _streamController;

  Function _reviver;

  EventWrapper(this._jsChart, this._eventName, [E reviver(p)]) {
    if(reviver == null) {
      this._reviver = (_window, properties) => _streamController.add(null);
    } else {
      this._reviver = (_window, properties) => _streamController.add(reviver(properties));
    }
    _streamController = new StreamController.broadcast(onListen: () => _onListen(_eventName), onCancel: () => _onCancel(_eventName));
  }

  void _onListen(String event) {
    _handler = Events.addListener(_jsChart, event, _reviver);
  }

  void _onCancel(String event) {
    Events.removeListener(_handler);
  }
}