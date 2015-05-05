import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'dart:io';

final String header = """library google_visualization_api.chart.options;

part 'chart_options/types.dart';

class CoreChartOptions {
}
""";

final Set<String> options = new Set();
final Set<String> charts = new Set();

final Map<String, List<String>> optionToCharts = {};

File f = new File('./lib/gen/chart_options.dart');
IOSink sink = f.openWrite();

IOSink doc_sink = new File('./doc/chart_options.md').openWrite();

String getDescription(Element td) {
  String desc = "";
  td.nodes.forEach((Node node) {
    if(node.nodeType == Node.TEXT_NODE) {
      desc += " " + node.text.trim().replaceAll(new RegExp(r'\n\s*'), '');
    } else {
      Element child = node as Element;
      switch(child.localName) {
        case 'p' :
            desc += "\n" + child.text.trim().replaceAll(new RegExp(r'\n\s*'), '') + "\n";
          break;
        case 'pre' :
          // 5 spaces indent
          desc += "\n     Code ...";
          break;
        case 'code' :
          desc += " [" + child.text.trim() + "]";
          break;
        case 'br' :
            desc += "\n";
          break;
        case 'ul' :
          desc += "\n";
            child.querySelectorAll('li').forEach((Element li) {
              desc += "* ${li.text.trim().replaceAll(new RegExp(r'\n\s*'), '\n  ')}\n";
            });
        break;
        case 'a' :
            desc += " [${child.text.replaceAll('\n', '').trim().replaceAll(new RegExp(r'\s\s*'), '\s')}](${child.attributes['href']})";
          break;
        default :
          print(child.localName);
          break;
      }
    }
  });
  return desc.replaceAll('\n', '\n  /// ');
}

main() async {
  sink.write(header);

  Map<String,Map> chartUrls = {
    'https://developers.google.com/chart/interactive/docs/gallery/annotationchart' : {'className': 'AnnotationChartOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/areachart' : {'className': 'AreaChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/barchart' : {'className': 'BarChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/bubblechart' : {'className': 'BubbleChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/calendar' : {'className': 'CalendarOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart' : {'className': 'CandlestickChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/columnchart' : {'className': 'ColumnChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/combochart' : {'className': 'ComboChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/gauge' : {'className': 'GaugeOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/geochart' : {'className': 'GeoChartOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/histogram' : {'className': 'HistogramOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/linechart' : {'className': 'LineChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/map' : {'className': 'MapOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/orgchart' : {'className': 'OrgChartOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/piechart' : {'className': 'PieChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/sankey' : {'className': 'SankeyOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/scatterchart' : {'className': 'ScatterChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/steppedareachart' : {'className': 'SteppedAreaChartOptions', 'coreChart': true},
    'https://developers.google.com/chart/interactive/docs/gallery/table' : {'className': 'TableOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/timeline' : {'className': 'TimelineOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/treemap' : {'className': 'TreeMapOptions', 'coreChart': false},
    'https://developers.google.com/chart/interactive/docs/gallery/wordtree' : {'className': 'WordtreeOptions', 'coreChart': false}
  };

  for(String url in chartUrls.keys) {
    await http.get(url).then((http.Response r) {
      Document doc = parse(r.body);
      final String chartClassName = chartUrls[url]['className'];
      print(chartClassName);
      final bool isCoreChart = chartUrls[url]['coreChart'];
      charts.add(chartClassName);
      sink.write("\n\nclass ${chartClassName}${isCoreChart ? ' extends CoreChartOptions' : ''} {");
      doc.querySelectorAll('table').forEach((Element e) {
        Element prev = e.previousElementSibling;
        if(prev.localName == 'h2') {
          String type = prev.querySelector('a').attributes['id'];
          switch(type) {
            case "Configuration_Options" :
              parseOptions(e).forEach((String opt, String desc) {
                optionToCharts.putIfAbsent(opt, () => []).add(chartClassName);
              });
              break;
            case "Methods" :
              //parseMethods(e);
              break;
          }
        }
      });
      sink.write("\n}");
    });
  }

  List<String> optionsList = optionToCharts.keys.toList()..sort((String k1, String k2) => optionToCharts[k2].length - optionToCharts[k1].length);

  doc_sink.write("| Chart ");
  // HEADER
  for(String option in optionsList) {
    doc_sink.write("| $option (${optionToCharts[option].length}) ");
  }
  doc_sink.write(" |\n");
  // Seperator
  doc_sink.write("| ----- ");
  for(String option in optionsList) {
    doc_sink.write("| ${'-' * option.length} ");
  }
  doc_sink.write(" |\n");
  for(String chart in charts) {
    doc_sink.write("| $chart ");
    for(String option in optionsList) {
      doc_sink.write("| ${optionToCharts[option].contains(chart) ? 'x' : ''} ");
    }
    doc_sink.write(" |\n");
  }
}

Map<String,String> parseOptions(Element table) {
  Map<String,String> optionsList = {};
  //Map<String,String> options = {};
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> tdList = e.querySelectorAll('td');
    if(tdList.isNotEmpty) {
      String name = tdList.first.text.replaceAll('.', '_');
      String typeString = tdList.elementAt(1).text.toLowerCase();
      String defaultValue = tdList.elementAt(2).text;
      Element descriptionElement = tdList.elementAt(3);
      String descriptionText = getDescription(descriptionElement);
      // descriptionElement.querySelectorAll('ul').forEach((Element e) => e.remove());
      // descriptionElement.querySelectorAll('code').forEach((Element e) => e.remove());
      // String descriptionText = descriptionElement.text.trim();
      /*
      switch(descriptionNode.nodeType) {
        case Node.ELEMENT_NODE :
          descriptionText = ;
          break;
        case Node.TEXT_NODE :
          descriptionText = descriptionNode.text.split('\n').first;
          break;
      }
      */
      //print('\t$name <--> "$descriptionText"\n');
      optionsList[name] = descriptionText;
      if(options.add(name)) {
        // print('New Option: $name');
      }

      if(name.indexOf('<') != -1) {
        print('Skip $name');
        return;
      }

      var type = 'var';
      if(defaultValue != 'auto' && defaultValue != null) {
        switch(typeString) {
          case 'number':
            type = 'num';
            break;
          case 'integer' :
          case '1 or -1' :
            type = 'int';
          break;
          case 'string' :
            type = 'String';
          break;
          case 'object' :
            type = 'Object';
            break;
          case 'string or object' :
          case 'number or string' :
            type = 'var';
            break;
          case 'boolean' :
            type = 'bool';
            break;
          case 'array of strings' :
            type = 'List<String>';
            break;
          case 'array of numbers' :
            type = 'List<num>';
            break;
          case 'date' :
            type = 'DateTime';
            break;
          default :
            print('Unknown Type: $typeString');
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
    if(td.isNotEmpty) {
      // print(td.first.text);
    }
  });
}