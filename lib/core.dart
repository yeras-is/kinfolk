library core;

import 'package:core/global_variables.dart';
import 'package:flutter/material.dart';
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

  getText(String text) => Text(
        text,
        style: TextStyle(color: Colors.green, fontSize: 15),
      );
}
