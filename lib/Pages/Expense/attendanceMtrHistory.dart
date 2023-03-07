// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../service/apiCall.dart';

// ignore: must_be_immutable
class AttendanceMeterHistory extends StatefulWidget {
  
  AttendanceMeterHistory({
    Key? key,
   
  }) : super(key: key);

  @override
  State<AttendanceMeterHistory> createState() => _AttendanceMeterHistoryState();
}

class _AttendanceMeterHistoryState extends State<AttendanceMeterHistory> {

  TextEditingController dateController = TextEditingController();
  List attenMtrLog=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_){

    _getDatat();

  });

  }
  _getDatat()async{
     attenMtrLog = await AttendanceMtrHistory();
     setState(() {
      print(attenMtrLog);

     

       
     });
  }

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance & Meter Reading log"),
        centerTitle: true,
      ),
      body:Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // Card(
          //   color: Color.fromARGB(255, 162, 220, 243),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Text(
          //           "DateTime",
          //           style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text(
          //           "Meter Reading",
          //           style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text(
          //           "Location",
          //           style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child:attenMtrLog.isEmpty?Center(child: CircularProgressIndicator(),):  ListView.builder(
                itemCount: attenMtrLog.length,
                itemBuilder: (context, i) {
                  var parts = attenMtrLog[i]["m_check_in"].split(" ");

                  return Card(
                    elevation: 5,
                    color: Color.fromARGB(255, 181, 217, 241),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Date: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${parts[0]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Time:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " ${parts[1]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "MTR Reading-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Start: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${attenMtrLog[i]["meter_reading_st"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "End:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " ${attenMtrLog[i]["meter_reading_end"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " ${attenMtrLog[i]["address"].toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1990),
        lastDate: DateTime(2060),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                surface: Colors.blue,
              ),
              // dialogBackgroundColor: Colors.white,
            ), // This will change to light theme.
            child: child!,
          );
        },
      );
}
