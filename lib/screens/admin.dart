import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Admin extends StatefulWidget {
  Admin({required Key key}) : super(key: key);

  @override
  AdminState createState() => AdminState();
}

class AdminState extends State<Admin> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EG Health Center'),
        backgroundColor: Colors.blue,
      ),
      body: WebView(
        key: UniqueKey(),
        initialUrl:
            'http://medical.toweroflove.org/Admin/ohcms_admin_login.php',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
