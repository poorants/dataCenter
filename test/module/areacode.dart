import 'dart:convert';

import 'package:data_center/modules/areacode.dart';
import 'package:data_center/models/district-model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:localdb/jsondb.dart';
import 'package:localdb/file/file.dart';
import 'package:path/path.dart' as p;

void main() async {
  areaCode tm = areaCode();
  // await tm.getAreacodeList();

  List<DistrictModel> districtList = [];
  districtList.add(DistrictModel(distrinctName: '서울특별시', cityList: []));

  DistrictModel model =
      districtList.firstWhere((element) => element.distrinctName == '서울특별시');
  model.addCity(name: '종로구', code: '21000');
  // model.cityList.add(CityModel(name: '서울특별시 종로구', code: '11111'));

  print(districtList.toString());
  print(model.cityCount());

  // model.removeCity(name: '종로구');
  // print(districtList.toString());
  // print(model.cityCount());

  var pathFile = "${Directory.current.path}/test.json";
  var db = jsondb(FileSync(pathFile));
  db.get("region").push(jsonDecode(model.toJson())).write();

  // List<String> regionList = ['남해', '진주'];
  // dynamic result = regionList.contains('서울');
  // print(result);
  // List<String>? locationNameList = await tm.getLocationNameList();

  // Stopwatch stopwatch = new Stopwatch()..start();
  // var pathFile = p.join(Directory.current.path, 'data', 'data.json');
  // print(pathFile);
  // var db = jsondb(FileSync(pathFile));
  // db.defaults({'sample': 'test'}).write();
  // List<dynamic> locationList = db.get('locatoin').value();
  // print('데이터베이스 로드 시간 ${stopwatch.elapsed}');

  // print(locationList.runtimeType);

  // Iterable<dynamic> target = locationList.where((element) => true);
  // print(target.runtimeType);
  // print(target.length);

  // stopwatch.start();
  // print(areaTable.find({"locatadd_nm": "경상남도 남해군"}));
  // print(areaTable.find({"locatadd_nm": "경상남도 진주시"}));
  // print('데이터베이스 검색 시간 ${stopwatch.elapsed}');
}
