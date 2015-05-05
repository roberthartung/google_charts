import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'dart:io';

final String header = """library google_visualization_api.chart.options;

part 'chart_options/types.dart';""";

final Set<String> options = new Set();
final Set<String> charts = new Set();

final Map<String, List<String>> optionToCharts = {};

File f = new File('./lib/gen/chart_options.dart');
IOSink sink = f.openWrite();

IOSink doc_sink = new File('./doc/chart_options.md').openWrite();

main() async {
  sink.write(header);

  Map<String,Map> chartUrls = {
    'https://developers.google.com/chart/interactive/docs/gallery/annotationchart' : {'className': 'AnnotationChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/areachart' : {'className': 'AreaChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/barchart' : {'className': 'BarChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/bubblechart' : {'className': 'BubbleChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/calendar' : {'className': 'CalendarOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart' : {'className': 'CandlestickChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/columnchart' : {'className': 'ColumnChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/combochart' : {'className': 'ComboChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/gauge' : {'className': 'GaugeOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/geochart' : {'className': 'GeoChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/histogram' : {'className': 'HistogramOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/linechart' : {'className': 'LineChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/map' : {'className': 'MapOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/orgchart' : {'className': 'OrgChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/piechart' : {'className': 'PieChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/sankey' : {'className': 'SankeyOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/scatterchart' : {'className': 'ScatterChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/steppedareachart' : {'className': 'SteppedAreaChartOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/table' : {'className': 'TableOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/timeline' : {'className': 'TimelineOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/treemap' : {'className': 'TreeMapOptions'},
    'https://developers.google.com/chart/interactive/docs/gallery/wordtree' : {'className': 'WordtreeOptions'}
  };

  for(String url in chartUrls.keys) {
    await http.get(url).then((http.Response r) {
      Document doc = parse(r.body);
      final String chartClassName = chartUrls[url]['className'];
      charts.add(chartClassName);
      sink.write("\n\nclass ${chartClassName} {");
      doc.querySelectorAll('table').forEach((Element e) {
        Element prev = e.previousElementSibling;
        if(prev.localName == 'h2') {
          String type = prev.querySelector('a').attributes['id'];
          switch(type) {
            case "Configuration_Options" :
                for(String opt in parseOptions(e)) {
                  optionToCharts.putIfAbsent(opt, () => []).add(chartClassName);
                }
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

List<String> parseOptions(Element table) {
  List<String> optionsList = [];
  //Map<String,String> options = {};
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> tdList = e.querySelectorAll('td');
    if(tdList.isNotEmpty) {
      String name = tdList.first.text.replaceAll('.', '_');
      String typeString = tdList.elementAt(1).text.toLowerCase();
      String defaultValue = tdList.elementAt(2).text;

      optionsList.add(name);
      if(options.add(name)) {
        // print('New Option: $name');
      }

      if(name.indexOf('<') != -1) {
        print('Skip $name');
        return;
      }

      var type = 'var';
      if(defaultValue == 'auto' || defaultValue == null) {

      } else {
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
            //print(type);
            break;
        }
      }
      sink.write("\n  $type $name;");
      // options[name] = defaultValue;
      // print(tdList.first.text);
      /*
      tdList.forEach((Element td) {
        List<Element> codeList = td.querySelectorAll('code');
        if(codeList.isNotEmpty) {
          codeList.forEach((Element code) {
            print(code.text);
          });
        }
      });
      */
    }
  });
  /*
  options.forEach((String k, String v) {
    print('\t\t$k: $v,');
  });
  */

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