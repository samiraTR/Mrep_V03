import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/apiCall.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  TextEditingController mtrReading = TextEditingController();
  late AnimationController controller;
  var dt = DateFormat('HH:mm a').format(DateTime.now());

  String? userPass;
  String? cid;
  String? userId;
  double? lat;
  String? sync_url;
  String userName = '';
  String user_id = '';
  String? deviceId = '';
  var status;
  double? long;

  String address = "";
  String meter_reading_last = "";
  bool reportAttendance = true;
  final databox=Boxes.allData();
  @override
  void initState() {
    // getLatLong();
  
      setState(() {
        if ((databox.get("CID") == null) ||
            (databox.get("USER_ID") == null) ||
            databox.get("PASSWORD") == null) {
          return;
        } else {
          cid = databox.get("CID");
          userId = databox.get("USER_ID");
          userPass = databox.get("PASSWORD");
          sync_url = databox.get("sync_url")!;
          userName = databox.get("userName")!;
          user_id = databox.get("user_id")!;
          deviceId = databox.get("deviceId");
          meter_reading_last = databox.get('meter_reading_last')!;
        }
      });
 

    super.initState();
  }

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
  //   print(placemarks);
  //   setState(() {
  //     address = placemarks[0].street! + " " + placemarks[0].country!;
     
  //   });
  //   for (int i = 0; i < placemarks.length; i++) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Attendance"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: (lat == null && long == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DataTable(
                      dataRowHeight: 70,
                      columns: const [
                        DataColumn(label: Text("")),
                        DataColumn(label: Text(""))
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Latitude",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                lat.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Longitude",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                "$long",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Address",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                address,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Time",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                dt,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Last MTR Reading",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                meter_reading_last,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(
                              Color.fromARGB(255, 230, 179, 192)),
                          cells: [
                            const DataCell(
                              Text(
                                "Meter Reading",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller: mtrReading,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              primary: Colors.teal.withOpacity(0.5),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              if (mtrReading.text != "") {
                                if (reportAttendance == true) {
                                  await attendanceAPI(
                                      context,
                                      "START",
                                      reportAttendance,
                                      userName,
                                      mtrReading.text.toString(),
                                      lat,
                                      long,
                                      address);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Start Time has been Submitted for Today',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please Input Meter Reading',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: const Text(
                              "Day Start",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                primary: Colors.blueGrey,
                                onPrimary: Colors.white),
                            onPressed: () async {
                              if (mtrReading.text != "") {
                                await attendanceAPI(
                                    context,
                                    "END",
                                    reportAttendance,
                                    userName,
                                    mtrReading.text.toString(),
                                    lat,
                                    long,
                                    address);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please Input Meter Reading',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: const Text(
                              "Day End",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
