import 'package:hive/hive.dart';
import 'package:kinfolk/global_variables.dart';
import 'package:kinfolk/service/utils.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'dart:io';

/// @author yeras-is
class Authorization {
  oauth2.Client _client;

  Future<oauth2.Client> get client async {
    if (_client != null) return _client;
    // if _client is null we instantiate it
    _client = await getFromSavedCredentials();
    return _client;
  }

  getAccessToken(String username, String password) async {
    final authorizationEndpoint =
        Uri.parse(GlobalVariables.urlEndPoint + "/rest/v2/oauth/token?");

    try {
      _client = await oauth2.resourceOwnerPasswordGrant(
          authorizationEndpoint, username, password,
          identifier: GlobalVariables.identifier,
          secret: GlobalVariables.secret);
    } on SocketException {
      return GlobalVariables.connectionTimeCode;
    } on oauth2.AuthorizationException {
      return GlobalVariables.accessErrorCode;
    } on FormatException catch (e) {
      return e.message;
    } on HandshakeException catch (e) {
      return e.toString();
    }
    GlobalVariables.token = _client.credentials.accessToken;

    var box = await Hive.openBox('credentials');
    box.put('json', _client.credentials.toJson());
    return _client;
  }

  getFromSavedCredentials() async {
    Box box = await HiveService.getBox('credentials');
    var name = box.get('json');

    // If the OAuth2 credentials have already been saved from a previous run, we
    // just want to reload them.
    if (name != null) {
      var credentials = new oauth2.Credentials.fromJson(name);
      try {
        _client = oauth2.Client(credentials,
            identifier: GlobalVariables.identifier,
            secret: GlobalVariables.secret);
      } on SocketException {
        return GlobalVariables.connectionTimeCode;
      } on oauth2.AuthorizationException {
        return GlobalVariables.accessErrorCode;
      } on FormatException catch (e) {
        return e.message;
      }
      GlobalVariables.token = _client.credentials.accessToken;
      return _client;
    } else
      return null;
  }

  getFileUrlByFileDescriptorId(String fileDescriptorId) =>
      "${GlobalVariables.urlEndPoint}/rest/v2/files/$fileDescriptorId?access_token=${GlobalVariables.token}";
}
