import 'package:flutter/material.dart';
import 'package:eg_health_center/screens/admin.dart';
// import 'package:eg_health_center/screens/consultation.dart';
import 'package:eg_health_center/screens/departmentHead.dart';
import 'package:eg_health_center/screens/laboratory.dart';
import 'package:eg_health_center/screens/pharmacy.dart';
import 'package:eg_health_center/screens/patientRegistration.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<Widget> _cardsToDisplay = <Widget>[
    // Card(
    //   key: UniqueKey(),
    //   child: Column(
    //     children: const <Widget>[
    //       Image(
    //         image: AssetImage('./assets/images/consultation.png'),
    //         height: 150,
    //         width: 150,
    //       ),
    //       Text('Consultation'),
    //     ],
    //   ),
    //   // color: Colors.black45,
    // ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('./assets/images/patient_register.png'),
            height: 150,
            width: 150,
          ),
          Text('Patient Registration'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('./assets/images/lab.png'),
            height: 150,
            width: 150,
          ),
          Text('Laboratory'),
        ],
      ),
    ),

    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('./assets/images/pharmacy.png'),
            height: 150,
            width: 150,
          ),
          Text('Pharmacy'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('./assets/images/dept_head.png'),
            height: 150,
            width: 150,
          ),
          Text('Department Head'),
        ],
      ),
    ),
    Card(
      key: UniqueKey(),
      child: Column(
        children: const <Widget>[
          Image(
            image: AssetImage('./assets/images/admin.png'),
            height: 150,
            width: 150,
          ),
          Text('Admin'),
        ],
      ),
    ),
  ];
  final List<Widget> _classViews = <Widget>[
    // Consultation(
    //   key: UniqueKey(),
    // ),
    PatientRegistration(
      key: UniqueKey(),
    ),
    Laboratory(
      key: UniqueKey(),
    ),
    Pharmacy(
      key: UniqueKey(),
    ),
    DepartmentHead(
      key: UniqueKey(),
    ),
    Admin(
      key: UniqueKey(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Image(
                  image: AssetImage('./assets/images/tower_of_love.png'),
                  height: 180,
                  width: 150,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    ' Welcome, Select option ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Expanded(
                SizedBox(
                  height: 600,
                  child: GridView.count(
                    shrinkWrap: true,
                    primary: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(_cardsToDisplay.length, (index) {
                      return InkWell(
                        child: _cardsToDisplay[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => _classViews[index]),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
