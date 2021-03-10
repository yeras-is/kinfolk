import 'package:hive/hive.dart';
import 'package:kinfolk/model/url_types.dart';

import '../global_variables.dart';

class Utils {
  /// creating REST url : http://localhost:8080/test/v2/services/serviceName/methodName
  /// creating REST url : http://localhost:8080/test/v2/entities/entityName/id
  /// creating REST url : http://localhost:8080/test/v2/entities/entityName/search
  /// creating REST url : http://localhost:8080/test/v2/queries/entityName/queryName
  static String createRestUrl(
      String serviceOrEntityName, String methodNameOrEntityId, Types type) {
    String? urlSuffix = UrlTypes.path[type];
    return "${GlobalVariables.urlEndPoint}/rest/v2/$urlSuffix/$serviceOrEntityName/$methodNameOrEntityId";
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

  static getClearBox(String name) async {
    Box box = await getBox(name);
    await box.clear().catchError((val) => print(val));
    return box;
  }
}
