part of google_visualization_api.charts;

class PieChart extends Chart with CoreChart, Selection {
  Stream<SelectEvent> get onSelect => _selectEventHandler.onEvent;
  EventWrapper _selectEventHandler;

  Stream<MouseOverEvent> get onMouseOver => _onMouseOverEventHandler.onEvent;
  EventWrapper _onMouseOverEventHandler;

  Stream<MouseOverEvent> get onMouseOut => _onMouseOutEventHandler.onEvent;
  EventWrapper _onMouseOutEventHandler;

  Stream<ClickEvent> get onClick => _onClickEventHandler.onEvent;
  EventWrapper _onClickEventHandler;

  PieChart(Element e) : super._(e, "PieChart", vis) {
    _selectEventHandler = new EventWrapper<SelectEvent>(
        jsChart, 'select', (p) => new SelectEvent());
    _onMouseOverEventHandler = new EventWrapper<MouseOverEvent>(jsChart,
        'onmouseover', (p) => new MouseOverEvent(p['row'], p['column']));
    _onMouseOutEventHandler = new EventWrapper<MouseOverEvent>(jsChart,
        'onmouseout', (p) => new MouseOverEvent(p['row'], p['column']));
    _onClickEventHandler = new EventWrapper<ClickEvent>(jsChart,
        'click', (p) => new ClickEvent(p['targetID']));
  }

  static Future load() {
    return Chart.load(['corechart']);
  }
}
