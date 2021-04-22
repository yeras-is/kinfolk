import 'service/exceptions.dart';


class GlobalVariables {
  static String? _urlEndPoint;
  static String? _identifier;
  static String? _secret;
  static String? token;

  static final String connectionTimeCode = "CONNECTION_TIME_OUT";
  static final String accessErrorCode = "ACCESS_ERROR";

  static String? get identifier {
    if (_identifier == null || _identifier!.isEmpty)
      throw NullOrEmptyArgument("GlobalVariables.identifier");
    return _identifier;
  }

  static String? get secret {
    if (_secret == null || _secret!.isEmpty)
      throw NullOrEmptyArgument("GlobalVariables.secret");
    return _secret;
  }

  static String? get urlEndPoint {
    if (_urlEndPoint == null || _urlEndPoint!.isEmpty)
      throw NullOrEmptyArgument("GlobalVariables.urlEndPoint");
    return _urlEndPoint;
  }

  
  static set urlEndPoint(String? value) => _urlEndPoint = value;

  static set identifier(String? value) => _identifier = value;

  static set secret(String? value) => _secret = value;

}
