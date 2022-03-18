import 'package:flutter/material.dart';
import 'package:hive_1/model/ogrenci.dart';
import 'package:hive_flutter/hive_flutter.dart';

//flutter packages pub run build_runner build
Future<void> main() async {
  await Hive.initFlutter("uygulama");
  await Hive.openBox("test");
  await Hive.openBox<Ogrenci>("ogrenciler");
  Hive.registerAdapter(OgrenciAdapter());
  Hive.registerAdapter(GozRenkAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var box = Hive.box("test");
    await box.clear();
    box.add("emre"); //index 0  key:1 value:emre
    box.add("altunbilek"); //index 1
    await box.addAll(["liste1", "liste12", "false"]);

    await box.put("tc", "23754656"); //put da key value ilişkisi var add de yok
    await box.put("tc", "23754656");
    await box.putAll({"araba": "mercedes", "model": "c180"});

    // box.values.forEach((element) {
    //   debugPrint(element.toString());
    // });
    debugPrint(box.toMap().toString());
    debugPrint(box.get(1)); //key ile
    debugPrint(box.getAt(1)); // index ile erişim
    debugPrint(box.length.toString());
    await box.delete("tc");
  }

  Future<void> _customData() async {
    var emre = Ogrenci(5, "emre", GozRenk.MAVI);
    var yavuz = Ogrenci(2, "yavuz", GozRenk.YESIL);

    var box = Hive.box<Ogrenci>("ogrenciler");
    await box.clear();
    box.add(emre);

    box.add(yavuz);

    debugPrint(box.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _customData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
