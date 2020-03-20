library core;

import 'package:core/global_variables.dart';
import 'service/auth.dart';

class Kinfolk {
  /// A Calculator.
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  void initializeBaseVariables(
      String urlEndPoint, String identifier, String secret) {
    GlobalVariables.urlEndPoint = urlEndPoint;
    GlobalVariables.identifier = identifier;
    GlobalVariables.secret = secret;
  }

  getClient() => Authorization().client;

  getToken(String login, String password) =>
      Authorization().getAccessToken(login, password);

  getFileUrl(String fileDescriptorId) =>
      Authorization().getFileUrlByFileDescriptorId(fileDescriptorId);

  get serviceUrl => "${GlobalVariables.urlEndPoint}/v2/services/";
  get queriesUrl => "${GlobalVariables.urlEndPoint}/v2/queries/";
  get entitiesUrl => "${GlobalVariables.urlEndPoint}/v2/entities/";

}
