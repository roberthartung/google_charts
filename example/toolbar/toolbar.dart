import 'dart:html';
import 'package:google_charts/visualization.dart' show PieChart;
import 'package:google_charts/static.dart' show drawToolbar;
import 'package:google_charts/base.dart' show Query;

var visualization;

draw() {
  _drawVisualization();
  _drawToolbar();
}

_drawVisualization() {
  var container = document.getElementById('visualization_div');
  visualization = new PieChart(container);
  new Query('https://spreadsheets.google.com/tq?key=pCQbetd-CptHnwJEfo8tALA').
      send(_queryCallback);
}

_queryCallback(response) {
  visualization.draw(response.getDataTable(), {'is3D': true});
}

_drawToolbar() {
  var components = [
      {'type': 'igoogle', 'datasource': 'https://spreadsheets.google.com/tq?key=pCQbetd-CptHnwJEfo8tALA',
       'gadget': 'https://www.google.com/ig/modules/pie-chart.xml',
       'userprefs': {'3d': 1}},
      {'type': 'html', 'datasource': 'https://spreadsheets.google.com/tq?key=pCQbetd-CptHnwJEfo8tALA'},
      {'type': 'csv', 'datasource': 'https://spreadsheets.google.com/tq?key=pCQbetd-CptHnwJEfo8tALA'},
      {'type': 'htmlcode', 'datasource': 'https://spreadsheets.google.com/tq?key=pCQbetd-CptHnwJEfo8tALA',
       'gadget': 'https://www.google.com/ig/modules/pie-chart.xml',
       'userprefs': {'3d': 1},
       'style': 'width: 800px; height: 700px; border: 3px solid purple;'}
  ];

  var container = document.getElementById('toolbar_div');
  drawToolbar(container, components);
}

void main() {
  PieChart.load().then((_) => draw());
}