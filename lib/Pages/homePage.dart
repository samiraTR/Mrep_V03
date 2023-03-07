import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/screens.dart';


double lat = 0.0;
double long = 0.0;

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  String userName;
  String user_id;
  String userPassword;
  // bool offer_flag;
  // bool note_flag;
  // bool client_edit_flag;
  // bool os_show_flag;
  // bool os_details_flag;
  // bool ord_history_flag;
  // bool inv_histroy_flag;
  // bool rx_doc_must;
  // bool rx_type_must;
  // bool rx_gallery_allow;
  // String endTime;

  MyHomePage({
    Key? key,
    // required this.startTime,
    required this.userPassword,
    required this.userName,
    required this.user_id,
    // required this.offer_flag,
    // required this.note_flag,
    // required this.client_edit_flag,
    // required this.os_show_flag,
    // required this.os_details_flag,
    // required this.ord_history_flag,
    // required this.inv_histroy_flag,
    // required this.rx_doc_must,
    // required this.rx_type_must,
    // required this.rx_gallery_allow,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Box? box;

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List data = [];
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  String report_sales_url = '';
  String report_dcr_url = '';
  String report_rx_url = '';
  String leave_request_url = '';
  String leave_report_url = '';
  String plugin_url = '';
  String tour_plan_url = '';
  String tour_compliance_url = '';
  String activity_log_url = '';
  String cid = '';
  String userId = '';
  String userPassword = '';
  bool areaPage = false;
  String? userName;
  String? startTime;
  String user_sales_coll_ach_url = '';
  String timer_track_url = '';
  String? user_id;
  String deviceId = "";
  String mobile_no = '';
  String? endTime;
  bool orderFlag = false;
  bool dcrFlag = false;
  bool rxFlag = false;
  bool leaveFlag = false;
  bool othersFlag = false;
  bool visitPlanFlag = false;
  bool pluginFlag = false;
  bool leave_flag = false;
  bool notice_flag = false;
  bool timer_flag = false;
  String version = 'test';
  var prefix;
  var prefix2;
  // Location location = Location();
  final mydatabox=Boxes.allData();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // SharedPreferences.getInstance().then((prefs) {
        setState(() {
          userPassword = mydatabox.get("PASSWORD") ?? widget.userPassword;
          startTime = mydatabox.get("startTime") ?? '';
          endTime = mydatabox.get("endTime") ?? '';
          report_sales_url = mydatabox.get("report_sales_url") ?? '';
          report_dcr_url = mydatabox.get("report_dcr_url") ?? '';
          report_rx_url = mydatabox.get("report_rx_url") ?? '';
          leave_request_url = mydatabox.get("leave_request_url") ?? '';
          leave_report_url = mydatabox.get("leave_report_url") ?? '';
          tour_plan_url = mydatabox.get("tour_plan_url") ?? '';
          tour_compliance_url = mydatabox.get("tour_compliance_url") ?? '';
          activity_log_url = mydatabox.get("activity_log_url") ?? '';
          plugin_url = mydatabox.get("plugin_url") ?? '';
          user_sales_coll_ach_url =
              mydatabox.get("user_sales_coll_ach_url") ?? '';
          timer_track_url = mydatabox.get("timer_track_url") ?? '';

          cid = mydatabox.get("CID");
          userId = mydatabox.get("USER_ID") ?? widget.user_id;
          areaPage = mydatabox.get("areaPage")!;
          userName = mydatabox.get("userName");
          user_id = mydatabox.get("user_id");
          mobile_no = mydatabox.get("mobile_no") ?? '';
          deviceId = mydatabox.get("deviceId") ?? '';
          orderFlag = mydatabox.get('order_flag') ?? false;
          dcrFlag = mydatabox.get('dcr_flag') ?? false;
          rxFlag = mydatabox.get('rx_flag') ?? false;
          othersFlag = mydatabox.get('others_flag') ?? false;
          visitPlanFlag = mydatabox.get('visit_plan_flag') ?? false;
          pluginFlag = mydatabox.get('plagin_flag') ?? false;
          leave_flag = mydatabox.get('leave_flag') ?? false;
          notice_flag = mydatabox.get('notice_flag') ?? false;
          timer_flag = mydatabox.get('timer_flag') ?? false;

          print('timer flag ::::$timer_flag');

          var parts = startTime?.split(' ');

          prefix = parts![0].trim();
          // print("prefix ashbe $prefix");
          String dt = DateTime.now().toString();
          var parts2 = dt.split(' ');
          prefix2 = parts2[0].trim();
          // print("dateTime ashbe$prefix2");
        });

        setState(() {
          int space = startTime!.indexOf(" ");
          String removeSpace =
              startTime!.substring(space + 1, startTime!.length);
          startTime = removeSpace.replaceAll("'", '');
          int space1 = endTime!.indexOf(" ");
          String removeSpace1 = endTime!.substring(space1 + 1, endTime!.length);
          endTime = removeSpace1.replaceAll("'", '');


          //todo 
           if (SameDeviceId == false) {
        print(SameDeviceId);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        setState(() {});
      }
      // if (timer_flag == true) {
      //   getPermission();
      // }else{
      //   getPermission();
      //   print("i get this function");
      // }
        });
      });
     
    // }
    
    // );

    print(report_sales_url);
    print(report_dcr_url);
    print(report_rx_url);
  }

  // getPermission() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   if (_serviceEnabled &&
  //       _permissionGranted == PermissionStatus.granted &&
  //       timer_flag == true) {
  //     //await initializeService();

  //     BGservice.serviceOn();
  //     print('Starting Background Service...');

  //     print('Starting Background Service...');
  //   }

  //   setState(() {});
  // }

  // getLoc() {
  //   String location = "";
  //   Timer.periodic(const Duration(minutes: 3), (timer) {
  //     getLatLong();
  //     if (lat != 0.0 && long != 0.0) {
  //       if (location == "") {
  //         location = lat.toString() + "|" + long.toString();
  //       } else {
  //         location = location + "||" + lat.toString() + "|" + long.toString();
  //       }
  //     }

  //     print(location.split('||').length);
  //     // print(location.length);
  //   });
  // }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // getLatLong() {
  //   Future<Position> data = _determinePosition();
  //   data.then((value) {
  //     setState(() {
  //       lat = value.latitude;
  //       long = value.longitude;
  //     });
  //     getAddress(value.latitude, value.longitude);
  //   }).catchError((error) {});
  // }

  // getAddress(lat, long) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  //   setState(() {
  //     address = placemarks[0].street! + " " + placemarks[0].country!;
  //   });
  //   // for (int i = 0; i < placemarks.length; i++) {}
  // }

  int _currentSelected = 0;
  _onItemTapped(int index) async {
    if (index == 1) {
      cid == 'NOVO'
          ? Text("")
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RxPage(
                        address: '',
                        areaId: '',
                        areaName: '',
                        ck: '',
                        dcrKey: 0,
                        docId: '',
                        docName: '',
                        uniqueId: 0,
                        draftRxMedicinItem: [],
                        image1: '',
                      )));
      setState(() {
        _currentSelected = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _drawerKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 138, 201, 149)),
              child: Image.asset('assets/images/mRep7_logo.png'),
            ),
            ListTile(
              leading:
                  const Icon(Icons.sync_outlined, color: Colors.blueAccent),
              title: const Text(
                'Sync Data',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 15, 53, 85)),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SyncDataTabScreen(
                              cid: cid,
                              userId: userId,
                              userPassword: userPassword,
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.fact_check_outlined,
                  color: Colors.blueAccent),
              title: const Text(
                'Achievement',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 15, 53, 85)),
              ),
              onTap: () {
                getTarAch(context, user_sales_coll_ach_url, cid, userId,
                    userPassword, deviceId);
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.vpn_key, color: Colors.blueAccent),
              title: const Text(
                'Change password',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 15, 53, 85)),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ResetPasswordScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.blueAccent),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 15, 53, 85)),
              ),
              onTap: () async {
                // final prefs = await SharedPreferences.getInstance();

                await mydatabox.put('PASSWORD', ''); 
                // if (await FlutterBackgroundService().isRunning()) {
                //   FlutterBackgroundService().invoke("stopService");
                // }
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 138, 201, 149),
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     // LinearGradient
        //     gradient: LinearGradient(
        //       // colors for gradient
        //       colors: [
        //         Color(0xff70BA85),
        //         Color(0xff56CCF2),
        //       ],
        //     ),
        //   ),
        // ),
        // title: Text('MREPORTING v' + "20230211"),
        title: Text('PROTTOY100 v' + "20230211"),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 27, 56, 34),
            fontWeight: FontWeight.w500,
            fontSize: 20),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: rxFlag == true
          ? BottomNavigationBar(
              // type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
              currentIndex: _currentSelected,
              // showUnselectedLabels: true,
              unselectedItemColor: Colors.grey[800],
              selectedItemColor: const Color.fromRGBO(10, 135, 255, 1),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                // rxFlag == false
                //     ?
                BottomNavigationBarItem(
                  label: 'Camera',
                  icon: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.black87,
                  ),
                )
                // : const BottomNavigationBarItem(
                //     label: '',
                //     icon: Icon(
                //       Icons.photo_camera_outlined,
                //       color: Colors.white,
                //     ),
                //   )
              ],
            )
          : Text(""),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ///*****************************************************  User information Section***********************************************///

                Container(
                  height: screenHeight / 9.3,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 222, 237, 250),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    widget.userName,

                                    // ' $userName',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 15, 53, 85),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                FittedBox(
                                    child: cid == "NOVO"
                                        ? Text(
                                            'Initial: ' +
                                                widget.user_id.toUpperCase() +
                                                '\n' +
                                                mobile_no,
                                            // ' $userName',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 15, 53, 85),
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          )
                                        : Text(
                                            'ID: ' +
                                                widget.user_id +
                                                '\n' +
                                                mobile_no,
                                            // ' $userName',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 15, 53, 85),
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          )),
                              ],
                            )),
                      ),
                      cid != "NOVO"
                          ? Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AttendanceScreen()));
                                      }),
                                      child: FittedBox(
                                        child: prefix != prefix2
                                            ? Text(
                                                '[Attendance]' +
                                                    '\n' +
                                                    'Start: ' +
                                                    " " +
                                                    '\n' +
                                                    "End: " +
                                                    " ",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 15, 53, 85),
                                                  fontSize: 18,
                                                ),
                                              )
                                            : Text(
                                                '[Attendance]' +
                                                    '\n' +
                                                    'Start: ' +
                                                    startTime.toString() +
                                                    '\n' +
                                                    "End: " +
                                                    endTime.toString(),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 15, 53, 85),
                                                  fontSize: 18,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                ///************************************************ Order area Field *********************************************///

                orderFlag
                    ? Container(
                        color: const Color(0xFFE2EFDA),
                        height: screenHeight / 3.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 50,
                                        width: 50,
                                        icon: "assets/icons/neworder.png",
                                        onClick: () {
                                          if (areaPage == false) {
                                            getAllCustomarData();
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const AreaPage()),
                                            );
                                          }

                                          //  print(areaPage);
                                        },
                                        title: 'New Order',
                                        sizeWidth: screenWidth,
                                        inputColor: const Color(0xff70BA85)
                                            .withOpacity(.3),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 50,
                                        width: 50,
                                        icon: "assets/icons/draft.png",
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const DraftOrderPage(),
                                            ),
                                          );
                                        },
                                        title: 'Draft Order',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 45,
                                        width: 45,
                                        icon: "assets/icons/documents.png",
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderReportWebViewScreen(
                                                report_url: report_sales_url,
                                                cid: cid,
                                                userId: userId,
                                                userPassword: userPassword,
                                              ),
                                            ),
                                          );
                                        },
                                        title: 'Report',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                orderFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///******************************************** DCR Section ********************************************///

                dcrFlag
                    ? Container(
                        height: screenHeight / 3.5,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFFDDEBF7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        icon: "assets/icons/advice.png",
                                        onClick: () {
                                          SyncDcrtoHive().getData(context);
                                        },
                                        title: 'New DCR',
                                        sizeWidth: screenWidth,
                                        inputColor: const Color(0xff56CCF2)
                                            .withOpacity(.3),
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 40,
                                        width: 40,
                                        icon: "assets/icons/first-aid-kit.png",
                                        onClick: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DraftDCRScreen()));
                                        },
                                        title: 'Draft DCR',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 50,
                                        width: 50,
                                        icon: "assets/icons/dcrReport.png",
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DcrReportWebView(
                                                report_url: report_dcr_url,
                                                cid: cid,
                                                userId: userId,
                                                userPassword: userPassword,
                                                deviceId: deviceId,
                                              ),
                                            ),
                                          );
                                        },
                                        title: 'DCR Report',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                dcrFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///********************************************* New Rx section **************************************///

                rxFlag
                    ? Container(
                        color: const Color(0xFFE2EFDA),
                        height: screenHeight / 3.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 42,
                                        width: 42,
                                        icon: "assets/icons/prescriptionRx.png",
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RxPage(
                                                address: '',
                                                areaId: '',
                                                areaName: '',
                                                ck: '',
                                                dcrKey: 0,
                                                docId: '',
                                                docName: '',
                                                uniqueId: 0,
                                                draftRxMedicinItem: [],
                                                image1: '',
                                              ),
                                            ),
                                          );
                                        },
                                        title: 'RX Capture',
                                        sizeWidth: screenWidth,
                                        inputColor: const Color(0xff70BA85)
                                            .withOpacity(.3),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 39,
                                        width: 39,
                                        icon: "assets/icons/folderRx.png",
                                        onClick: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const RxDraftPage()));
                                        },
                                        title: 'Draft RX',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: customBuildIconButton(
                                        height: 42,
                                        width: 42,
                                        icon: "assets/icons/rxreport.png",
                                        onClick: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  RxReportPageWebView(
                                                cid: cid,
                                                userId: userId,
                                                userPassword: userPassword,
                                                report_url: report_rx_url,
                                              ),
                                            ),
                                          );
                                        },
                                        title: 'RX Report',
                                        sizeWidth: screenWidth,
                                        inputColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                rxFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///*******************************************Expense and Attendance  section ***********************************///
                othersFlag
                    ? Container(
                        color: const Color(0xFFE2EFDA),
                        height: screenHeight / 6.9,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: customBuildButton(
                                    onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AttendanceScreen()));
                                    },
                                    icon: Icons.assignment_turned_in_sharp,
                                    title: 'Attendance',
                                    sizeWidth: screenWidth,
                                    inputColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: customBuildButton(
                                    icon: Icons.add,
                                    onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExpensePage()));
                                    },
                                    title: 'Expense',
                                    sizeWidth: screenWidth,
                                    inputColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                othersFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///******************************************* Leave Request and Leave Report **********************************///
                leave_flag
                    ? Container(
                        color: const Color(0xFFE2EFDA),
                        height: screenHeight / 6.9,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Link(
                                    uri: Uri.parse(
                                        '$leave_request_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                    target: LinkTarget.blank,
                                    builder: (BuildContext ctx,
                                        FollowLink? openLink) {
                                      // print(
                                      //     "$leave_request_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword");
                                      return Card(
                                        elevation: 5,
                                        child: Container(
                                          color: Colors.white,
                                          width: screenWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                'Leave Request',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 29, 67, 78),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              icon: const Icon(
                                                Icons
                                                    .leave_bags_at_home_rounded,
                                                color: Color.fromARGB(
                                                    255, 27, 56, 34),
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Link(
                                    uri: Uri.parse(
                                        '$leave_report_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                    target: LinkTarget.blank,
                                    builder: (BuildContext ctx,
                                        FollowLink? openLink) {
                                      return Card(
                                        elevation: 5,
                                        child: Container(
                                          color: Colors.white,
                                          width: screenWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextButton.icon(
                                              onPressed: openLink,
                                              label: const Text(
                                                'Leave Report',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 29, 67, 78),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              icon: const Icon(
                                                Icons.insert_drive_file,
                                                color: Color.fromARGB(
                                                    255, 27, 56, 34),
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                othersFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///******************************************  Tour Plan *********************************************///
                visitPlanFlag
                    ? Container(
                        color: const Color(0xFFDDEBF7),
                        height: screenHeight / 7,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Link(
                                        uri: Uri.parse(
                                            '$tour_plan_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                        target: LinkTarget.blank,
                                        builder: (BuildContext ctx,
                                            FollowLink? openLink) {
                                          // print(
                                          //     '$tour_plan_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword');
                                          return Card(
                                            elevation: 5,
                                            child: Container(
                                              color: const Color.fromARGB(
                                                  255, 217, 224, 250),
                                              width: screenWidth,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextButton.icon(
                                                  onPressed: openLink,
                                                  label: const Text(
                                                    'Tour Plan',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 67, 78),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.tour_sharp,
                                                    color: Color.fromARGB(
                                                        255, 27, 56, 34),
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Link(
                                        uri: Uri.parse(
                                            '$tour_compliance_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                        target: LinkTarget.blank,
                                        builder: (BuildContext ctx,
                                            FollowLink? openLink) {
                                          // print(
                                          //     '$tour_compliance_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword');
                                          return Card(
                                            elevation: 5,
                                            child: Container(
                                              color: const Color.fromARGB(
                                                  255, 217, 224, 250),
                                              width: screenWidth,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextButton.icon(
                                                  onPressed: openLink,
                                                  label: const Text(
                                                    'Approval & Compliance',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 67, 78),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.tour_outlined,
                                                    color: Color.fromARGB(
                                                        255, 27, 56, 34),
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                visitPlanFlag
                    ? const SizedBox(
                        height: 5,
                      )
                    : const SizedBox.shrink(),

                ///***********************************  Plugg-in & Reports *************************************************///
                pluginFlag
                    ? Container(
                        color: const Color(0xFFDDEBF7),
                        height: screenHeight / 7,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Link(
                                        uri: Uri.parse(
                                            '$plugin_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                        target: LinkTarget.blank,
                                        builder: (BuildContext ctx,
                                            FollowLink? openLink) {
                                          // print(
                                          //     '$plugin_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword');
                                          return Card(
                                            elevation: 5,
                                            child: Container(
                                              color: Colors.white,
                                              width: screenWidth,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextButton.icon(
                                                  onPressed: openLink,
                                                  label: const Text(
                                                    'Plugg-in & Reports',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 67, 78),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.insert_drive_file,
                                                    color: Color.fromARGB(
                                                        255, 27, 56, 34),
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Link(
                                        uri: Uri.parse(
                                            '$activity_log_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                                        target: LinkTarget.blank,
                                        builder: (BuildContext ctx,
                                            FollowLink? openLink) {
                                          // print(
                                          //     '$activity_log_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword');
                                          return Card(
                                            elevation: 5,
                                            child: Container(
                                              color: Colors.white,
                                              width: screenWidth,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextButton.icon(
                                                  onPressed: openLink,
                                                  label: const Text(
                                                    'Activity Log',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 67, 78),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  icon: const Icon(
                                                    Icons
                                                        .local_activity_rounded,
                                                    color: Color.fromARGB(
                                                        255, 27, 56, 34),
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                pluginFlag
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox.shrink(),

                ///****************************************** Sync Data************************************************///
                Container(
                  color: const Color(0xFFE2EFDA),
                  height: screenHeight / 7,
                  width: screenWidth,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //==========================================================Notice flag +Notice url will be here====================================
                          notice_flag
                              ? Expanded(
                                  child: customBuildButton(
                                    icon: Icons.note_alt,
                                    onClick: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => NoticeScreen()));
                                    },
                                    title: 'Notice',
                                    sizeWidth: screenWidth,
                                    inputColor: Colors.white,
                                  ),
                                )
                              : const SizedBox(
                                  width: 5,
                                ),

                          Expanded(
                            child: customBuildButton(
                              icon: Icons.sync,
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SyncDataTabScreen(
                                              cid: cid,
                                              userId: userId,
                                              userPassword: userPassword,
                                            )));
                              },
                              title: 'Sync Data',
                              sizeWidth: screenWidth,
                              inputColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future openBox() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box = await Hive.openBox('data');
  // }

  getAllCustomarData() async {
    // await openBox();
    final box = Hive.box('data');
    var mymap = box.toMap().values.toList();

    if (mymap.isEmpty) {
      data.add('empty');
    } else {
      data = mymap;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CustomerListScreen(
                    data: data,
                  )));
    }
  }

  // // Draft Item order section.......................

  // Future orderOpenBox() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box = await Hive.openBox('DraftOrderList');
  // }
  // Future timetrack() async {
  //   final response = await http.post(
  //     Uri.parse("$timer_track_url"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "cid": cid,
  //       "user_id": userId,
  //       "user_pass": widget.userPassword,
  //       'device_id': deviceId!,

  //       // "locations": Location,

  //     }),
  //   );
  //   Map<String, dynamic> data = json.decode(response.body);
  //   // status = data['status'];
  //   final startTime = data['start_time'];
  //   final endTime = data['end_time'];
  //   final prefs = await SharedPreferences.getInstance();

  //   // if (status == "Success") {
  //   //   await prefs.setString('startTime', startTime);
  //   //   await prefs.setString('endTime', endTime);
  //   //   print('hello');

  //   //   Navigator.pushReplacement(
  //   //       context,
  //   //       MaterialPageRoute(
  //   //           builder: (context) => MyHomePage(
  //   //                 userName: userName,
  //   //                 user_id: user_id,
  //   //                 userPassword: userPass!,
  //   //               )));

  //   //   Fluttertoast.showToast(msg: "Attendance $submitType Successfully");
  //   // } else {
  //   //   return "Failed";
  //   // }
  //   return "Null";
  // }
}

/*class BGservice {
  static Future<void> serviceOn() async {
    await initializeService();
  }
}*/

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//         // this will executed when app is in foreground or background in separated isolate
//         onStart: onStart,

//         // auto start service
//         autoStart: true,
//         isForegroundMode: true,
//         initialNotificationContent: "Background Service is Running",
//         initialNotificationTitle: "Mrep V03"),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,

//       // this will executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

// FutureOr<bool> onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');
//   return true;
// }

// void onStart(ServiceInstance service) {
//   DartPluginRegistrant.ensureInitialized();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   //********************Loop start********************
//   Timer.periodic(const Duration(minutes: 5), (timer) async {
//     // if (!(await service.isServiceRunning())) timer.cancel();

//     // //     //------------Internet Connectivity Check---------------------------
//     // final bool isConnected = await InternetConnectionChecker().hasConnection;
//     // print('Internet connection: $isConnected');
//     // // // ----------------------------------------------------------------------
//     // //     //----------------Set Notification------------------
//     // if (isConnected) {
//     //   service.setNotificationInfo(
//     //     title: "mRep7",
//     //     content: "Updated at ${DateTime.now()}",
//     //   );
//     // } else {
//     //   service.setNotificationInfo(
//     //     title: "mRep7",
//     //     content: "Updated at ${DateTime.now()}",
//     //   );
//     // }

//     //     //------------------------Geo Location-----------------

//     try {
//       geo.Position? position = await geo.Geolocator.getCurrentPosition();
//       if (position != null) {
//         lat = position.latitude;
//         long = position.longitude;

//         List<geocoding.Placemark> placemarks =
//             await geocoding.placemarkFromCoordinates(lat, long);

//         address = placemarks[0].street! + " " + placemarks[0].country!;
//       }
//     } on Exception catch (e) {
//       print("Exception geolocator section: $e");
//     }

//     print('latlong: $lat, $long');

//     //     //--------------------Api Hit Logic-----------------------------

//     if (lat != 0.0 && long != 0.0) {
//       if (location == "") {
//         location = "$lat|$long|$address";
//       } else {
//         location = "$location||$lat|$long|$address";
//       }
//     }

//     print(location);

//     // service.sendData(
//     //   {
//     //     //"current_date": DateTime.now().toIso8601String(),
//     //   },
//     // );
//     //     //-------------------------------------------------
//   });
//   Timer.periodic(Duration(minutes: 15), (timer) async {
//   //  SharedPreferences preferences =await SharedPreferences.getInstance();
//   //  preferences.setString("Address", address);
//     var body = await timeTracker(location);


//     print(body);
//     if (body["ret_str"] == "Invalid/Inactive User") {
//       if (body["status"] == "Success") {
//         location = "";
//       } else {
//         Fluttertoast.showToast(msg: "Location Tracking Failed");
//         location = "";
//       }
//     } else {
//       SameDeviceId = body["timer_flag"];
//       print(SameDeviceId);
//     }
//   });
// }
