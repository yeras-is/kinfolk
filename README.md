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
  kinfolk: ^0.0.4
```
then run.  packages get

### Example 

```dart

/// initialize service
Kinfolk kinfolk = Kinfolk();

/// setting server url and security keys (identifier,secter)
kinfolk.initializeBaseVariables("http://localhost:8080/test", "client", "secret", Directory.current.path);

/// getting client (service with Access Token) in first time with login,password
oauth2.Client client = await kinfolk.getToken("admin", "admin");

///  getting single model
///  test_SomeService  -  service name 
///  getToDoList - method name
///  Types - enum
/// formMap - function converting Map<String, dynamic> map to your Model
ToDoList model =
    Kinfolk.getSingleModelRest(
      serviceName: "test_SomeService", 
      methodName: "getToDoList", 
      type: Types.services, 
      fromMap: (Map<String, dynamic> val)=> ToDoList.fromMap(val));

String body = """
    {
    "monday":"work",
     "sunday":"relax"
    }
""";

///  getting single model with request body
///  test_SomeService  -  service name 
///  getToDoList - method name
///  Types - enum
///  body - request body
/// formMap - function converting Map<String, dynamic> map to your Model
ToDoList model =
    Kinfolk.getSingleModelRest(
      serviceName: "test_SomeService", 
      methodName: "getToDoList", 
      type: Types.services, 
      body: body,
      fromMap: (Map<String, dynamic> val)=> ToDoList.fromMap(val));

///  getting models list
///  test_SomeService  -  service name 
///  getToDoList - method name
///  Types - enum
/// formMap - function converting Map<String, dynamic> map to your Model
List<dynamic> modelsList =
    Kinfolk.getListModelRest(
      serviceName: "test_SomeService", 
      methodName: "getToDoList", 
      type: Types.services, 
      fromMap: (Map<String, dynamic> val)=> ToDoList.fromMap(val));

///  getting models list with request body
///  test_SomeService  -  service name 
///  getToDoList - method name
///  Types - enum
///  body - request body
/// formMap - function converting Map<String, dynamic> map to your Model
List<dynamic> modelsList =
    Kinfolk.getListModelRest(
      serviceName: "test_SomeService", 
      methodName: "getToDoList", 
      type: Types.services, 
      body: body,
      fromMap: (Map<String, dynamic> val)=> ToDoList.fromMap(val));


/// Manual rest service usage. only if you want full control

///  url to service 
String url =
    Kinfolk.createRestUrl("test_SomeService", "setToDoList", Types.services);

///  request body 
String body = """
    {
    "monday":"work",
     "sunday":"relax"
    }
""";

/// getting client from saved Access Token
oauth2.Client client = await Kinfolk.getClient();

// getting response from server. POST method
var response =
    await client.post(url, body: body, headers: Kinfolk.appJsonHeader);

/// printing body of response
print("${response.body}");

```


# Author
[Yerassyl Maikhanov](https://yeras-is.github.io/) - Enterprise Applications Developer. [My Linkedin](https://www.linkedin.com/in/yerassyl-maikhanov-52558b185/)

