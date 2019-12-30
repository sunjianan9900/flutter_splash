import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fontPath;
  bool _fontDownloaded = false;
  String _fontStyle;

  @override
  void initState() {
    checkFont();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Font test'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Font Style Test',
              style: TextStyle(fontFamily: _fontStyle, fontSize: 20.0),
            ),
            Icon(
              FontAwesomeIcons.crown,
              size: 30.0,
            ),
            _fontDownloaded
                ? Text("Download finish")
                : Text("Not Download yet"),
            RaisedButton(
              onPressed: () async {
                download();
              },
              child: Text('1. Download Font'),
            ),
            RaisedButton(
              onPressed: () async {
                await readFont(
                    _fontPath + '/RichieBrusher.ttf', 'RichieBrusher');
                setState(() {
                  _fontStyle = 'RichieBrusher';
                });
              },
              child: Text('2. Use font'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> download() async {
    // Download font
    ProgressCallback onDownloadProgress = (int received, int total) async {
      print('DOWN$received');
      print('DOWN$total');
      double progress = received / total;
      if (progress == 1) {
        print('Download finish');
        setState(() {
          _fontDownloaded = true;
        });
      } else {
        print('Downloading');
      }
    };
    Dio dio = new Dio();

    await dio.download("http://pics.xiaomilu.top/RichieBrusher.ttf",
        _fontPath + '/RichieBrusher.ttf',
        onReceiveProgress: onDownloadProgress);
  }

  Future<bool> isDirectoryExist(String path) async {
    File file = File(path);
    return await file.exists();
  }

  Future<void> createDirectory(String path) async {
    Directory directory = Directory(path);
    directory.create();
  }

  Future<void> readFont(String path, String name) async {
    var fontLoader = FontLoader(name); //自定义名字
    fontLoader.addFont(getCustomFont(path));
    await fontLoader.load();
  }

  Future<ByteData> getCustomFont(String path) async {
    ByteData byteData = await rootBundle.load(path);
    return byteData;
  }

  Future<void> checkFont() async {
    _fontPath = (await getApplicationDocumentsDirectory()).path + "/font";
    bool exist = await isDirectoryExist(_fontPath); //判定目录是否存在 - 不存在就创建
    if (!exist) {
      await createDirectory(_fontPath);
    }

    _fontDownloaded = await isDirectoryExist(_fontPath + '/RichieBrusher.ttf');
    setState(() {});
  }
}
