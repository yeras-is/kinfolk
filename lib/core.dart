library core;

import 'package:core/global_variables.dart';
import 'service/auth.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  void initializeBaseVariables(
      String urlEndPoint, String identifier, String secret) {
    GlobalVariables.urlEndPoint = urlEndPoint;
    GlobalVariables.identifier = identifier;
    GlobalVariables.secret = secret;
  }

  getToken(String login, String password) =>
      Authorization().getAccessToken(login, password);

  getFileUrl(String fileDescriptorId) =>
      Authorization().getFileUrlByFileDescriptorId(fileDescriptorId);
}
