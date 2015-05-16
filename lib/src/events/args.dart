part of google_visualization_api.static.events;

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