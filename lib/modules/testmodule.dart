import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart';
import 'package:xml2json/xml2json.dart';

class httpModule {
  draw() {
    print('http modules');
  }

  getSample() async {
    var url = Uri.http(
        'openapi.molit.go.kr:8081',
        '/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade',
        {
          'serviceKey':
              'WXZVShXP5zLAP2iYjC81FmdWLJdd9OEimzGZw4bml1mQybtdZqwnEGV4pcaYEz4BINLSZAQ0HjaURTW197pGdg==',
          'LAWD_CD': '11110',
          'DEAL_YMD': '202111'
        });

    // Await the http get response, then decode the json-formatted response.
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(convert.utf8.decode(response.bodyBytes));
      var jsonString = xml2Json.toParker();
      print(jsonString);
      var data = convert.jsonDecode(jsonString);
      // print(data['response']['body']['items']['item'][0]['거래금액']);
      print(data['response']['body']['items']['item'].length);

      // print(convert.utf8.decode(response.bodyBytes));
      // XmlDocument? xmlDocument =
      //     XmlDocument.from(convert.utf8.decode(response.bodyBytes));

      // print(xmlDocument.toString());

      // XmlDocument? xmlDocument =
      //     XmlDocument.from(convert.utf8.decode(response.bodyBytes));
      // print(xmlDocument!.xmlDeclaration!.encoding);
      //   var jsonResponse =
      //       convert.jsonDecode(response.body) as Map<String, dynamic>;
      //   print(jsonResponse.toString());
      // var itemCount = jsonResponse['totalItems'];
      // print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
