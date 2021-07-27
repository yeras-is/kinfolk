import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:kinfolk/model/cuba_entity_filter.dart';
import 'package:kinfolk/model/url_types.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _future;

  // add to DI, here is just quick example
  late Kinfolk _kinfolk;

  void initState() {
    _kinfolk = Kinfolk();
    _future = _setUpKinfolk();
    super.initState();
  }

  Future<bool> _setUpKinfolk() async {
    _kinfolk.initializeBaseVariables(
      // http://localhost:8080/app
      'http://localhost:8080/app',
      // typically 'client'
      'identifier',
      // secret from CUBA app properties
      'secret',
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _future,
      builder: (context, snapshot) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          kinfolk: _kinfolk,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.kinfolk})
      : super(key: key);

  final String title;
  final Kinfolk kinfolk;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Map>> _future;

  @override
  void initState() {
    _future = loadDataList();

    super.initState();
  }

  Future<List<Map>> loadDataList() async {
    /// if error return type is String, if succes return type is Client
    await widget.kinfolk.getToken('admin', 'admin');

    /// getting list of Users
    final listData = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'sec\$User',
      methodName: 'search',

      /// type of query
      type: Types.entities,

      /// from Map to Object
      fromMap: (e) => e,

      /// filter for entities filter, accord to swagger entity filter
      filter: CubaEntityFilter(
        filter: Filter(conditions: []),
        view: '_local',
      ),
    );
    return listData.cast<Map>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Map>>(
        future: _future,
        builder: (ctx, snapshot) => !snapshot.hasData
            ? const Center(child: CupertinoActivityIndicator())
            : ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = (snapshot.data ?? [])[index];
                  return ListTile(
                    title: Text(item['id'] ?? ''),
                    subtitle: Text(item['login'] ?? ''),
                  );
                },
              ),
      ),
    );
  }
}
