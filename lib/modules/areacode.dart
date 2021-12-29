import 'dart:convert' as convert;
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:io';
import 'package:localdb/jsondb.dart';
import 'package:localdb/file/file.dart';

class areaCode {
  Future<List<String>?> _getLocationNameList() async {
    String authority = 'openapi.1365.go.kr';
    String unencodedPath =
        '/openapi/service/rest/CodeInquiryService/getAreaCodeInquiryList';
    Map<String, dynamic> queryParameters = {'numOfRows': '1000'};

    var url = Uri.http(authority, unencodedPath, queryParameters);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(convert.utf8.decode(response.bodyBytes));
      var jsonString = xml2Json.toParker();
      var data = convert.jsonDecode(jsonString);

      List<dynamic> itemList = data['response']['body']['items']['item'];
      List<String> areaNameList = [];
      for (dynamic item in itemList) {
        areaNameList.add('${item['sidoNm']} ${item['gugunNm']}');
      }

      return areaNameList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getAreacodeList() async {
    var pathFile = "${Directory.current.path}/data.json";
    var db = jsondb(FileSync(pathFile));

    List<String>? locationNameList = await _getLocationNameList();
    db.defaults({'locatoin': locationNameList}).write();
    String authority = 'apis.data.go.kr';
    String unencodedPath = '/1741000/StanReginCd/getStanReginCdList';
    String serviceKey =
        'WXZVShXP5zLAP2iYjC81FmdWLJdd9OEimzGZw4bml1mQybtdZqwnEGV4pcaYEz4BINLSZAQ0HjaURTW197pGdg==';
    String numOfRows = '1000';
    Map<String, dynamic> queryParameters = {
      'ServiceKey': serviceKey,
      'numOfRows': numOfRows,
      'type': 'json',
    };

    int pageNo = 1;
    List<dynamic> areacodeList = [];
    while (true) {
      print('target page : ${pageNo}');
      queryParameters['pageNo'] = pageNo.toString();
      var url = Uri.http(authority, unencodedPath, queryParameters);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body)['StanReginCd'];
        if (data == null) break;

        areacodeList.addAll(data.last['row']);
      } else {
        print(response.statusCode);
      }

      pageNo++;
    }

    for (var areacode in areacodeList) {
      String locationName = areacode['locatadd_nm'];
      Iterable<String> searchList =
          locationNameList!.where((element) => element == locationName);
      if (searchList.length > 0) print(areacode.toString());
    }

    // db.defaults({'areacode': areacodeList}).write();

    print(areacodeList.length);
  }
}
