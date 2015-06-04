import 'dart:html';
import 'package:google_charts/google_charts.dart';

void main() {
  Table.load().then((_) {
    var data = new DataTable();
    data.addColumn('string', 'Employee Name');
    data.addColumn('date', 'Start Date (Long)');
    data.addColumn('date', 'Start Date (Medium)');
    data.addColumn('date', 'Start Date (Short)');
    data.addRows([
      ['Mike', new DateTime(2008, 1, 28, 0, 31, 26),
               new DateTime(2008, 1, 28, 0, 31, 26),
               new DateTime(2008, 1, 28, 0, 31, 26)],
      ['Bob', new DateTime(2007, 5, 1, 0),
              new DateTime(2007, 5, 1, 0),
              new DateTime(2007, 5, 1, 0)],
      ['Alice', new DateTime(2006, 7, 16),
                new DateTime(2006, 7, 16),
                new DateTime(2006, 7, 16)]
    ]);

    // Create three formatters in three styles.
    var formatter_long = new DateFormat({'formatType': 'long'});
    var formatter_medium = new DateFormat({'formatType': 'medium'});
    var formatter_short = new DateFormat({'formatType': 'short'});

    // Reformat our data.
    formatter_long.format(data, 1);
    formatter_medium.format(data,2);
    formatter_short.format(data, 3);

    // Draw our data
    var table = new Table(document.getElementById('dateformat_div'));
    table.draw(data, {'showRowNumber': true});
  });
}
