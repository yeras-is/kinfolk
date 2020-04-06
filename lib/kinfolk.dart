library kinfolk;

import 'package:flutter/foundation.dart';
import 'package:kinfolk/global_variables.dart';
import 'package:kinfolk/service/rest_helper.dart';
import 'package:kinfolk/service/utils.dart';
import 'model/url_types.dart';
import 'service/auth.dart';

class Kinfolk {
  /// A Calculator.
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  /// setting server url and security keys (identifier,secret)
  void initializeBaseVariables(
      String urlEndPoint, String identifier, String secret) {
    GlobalVariables.urlEndPoint = urlEndPoint;
    GlobalVariables.identifier = identifier;
    GlobalVariables.secret = secret;
  }

  /// getting client from saved Access Token
  static getClient() async => await Authorization().client;

  /// getting client (service with Access Token) in first time with login,password
  getToken(String login, String password) async =>
      await Authorization().getAccessToken(login, password);

  static getFileUrl(String fileDescriptorId) =>
      Authorization().getFileUrlByFileDescriptorId(fileDescriptorId);

  static String createRestUrl(
          String serviceName, String methodName, Types type) =>
      Utils.createRestUrl(serviceName, methodName, type);

  static getListModelRest(
          {@required String serviceName,
          @required String methodName,
          @required Types type,
          String body,
          @required dynamic Function(Map<String, dynamic> json) fromMap}) async =>
      await RestHelper().getListModelRest(
          serviceName: serviceName,
          methodName: methodName,
          type: type,
          fromMap: fromMap,
          body: body);

  static getSingleModelRest(
          {@required String serviceName,
          @required String methodName,
          @required Types type,
          String body,
          @required dynamic Function(Map<String, dynamic> json) fromMap}) async =>
      await RestHelper().getSingleModelRest(
          serviceName: serviceName,
          methodName: methodName,
          type: type,
          fromMap: fromMap,
          body: body);

  static get appJsonHeader => {'Content-Type': 'application/json'};
}
