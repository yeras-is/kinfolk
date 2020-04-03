# kinfolk

A new Flutter package for integration with CUBA Platform based backend.

<a href="https://github.com/yeras-is/core/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-APACHE2.0-blue.svg?longCache=true&style=flat-square"></a>
   <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Built%20for-Flutter-blue.svg?longCache=true&style=flat-square"></a>
  <a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

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
  kinfolk: ^0.0.3
```
then run.  packages get

### Example 

```dart

/// initialize service
Kinfolk kinfolk = Kinfolk();

/// setting server url and security keys (identifier,secter)
kinfolk.initializeBaseVariables("http://localhost:8080/test", "client", "secret");

/// getting client (service with Access Token) in first time with login,password
oauth2.Client client = await kinfolk.getToken("admin", "admin");

///  url to service 
///  test_SomeService  -  service name 
///  getToDoList - method name
///  Types - enum
String url =
    Kinfolk.createRestUrl("test_SomeService", "getToDoList", Types.services);

// getting response from server. GET method
var response = await client.get(url, headers: Kinfolk.appJsonHeader);

/// printing body of response
print("${response.body}");

///  url to service 
String url2 =
    Kinfolk.createRestUrl("test_SomeService", "setToDoList", Types.services);

///  request body 
String body = """
    {
    "monday":"work",
     "sunday":"relax"
    }
""";

/// getting client from saved Access Token
oauth2.Client client2 = await Kinfolk.getClient();

// getting response from server. POST method
var response2 =
    await client2.post(url, body: body, headers: Kinfolk.appJsonHeader);

/// printing body of response
print("1       ${response2.body}");

```


# Author
[Yerassyl Maikhanov](https://yeras-is.github.io/) - Enterprise Applications Developer. [My Linkedin](https://www.linkedin.com/in/yerassyl-maikhanov-52558b185/)

