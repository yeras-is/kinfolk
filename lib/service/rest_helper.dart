import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:kinfolk/model/url_types.dart';
import 'package:kinfolk/service/auth.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class RestHelper {
  getSingleModelRest(
      {@required String serviceName,
      @required String methodName,
      @required Types type,
      String body,
      @required Function(Map<String, dynamic> json) fromMap}) async {
    String url = Kinfolk.createRestUrl(serviceName, methodName, type);
    oauth2.Client client = await Authorization().client;

    var response;

    if (body != null) {
      response = await getPostResponse(url: url, body: body, client: client);
    } else {
      response = await getGetResponse(url: url, client: client);
    }

    var respBody = response.body;
    if (respBody.runtimeType == String && respBody.isEmpty) {
      return null;
    }
    var source = jsonDecode(respBody);
    assert(source is Map);

    return fromMap(source);
  }

  getListModelRest(
      {@required String serviceName,
      @required String methodName,
      @required Types type,
      String body,
      @required Function(Map<String, dynamic> json) fromMap}) async {
    String url = Kinfolk.createRestUrl(serviceName, methodName, type);
    oauth2.Client client = await Authorization().client;

    var response;

    if (body != null) {
      response = await getPostResponse(url: url, body: body, client: client);
    } else {
      response = await getGetResponse(url: url, client: client);
    }

    var source = jsonDecode(response.body);
    assert(source is List);

    List list = List();

    source.forEach((item) => list.add(fromMap(item)));

    return list;
  }

  getPostResponse(
          {@required url,
          @required body,
          @required oauth2.Client client}) async =>
      await client.post(url, body: body, headers: Kinfolk.appJsonHeader);

  getGetResponse({@required url, @required oauth2.Client client}) async =>
      await client.get(url, headers: Kinfolk.appJsonHeader);
}
