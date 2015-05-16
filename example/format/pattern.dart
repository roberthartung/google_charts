import 'dart:html';
import 'package:google_visualization_api/google_visualization_api.dart';

void main() {
  Table.load().then((_) {
    var data = new DataTable();
    data.addColumn('string', 'Name');
    data.addColumn('string', 'Email');
    data.addRows([
      ['John Lennon', 'john@beatles.co.uk'],
      ['Paul McCartney', 'paul@beatles.co.uk'],
      ['George Harrison', 'george@beatles.co.uk'],
      ['Ringo Starr', 'ringo@beatles.co.uk']
    ]);

    var table = new Table(document.getElementById('patternformat_div'));

    var formatter = new PatternFormat('<a href="mailto:{1}">{0}</a>');
    // Apply formatter and set the formatted value of the first column.
    formatter.format(data, [0, 1]);

    var view = new DataView(data);
    view.setColumns([0]); // Create a view with the first column only.

    table.draw(view, {'allowHtml': true, 'showRowNumber': true});
  });
}
