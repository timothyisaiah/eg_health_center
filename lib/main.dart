import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:eg_health_center/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EG Health Center',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EG Health Center'),
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
  int _selectedIndex = 0;
  ReceivePort _port = ReceivePort();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    WebView(
      key: UniqueKey(),
      initialUrl:
          'http://medical.toweroflove.org/RegistrationDesk/employee_login.php',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl:
          'http://medical.toweroflove.org/Laboratory/employee_login.php',
      javascriptMode: JavascriptMode.unrestricted,
    ),
    WebView(
      key: UniqueKey(),
      initialUrl: 'http://medical.toweroflove.org/Pharmacy/employee_login.php',
      javascriptMode: JavascriptMode.unrestricted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _urlStartup().then((value) {
            print('Async done');
          });
        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.live_tv_outlined),
        label: const Text('Live Consultation'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Patient',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.biotech),
            label: 'Laboratory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Pharmacy',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: (_selectedIndex == 0)
          ? HomeScreen()
          : _pages[
              _selectedIndex], //This displays the webviews based on the selected index
    );
  }

  _urlStartup() async {
    String url = "http://www.egmc.toweroflove.org/";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not launch $url');
    }
  }
}
