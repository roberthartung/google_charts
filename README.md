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