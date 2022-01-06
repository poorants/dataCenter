import 'dart:convert';
import 'package:flutter/foundation.dart';

class CityModel {
  final String name;
  final String code;
  CityModel({
    required this.name,
    required this.code,
  });

  CityModel copyWith({
    String? name,
    String? code,
  }) {
    return CityModel(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source));

  @override
  String toString() => 'CityModel(name: $name, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CityModel && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}

class DistrictModel {
  final String distrinctName;
  final List<CityModel> cityList;
  DistrictModel({
    required this.distrinctName,
    required this.cityList,
  });

  DistrictModel copyWith({
    String? distrinctName,
    List<CityModel>? cityList,
  }) {
    return DistrictModel(
      distrinctName: distrinctName ?? this.distrinctName,
      cityList: cityList ?? this.cityList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distrinctName': distrinctName,
      'cityList': cityList.map((x) => x.toMap()).toList(),
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      distrinctName: map['distrinctName'] ?? '',
      cityList: List<CityModel>.from(
          map['cityList']?.map((x) => CityModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictModel.fromJson(String source) =>
      DistrictModel.fromMap(json.decode(source));

  addCity({required String name, required String code}) {
    cityList.add(CityModel(name: name, code: code));
  }

  removeCity({required String name}) {
    CityModel? targetCity =
        cityList.firstWhere((element) => element.name == name);
    cityList.remove(targetCity);
  }

  int cityCount() {
    return cityList.length;
  }

  @override
  String toString() =>
      'DistrictModel(distrinctName: $distrinctName, cityList: $cityList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistrictModel &&
        other.distrinctName == distrinctName &&
        listEquals(other.cityList, cityList);
  }

  @override
  int get hashCode => distrinctName.hashCode ^ cityList.hashCode;
}
