import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrap7/Pages/homePage.dart';
import 'package:mrap7/Pages/loginPage.dart';
import 'package:mrap7/Pages/syncDataTabPaga.dart';
import 'package:mrap7/local_storage/boxes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String cid = '';
  String userId = '';
  String userPassword = '';
  bool? areaPage;
  String? user_id;
  String? userName;
  List itemToken = [];
  List clientToken = [];
  List dcrtToken = [];
  List gifttToken = [];

  // double latitude=0.0;
  // double longitude=0.0;
  final myallData=Boxes.allData();

  @override
  void initState() {
    super.initState();
    // getLatLong(); 

    Hive.openBox('data').then(
      (value) {
        // var mymap = value.toMap().values.toList();
        clientToken = value.toMap().values.toList();

        setState(() {});

        // SharedPreferences.getInstance().then(
        //   (prefs) {
            cid = myallData.get("CID") ?? '';
            userId = myallData.get("USER_ID") ?? '';
            userPassword = myallData.get("PASSWORD") ?? '';
            // areaPage = myallData.get("areaPage");
            userName = myallData.get("userName");
            user_id = myallData.get("user_id");
            // print(areaPage);

            if (cid != '' && userId != '' && userPassword != '') {
              // print(clientToken);
              if (clientToken.isNotEmpty) {
                Timer(
                  const Duration(seconds: 4),
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyHomePage(
                        userName: userName.toString(),
                        user_id: userId,
                        userPassword: userPassword,
                      ),
                    ),
                  ),
                );
              } else {
                Timer(
                  const Duration(seconds: 4),
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SyncDataTabScreen(
                        cid: cid,
                        userId: userId,
                        userPassword: userPassword,
                      ),
                    ),
                  ),
                );
              }
            } else {
              Timer(
                const Duration(seconds: 4),
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                ),
              );
            }
        //   },
        // );
      },
    );
  }

 

  // getLatLong() {
  //   Future<Position> data =AllServices().determinePosition();
  //   data.then((value) {
  //     // print("value $value");
  //     setState(() {
  //       latitude = value.latitude;
  //       longitude = value.longitude;

    
  //         myallData.put("latitude", latitude);
  //         myallData.put("longitude", longitude);
       
  //     });
  //   }).catchError((error) {
  //     // print("Error $error");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/mRep7_wLogo.png",
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
