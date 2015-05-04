import 'dart:io';
import 'package:args/args.dart';

ArgResults argResults;

void main(List<String> arguments) {
  File csvFile = new File(arguments[0]);
  if(!csvFile.existsSync()) {
    throw "File ${arguments[0]} not found.";
  }

  File output = new File(arguments[0] + '.md');
  IOSink sink = output.openWrite(mode: FileMode.WRITE);
  csvFile.readAsLines().then((List<String> lines) {
    int lineCount = 0;
    lines.forEach((String line) {
      lineCount++;
      List<String> columns = line.split(';');
      String isCoreChart = columns.removeAt(0) == 'x' ? '*' : '';
      // Write Name
      String name = columns.removeAt(0);
      sink.write('| $name$isCoreChart ');
      // Events
      columns.forEach((String col) {
        sink.write('| $col ');
      });
      sink.write('|\n');
      if(lineCount == 1) {
        // Name
        sink.write('| ${'-'*name.length} ');
        // Events
        columns.forEach((String col) {
          sink.write('| ${'-'*col.length} ');
        });
        sink.write('|\n');
      }
    });
  }).then((_) => sink.close());
}