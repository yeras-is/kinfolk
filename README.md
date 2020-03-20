# core

A new Flutter package for integration with CUBA Platform based backend.

# Features
  - Authorization via the Rest Api using your username and password
  - Storing and reusing Access Token
  - Compliance with the CUBA documentation for the [REST API](https://doc.cuba-platform.com/restapi-7.2/). (at the moment partial)

### Installation

in your pubspec.yaml add dependency

```sh
dependencies:
  flutter:
    sdk: flutter
  core:
    git:
      url: git://github.com/yeras-is/core
```
then run.  packages get

### Example 

```dart
/// initialize service
Kinfolk kinfolk = Kinfolk();
/// setting server url and security keys (identifier,secter)
kinfolk.initializeBaseVariables(
      "http://localhost:8080/test", "identifier", "secret");
      
/// getting client (service with Access Token) in first time after login
oauth2.Client client = await kinfolk.getToken("admin", "admin");

///  url to service 
///  [kinfolk.serviceUrl] - getting completed service url http://localhost:8080/test/v2/services/
///  test_SomeService  -  service name 
///  getToDoList - method name
String url = "${kinfolk.serviceUrl}test_SomeService/getToDoList";

// getting response from server. GET method
var response = await client.get(url,
      headers: {'Content-Type': 'application/json'});
/// printing body of response
print("${response.body}");

/// getting client from saved Access Token
oauth2.Client client2 = await kinfolk.getClient();

///  url to service 
String url2 = "${kinfolk.serviceUrl}test_SomeService/setToDoList";

///  request body 
String body = """
      {
      "monday":"work";
      "sunday":"relax";
      }
  """;

// getting response from server. POST method
var response2 = await client2.post(
      url2,
      body: body,
      headers: {'Content-Type': 'application/json'});
/// printing body of response
print("${response2.body}");
```