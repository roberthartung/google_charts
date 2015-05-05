import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  // RegExp tableRegExp = new RegExp(r'<h2><a.*?id="(.*?)">.*?</h2>\s*<table>(.*)</table>', multiLine: true, caseSensitive: false);
  List<String> chartUrls = [
    'https://developers.google.com/chart/interactive/docs/gallery/annotationchart',
    'https://developers.google.com/chart/interactive/docs/gallery/areachart',
    'https://developers.google.com/chart/interactive/docs/gallery/barchart',
    'https://developers.google.com/chart/interactive/docs/gallery/bubblechart',
    'https://developers.google.com/chart/interactive/docs/gallery/calendar',
    'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart'
    ];

  chartUrls.forEach((String url) {
    http.get(url).then((http.Response r) {
      Document doc = parse(r.body);
      doc.querySelectorAll('table').forEach((Element e) {
        Element prev = e.previousElementSibling;
        if(prev.localName == 'h2') {
          String type = prev.querySelector('a').attributes['id'];
          print(type);
          switch(type) {
            case "Configuration_Options" :
                parseOptions(e);
              break;
            case "Methods" :
              //parseMethods(e);
              break;
          }
        }
      });
    });
  });
}

void parseOptions(Element table) {
  Map<String,String> options = {};
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> tdList = e.querySelectorAll('td');
    if(tdList.isNotEmpty) {
      String name = tdList.first.text.replaceAll('.', '_');
      String type = tdList.elementAt(1).text.toLowerCase();
      String defaultValue = tdList.elementAt(2).text;

      if(defaultValue == 'auto' || defaultValue == null) {
        return;
      }

      switch(type) {
        case 'number':
        case '1 or -1' :
        case 'string' :
        case 'integer' :
        case 'object' :
        case 'boolean' :
        case 'string or object' :
        case 'number or string' :
        case 'array of strings' :
        case 'array of numbers' :
        case 'date' :

          break;
        default :
          print(type);
          break;
      }
      options[name] = defaultValue;
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
}

void parseMethods(Element table) {
  table.querySelectorAll('tr').skip(1).forEach((Element e) {
    List<Element> td = e.querySelectorAll('td');
    if(td.isNotEmpty) {
      // print(td.first.text);
    }
  });
}