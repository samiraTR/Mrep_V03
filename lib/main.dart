import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mrap7/Pages/splash_screen.dart';
import 'package:mrap7/service/hive_adapter.dart';
import 'package:mrap7/themes.dart';
import 'package:path_provider/path_provider.dart';

// String location = "";
// String address = "";
var SameDeviceId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
    // Hive.init(dir.path);
  await Hive.initFlutter(dir.path);

  await HiveAdapter().HiveAdapterbox();
  await Hive.openBox("draftForExpense");
  await Hive.openBox('alldata');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // getAddress() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mRep7',
      theme: defaultTheme,
      home: SplashScreen(),
    );
  }
}
