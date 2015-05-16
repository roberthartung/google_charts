library extractoptions;

import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'dart:io';

/// Representation of a Chart with it's options etc
class Chart {
  final bool isCoreChart;

  final String name;

  final String className;

  final List<ConfigurationOption> options = [];

  Chart(this.name, this.className, [this.isCoreChart = true]);
}

/// Option for one chart
class ConfigurationOption {
  String name;

  String type;

  String defaultValue;

  Element description;

  ConfigurationOption(this.name, this.type, this.defaultValue, this.description);
}

final Map<String,ConfigurationOption> configurationOptions = {};

///
class Method {}

///
class Event {}

/// Header
final String header = """library google_visualization_api.chart.options;

part 'chart_options/types.dart';

class CoreChartOptions {
  // ...
}
""";

/// Url prefix
const urlPrefix =
    "https://developers.google.com/chart/interactive/docs/gallery/";

/// Chart List
final List<Chart> charts = [
  new Chart('annotationchart', 'AnnotationChart', false),
  new Chart('areachart', 'AreaChart'),
  new Chart('barchart', 'BarChart'),
  new Chart('bubblechart', 'BubbleChart'),
  new Chart('calendar', 'Calendar', false),
  new Chart('candlestickchart', 'CandlestickChart'),
  new Chart('columnchart', 'ColumnChart'),
  new Chart('combochart', 'ComboChart'),
  new Chart('gauge', 'Gauge', false),
  new Chart('geochart', 'GeoChart', false),
  new Chart('histogram', 'Histogram'),
  new Chart('linechart', 'LineChart'),
  new Chart('map', 'Map', false),
  new Chart('orgchart', 'OrgChart', false),
  new Chart('piechart', 'PieChart'),
  new Chart('sankey', 'Sankey', false),
  new Chart('scatterchart', 'ScatterChart'),
  new Chart('steppedareachart', 'SteppedAreaChart', true),
  new Chart('table', 'Table', false),
  new Chart('timeline', 'Timeline', false),
  new Chart('treemap', 'TreeMap', false),
  new Chart('wordtree', 'Wordtree', false),
];

IOSink sink = new File('./lib/gen/chart_options.dart').openWrite();
IOSink sink_enums = new File('./lib/gen/chart_options/enums.dart').openWrite();
IOSink doc_sink = new File('./doc/chart_options.md').openWrite();
void printTree(Map tree, [Set<String> parentCharts=null, int indent = 0]) {
  tree.forEach((String key, value) {
    if(value is Map) {
      if(value.containsKey('_charts') && false) {
        if(parentCharts != null) {
          Set diffA = parentCharts.difference(value['_charts']);
          Set diffB = value['_charts'].difference(parentCharts);
          if(diffA.length > 0 || diffB.length > 0) {
            print("${'\t' * indent} ERROR -[${diffA.join(', ')}] +[${diffB.join(', ')}]");
          }
        } else if(value['_charts'].length > 1) {
          print("${'\t' * indent} $key: [${value['_charts'].join(', ')}]");
          if(value.keys.length > 1) {
            printTree(value, value['_charts'] , indent+1);
          }
        }
      } else {
        print("${'\t' * indent} $key");
        printTree(value, parentCharts, indent+1);
      }
    }
  });
}
main() async {
  sink.write(header);

  for(Chart chart in charts) {
    await http.get(urlPrefix + chart.name).then((http.Response r) => handleResponse(r, chart));
  }

  Set<String> getChartNames(Map m) {
    Set s = new Set();
    m.forEach((String key, val) {
      if(key == '_charts') {
        s.addAll(val.keys);
      } else if(val is Map) {
        s.addAll(getChartNames(val));
      }
    });
    return s;
  }

  List<String> flatOptionNames = [];
  optionsTree.forEach((String key, Map val) {
    // Charts Only
    if(val.keys.length == 1) {
      flatOptionNames.add(key);
      print('Flat: $key');
    } else {
      Set s = new Set();
      if(val.containsKey('_charts')) {
        s.addAll(val['_charts'].keys);
      }
      s.addAll(getChartNames(val));
      if(s.length == 1) {
        flatOptionNames.add(key);
        print('Single Chart: $key');
      }
    }
  });

  for(var k in flatOptionNames) {
    optionsTree.remove(k);
  }
  printTree(optionsTree);
}

