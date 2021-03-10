library kinfolk;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kinfolk/global_variables.dart';
import 'package:kinfolk/service/rest_helper.dart';
import 'package:kinfolk/service/utils.dart';
import 'model/cuba_entity_filter.dart';
import 'model/url_types.dart';
import 'service/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Kinfolk {
  /// A Calculator.
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  /// setting server url and security keys (identifier,secret)
  void initializeBaseVariables(
      String urlEndPoint, String identifier, String secret) async {
    GlobalVariables.urlEndPoint = urlEndPoint;
    GlobalVariables.identifier = identifier;
    GlobalVariables.secret = secret;
    await Hive.initFlutter();
  }

  /// getting client from saved Access Token
  static getClient() async => await Authorization().client;

  /// getting client (service with Access Token) in first time with login,password
  getToken(String login, String password) async =>
      await Authorization().getAccessToken(login, password);

  /// getting getFileUrl
  static getFileUrl(String fileDescriptorId) =>
      Authorization().getFileUrlByFileDescriptorId(fileDescriptorId);

  /// create Rest Url
  static String createRestUrl(
          String serviceName, String methodName, Types type) =>
      Utils.createRestUrl(serviceName, methodName, type);

  /// getting list<dynamic> from REST
  static getListModelRest(
          {required String serviceOrEntityName,
          required String methodName,
          required Types type,
          String? body,
          CubaEntityFilter? filter,
          required Function(Map<String, dynamic> json) fromMap}) async =>
      await RestHelper().getListModelRest(
          serviceOrEntityName: serviceOrEntityName,
          methodName: methodName,
          type: type,
          fromMap: fromMap,
          filter: filter,
          body: body);

  ///  getting model from REST
  static getSingleModelRest(
          {required String serviceName,
          required String methodName,
          required Types type,
          String? body,
          required Function(Map<String, dynamic> json) fromMap}) async =>
      await RestHelper().getSingleModelRest(
          serviceOrEntityName: serviceName,
          methodName: methodName,
          type: type,
          fromMap: fromMap,
          body: body);

  static get appJsonHeader => {'Content-Type': 'application/json'};
}
