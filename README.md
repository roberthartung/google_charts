# google_visualization_api

A library to make it easy to use [Google's visualization api][api]

## Usage

You can use the api as you would do in the javascript version like this:

    LineChart.load().then((_) {
      LineChart chart = new LineChart(...);
      DataTable data = new DataTable(...);
      chart.draw(data);
    });

[api]: https://developers.google.com/chart/

## Events

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