String getDescription(Element td) {
  String desc = "";
  td.nodes.forEach((Node node) {
    if (node.nodeType == Node.TEXT_NODE) {
      desc += " " + node.text.trim().replaceAll(new RegExp(r'\n\s*'), '');
    } else {
      Element child = node as Element;
      switch (child.localName) {
        case 'p':
          desc += "\n" +
              child.text.trim().replaceAll(new RegExp(r'\n\s*'), '') +
              "\n";
          break;
        case 'pre':
          // 5 spaces indent
          desc += "\n     Code ...";
          break;
        case 'code':
          desc += " [" + child.text.trim() + "]";
          break;
        case 'br':
          desc += "\n";
          break;
        case 'ul':
          desc += "\n";
          child.querySelectorAll('li').forEach((Element li) {
            desc +=
                "* ${li.text.trim().replaceAll(new RegExp(r'\n\s*'), '\n  ')}\n";
          });
          break;
        case 'a':
          desc +=
              " [${child.text.replaceAll('\n', '').trim().replaceAll(new RegExp(r'\s\s*'), ' ')}](${child.attributes['href']})";
          break;
        default:
          // TODO(rh)
          //print(child.localName);
          break;
      }
    }
  });
  return desc.replaceAll('\n', '\n  /// ');
}

void handleResponse(http.Response r, Chart chart) {
  /// Parse html from [http.Response]
  Document doc = parse(r.body);
  // sink.write( "\n\nclass ${chart.className}${chart.isCoreChart ? ' extends CoreChartOptions' : ''} {");
  doc.querySelectorAll('table').forEach((Element e) {
    Element prev = e.previousElementSibling;
    if(prev.localName == 'p') {
      prev = prev.previousElementSibling;
    }

    if (prev.localName == 'h2') {
      String type = prev.querySelector('a').attributes['id'];
      switch (type) {
        case "Configuration_Options":
          print(chart.className);
          parseConfigurationOptions(e, chart);
          sink.write('class ${chart.className}Options {\n');
          chart.options.forEach((ConfigurationOption option) {
            sink.write("  /// ${getDescription(option.description)}\n");
            sink.write("  var ${option.name.replaceAll('.', '_')};\n");
          });
          // TODO(rh)
          sink.write("}\n\n");
          /*parseOptions(e).forEach((String opt, String desc) {
            optionToCharts.putIfAbsent(opt, () => []).add(chartClassName);
          });
          */
          break;
        case "Methods":
          //print('Methods');
          // parseMethods(e);
          break;
        case "Events" :
          //print('Events');
          break;
      }
    }
  });
}

final Map<String, dynamic> optionsTree = {};

void parseConfigurationOptions(Element table, Chart chart) {
  // Get all table rows from table and skip header
  final List<String> optionNames = [];
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    // Get td list
    List<Element> tdList = e.querySelectorAll('td');
    // Only proceed if there are tds (there was a bug where <tr><tr> appeared)
    if (tdList.isNotEmpty) {
      // Get text from td
      String name = tdList.first.text;
      String typeString = tdList.elementAt(1).text;
      String defaultValue = tdList.elementAt(2).text;
      Element descriptionElement = tdList.elementAt(3);
      //ConfigurationOption option = new ConfigurationOption(name, typeString, defaultValue, descriptionElement);
      //chart.options.add(option);
      List<String> keys = name.split('.');
      Iterator<String> it = keys.iterator;
      Map pointer = optionsTree;
      while (it.moveNext()) {
        pointer = pointer.putIfAbsent(it.current, () => {});
      }
      pointer.putIfAbsent('_charts', () => {})[chart.className] = {'type': typeString, 'default': defaultValue, 'description': getDescription(descriptionElement)};
    }
  });
}

  /*
  return;

  optionEnums.forEach((String optionName, Set<String> values) {
    // print(optionName);
    // Uppercase first letter and replace _e with E
    final String optionClassName = "${optionName}Option"
        .replaceFirstMapped(
            new RegExp("([a-zA-Z])"), (Match m) => m.group(1).toUpperCase())
        .replaceAllMapped(
            new RegExp("_([a-z])"), (Match m) => m.group(1).toUpperCase());
    sink_enums.write("class ${optionClassName} {\n");
    values.forEach((String value) {
      RegExp replaceRegExp = new RegExp(r"([A-Z])");
      sink_enums.write(
          "  static const $optionClassName ${value.replaceAllMapped(replaceRegExp, (Match m) => '_${m.group(1)}')
          .toUpperCase()} = const ${optionClassName}._('${value}');\n");
    });
    sink_enums.write("""  /// String value
  final String value;

  /// Internal const constructor
  const ${optionClassName}._(this.value);
}\n\n""");
  });

  List<String> optionsList = optionToCharts.keys.toList()
    ..sort((String k1, String k2) =>
        optionToCharts[k2].length - optionToCharts[k1].length);

  doc_sink.write("| Chart ");
  // HEADER
  for (String option in optionsList) {
    doc_sink.write("| $option (${optionToCharts[option].length}) ");
  }
  doc_sink.write(" |\n");
  // Seperator
  doc_sink.write("| ----- ");
  for (String option in optionsList) {
    doc_sink.write("| ${'-' * option.length} ");
  }
  doc_sink.write(" |\n");
  for (String chart in charts) {
    doc_sink.write("| $chart ");
    for (String option in optionsList) {
      doc_sink.write("| ${optionToCharts[option].contains(chart) ? 'x' : ''} ");
    }
    doc_sink.write(" |\n");
  }
  */
