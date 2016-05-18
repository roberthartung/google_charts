# Google Charts API Wrapper

A library to make it easy to use [Google's visualization api][api]

This package was matched against the version released on April 30, 2015 (Version 42).

## Usage

You can use the api almost as you would do in the javascript version.

1. Include `<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>` in the `head` section of your HTML code.

2. Use the `load` method of the Chart you want to use to load the required package(s) asynchronously. Afterwards you can go ahead and write your code.
    ```
  LineChart.load().then((_) {
    var chart = new LineChart(...);
    var data = new DataTable(...);
    chart.draw(data);
  });
    ```

3. When using the API itself you can use `Chart.load()` to only load the API without any packages.

## Implemented wrappers

- All Charts are implemented, included the corecharts and all other charts.
- Material charts (Line, Bar/Column, Scatter)
- Query API
- Formatters
- Static methods like `arrayToDataTable`, `drawChart` and `drawToolbar`
- Events

## Examples

### Pie Chart

#### HTML Code

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Pie Chart Example</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  </head>
  <body>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
    <script type="application/dart" src="piechart.dart"></script>
    <!-- for this next line to work, your pubspec.yaml file must have a dependency on 'browser' -->
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
```

#### Dart Code
```
import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  PieChart.load().then((_) {
    var data = arrayToDataTable([
      ['Task', 'Hours per Day'],
      ['Work', 11],
      ['Eat', 2],
      ['Commute', 2],
      ['Watch TV', 2],
      ['Sleep', 7]
    ]);

    var options = {'title': 'My Daily Activities'};

    var chart = new PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  });
}

```
[api]: https://developers.google.com/chart/

## Event Overview

Following Events are supported by the different chart types:

| Name | select | ready | animationfinish | click | error | onmouseover | onmouseout | regionClick | collapse | rangechange | page | sort | rollup |
| ---- | ------ | ----- | --------------- | ----- | ----- | ----------- | ---------- | ----------- | -------- | ----------- | ---- | ---- | ------ |
| AnnotationChart | x | x |  |  |  |  |  |  |  | x |  |  |  |
| AreaChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| BarChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| BubbleChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| Calendar | x | x |  |  | x | x | x |  |  |  |  |  |  |
| CandleStickChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| ColumnChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| ComboChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| Gauge |  |  |  |  |  |  |  |  |  |  |  |  |  |
| GeoChart | x | x |  |  | x |  |  | x |  |  |  |  |  |
| Histogram* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| LineChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| Map | x |  |  |  | x |  |  |  |  |  |  |  |  |
| OrgChart | x | x |  |  |  | x | x |  | x |  |  |  |  |
| PieChart* | x | x |  | x | x | x | x |  |  |  |  |  |  |
| Sankey | x | x |  |  | x | x | x |  |  |  |  |  |  |
| ScatterChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| AreaChart* | x | x | x | x | x | x | x |  |  |  |  |  |  |
| Table | x | x |  |  |  |  |  |  |  |  | x | x |  |
| Timeline | x | x |  |  | x | x | x |  |  |  |  |  |  |
| TreeMap | x | x |  |  |  | x | x |  |  |  |  |  | x |
| WordTree | x | x |  |  |  |  |  |  |  |  |  |  |  |

*) core chart
