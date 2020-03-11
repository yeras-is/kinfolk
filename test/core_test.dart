import 'file:///C:/Users/maiha/AndroidStudioProjects/core/lib/service/exceptions.dart';
import 'package:core/global_variables.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:core/core.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Kinfolk();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });

  test("Global Variables", () {
    final calculator = Kinfolk();
    calculator.initializeBaseVariables(
        "http://localhost:8080/test/", "client", "secret");
    expect(GlobalVariables.secret, "secret");
    expect(GlobalVariables.identifier, "client");
    expect(GlobalVariables.urlEndPoint, "http://localhost:8080/test/");

    calculator.initializeBaseVariables(null, null, null);
    expect(() => GlobalVariables.secret,
        throwsA(predicate((e) => e is NullOrEmptyArgument)));
    expect(() => GlobalVariables.identifier,
        throwsA(predicate((e) => e is NullOrEmptyArgument)));
    expect(() => GlobalVariables.urlEndPoint,
        throwsA(predicate((e) => e is NullOrEmptyArgument)));
  });

  test("Acess Token", () {
    final calculator = Kinfolk();
    calculator.initializeBaseVariables(
        "http://localhost:8080/test/", "client", "secret");
    expect(GlobalVariables.secret, "secret");
    expect(GlobalVariables.identifier, "client");
    expect(GlobalVariables.urlEndPoint, "http://localhost:8080/test/");
    expect(calculator.getToken("admin", "admin"), isNotNull);
  });

  test("File Url", () {
    final calculator = Kinfolk();
    calculator.initializeBaseVariables(
        "http://localhost:8080/test/", "client", "secret");
    expect(calculator.getToken("admin", "admin"), isNotNull);

    expect(calculator.getFileUrl("123"),
        "http://localhost:8080/test/rest/v2/files/123");
  });
}