/*
Map<String, String> parseOptions(Element table) {
  Map<String, String> optionsList = {};
  //Map<String,String> options = {};
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> tdList = e.querySelectorAll('td');
    if (tdList.isNotEmpty) {
      String name = tdList.first.text /*.replaceAll('.', '_')*/;
      if (options.add(name)) {
        // print('New Option: $name');
      }
      return;
      String typeString = tdList.elementAt(1).text.toLowerCase();
      String defaultValue = tdList.elementAt(2).text;
      Element descriptionElement = tdList.elementAt(3);
      String descriptionText = getDescription(descriptionElement);

      RegExp stringRegExp =
          new RegExp(r"'([a-zA-Z]+)'"); // , caseSensitive: true <-- by  default
      Match defaultValueMatch = stringRegExp.matchAsPrefix(defaultValue);

      if (defaultValueMatch != null &&
          name.indexOf('color') == -1 &&
          name.indexOf('Color') == -1 &&
          typeString == 'string' &&
          name.indexOf('font') == -1 &&
          name.indexOf('Font') == -1) {
        Set<String> values = new Set();
        values.add(defaultValueMatch.group(1));
        Element ul = descriptionElement.querySelector('> ul');
        if (ul != null) {
          RegExp valuesRegExp =
              new RegExp(r"'?([a-zA-Z]+)'?\s*(\[default\]\s+)?[-|:]");
          ul.querySelectorAll('> li').forEach((Element li) {
            if (li.parent != ul) {
              return;
            }
            Match match = valuesRegExp.matchAsPrefix(li.text.trim());
            if (match != null) {
              values.add(match.group(1));
            }
          });
        } else {
          RegExp valuesRegExp = new RegExp(r"Supported values: ('.*?')\.");
          Iterable<Match> matches = valuesRegExp.allMatches(descriptionText);
          if (matches.length > 0) {
            RegExp valueRegExp = new RegExp(r"'([a-zA-Z]+)'");
            valueRegExp.allMatches(matches.first.group(1)).forEach((Match m) {
              values.add(m.group(1));
            });
          } else {
            RegExp valuesRegExp = new RegExp(r"\['([a-zA-Z]+)'\]");
            Iterable<Match> matches = valuesRegExp.allMatches(descriptionText);
            if (matches.length > 0) {
              matches.forEach((Match m) {
                values.add(m.group(1));
              });
            } else {
              RegExp valuesRegExp = new RegExp(r"'([a-zA-Z]+)'");
              Iterable<Match> matches =
                  valuesRegExp.allMatches(descriptionText);
              if (matches.length > 0) {
                matches.forEach((Match m) {
                  values.add(m.group(1));
                });
              } else {
                // OK: calendar_daysOfWeek, pieResidueSliceLabel
                // ERR: wordtree_format, wordtree_type
                //print('\tERR: $name <--> $defaultValue');
                //print('\t$descriptionText');
              }
            }
          }
        }

        if (values.isNotEmpty) {
          optionEnums[name] = values;
        } else {
          print('\t$name <--> ERROR');
        }
      }

      optionsList[name] = descriptionText;

      if (name.indexOf('<') != -1) {
        print('Skip $name');
        return;
      }

      var type = 'var';
      if (defaultValue != 'auto' && defaultValue != null) {
        switch (typeString) {
          case 'number':
            type = 'num';
            break;
          case 'integer':
          case '1 or -1':
            type = 'int';
            break;
          case 'string':
            type = 'String';
            break;
          case 'object':
            type = 'Object';
            break;
          case 'string or object':
          case 'number or string':
            type = 'var';
            break;
          case 'boolean':
            type = 'bool';
            break;
          case 'array of strings':
            type = 'List<String>';
            break;
          case 'array of numbers':
            type = 'List<num>';
            break;
          case 'date':
            type = 'DateTime';
            break;
          default:
            // TODO(rh)
            // print('Unknown Type: $typeString');
            break;
        }
      }
      // replaceAll('\n\n', '<br>').replaceAll('\n', '').replaceAll('<br>', '\n').replaceAll('\n', '\n  /// ')
      sink.write("\n  /// ${descriptionText}");
      sink.write("\n  $type $name;\n");
    }
  });

  return optionsList;
}

void parseMethods(Element table) {
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> td = e.querySelectorAll('td');
    if (td.isNotEmpty) {
      // print(td.first.text);
    }
  });
}
*/