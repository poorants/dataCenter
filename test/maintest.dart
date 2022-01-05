void main() {
  List<Map> sampleList = [];
  sampleList.addAll([
    {'code': '1991'},
    {'code': '1331'},
    {'name': 'sample'}
  ]);
  print(sampleList);
  String searchString = 'new';
  Map rst = sampleList.firstWhere((element) => element['code'] == searchString,
      orElse: () => {});

  print(rst.isEmpty);
  print(rst);
}
