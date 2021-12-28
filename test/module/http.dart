import 'package:data_center/modules/testmodule.dart';

void main() async {
  httpModule tm = httpModule();
  await tm.getSample();
}
