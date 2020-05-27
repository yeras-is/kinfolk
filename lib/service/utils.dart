import 'package:kinfolk/model/url_types.dart';
import 'package:hive/hive.dart';

import '../global_variables.dart';

class Utils {
  /// creating REST url : http://localhost:8080/test/v2/services/serviceName/methodName
  static String createRestUrl(
      String serviceName, String methodName, Types type) {
    String urlSuffix = UrlTypes.path[type];
    return "${GlobalVariables.urlEndPoint}/rest/v2/$urlSuffix/$serviceName/$methodName";
  }
}

class HiveService {
  static getBox(String name) async {
    Box box;
    if (!Hive.isBoxOpen(name)) {
      box = await Hive.openBox(name);
    } else {
      box = Hive.box(name);
    }
    return box;
  }
}
