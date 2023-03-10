// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart'as geo;
// import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mrap7/Pages/DCR_section/show_dcr_discussionData.dart';

import 'package:mrap7/Pages/DCR_section/show_dcr_gitfData.dart';
import 'package:mrap7/Pages/DCR_section/show_dcr_ppmData.dart';
import 'package:mrap7/Pages/DCR_section/show_dcr_sampleData.dart';
import 'package:mrap7/Pages/homePage.dart';
import 'package:mrap7/local_storage/hive_data_model.dart';
import 'package:mrap7/local_storage/boxes.dart';

import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DcrGiftSamplePpmPage extends StatefulWidget {
  int dcrKey;
  int uniqueId;
  String ck;
  String docName;
  String docId;
  String areaName;
  String areaId;
  String address;
  List<DcrGSPDataModel> draftOrderItem;
  DcrGiftSamplePpmPage({
    Key? key,
    required this.address,
    required this.areaId,
    required this.ck,
    required this.dcrKey,
    required this.uniqueId,
    required this.docName,
    required this.docId,
    required this.areaName,
    required this.draftOrderItem,
  }) : super(key: key);

  @override
  State<DcrGiftSamplePpmPage> createState() => _DcrGiftSamplePpmPageState();
}

class _DcrGiftSamplePpmPageState extends State<DcrGiftSamplePpmPage> {
  final TextEditingController datefieldController = TextEditingController();
  final TextEditingController timefieldController = TextEditingController();
  final TextEditingController paymentfieldController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _quantityController = TextEditingController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  // List<DcrGiftDataModel> addedDcrGift = [];
  List<DcrGSPDataModel> addedDcrGSPList = [];

  List addedDcrsample = [];
  List addedDcrPpm = [];

  Box? box;

  int _currentSelected = 2;

  List doctorGiftlist = [];
  List doctorSamplelist = [];
  List doctorPpmlist = [];
  List doctorDiscussionlist = [];
  List<String> dcr_visitedWithList = [];
  int dropDownNumber = 0;
  String noteText = '';
  String submit_url = '';
  String? cid;
  String? userId;
  String? userPassword;
  String itemString = '';
  String userName = '';
  String user_id = '';
  String startTime = '';
  String endTime = '';
  List visitedWith = [];
  double? latitude;
  double? longitude;
  String? deviceId = '';
  String? deviceBrand = '';
  String? deviceModel = '';
  String? dropdownVisitWithValue = '_';
  String doctor_url = "";
  // var items = [
  //   '_',
  //   'Rx',
  //   'Rxxxxx',
  //   'Rxxxxxxx',
  //   'Rxxxxxxxxx',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  bool _isLoading = true;
  bool dcr_discussion = true;
  bool _firstValue = false;
  bool docEditFlag = false;
  var dcrString;
  var newString;
  final mydata=Boxes.allData();
  @override
  void initState() {
    // dcr_visitedWithList.clear();
    // SharedPreferences.getInstance().then((prefs) {
      setState(() {
        // prefs.getStringList("dcr_visit_with_list")!.clear();
        startTime = mydata.get("startTime") ?? '';
        endTime = mydata.get("endTime") ?? '';
        doctor_url = mydata.get("doctor_url")!;
        submit_url = mydata.get("submit_url")!;
        cid = mydata.get("CID");
        userId = mydata.get("USER_ID");
        userPassword = mydata.get("PASSWORD");
        userName = mydata.get("userName")!;
        user_id = mydata.get("user_id")!;
        latitude = mydata.get("latitude");
        longitude = mydata.get("longitude");
        deviceId = mydata.get("deviceId");
        deviceBrand = mydata.get("deviceBrand");
        deviceModel = mydata.get("deviceModel");
        dcr_discussion = mydata.get("dcr_discussion") ?? false;
        docEditFlag = mydata.get("doc_edit_flag") ?? false;
        dcr_visitedWithList = mydata.get("dcr_visit_with_list")!;

        dropdownVisitWithValue = dcr_visitedWithList.first;
      });
    // });
    addedDcrGSPList = widget.draftOrderItem;
    setState(() {});
    if (widget.ck != '') {
      calculatingTotalitemString();
    } else {
      return;
    }

    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    noteController.dispose();
    paymentfieldController.dispose();
    timefieldController.dispose();
    datefieldController.dispose();

    super.dispose();
  }

  initialValue(String val) {
    return TextEditingController(text: val);
  }

  Future<void> _showMyDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure to remove the Item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                if (widget.ck != '') {
                  final uniqueKey = widget.dcrKey;
                  deleteSingleGSPItem(uniqueKey, index);

                  setState(() {});
                } else {
                  addedDcrGSPList.removeAt(index);
                  setState(() {});
                }
                // print('Confirmed');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  deleteSingleGSPItem(int rxDcrUniqueKey, int index) {
    final box = Hive.box<DcrGSPDataModel>("selectedDcrGSP");

    final Map<dynamic, DcrGSPDataModel> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.uiqueKey == rxDcrUniqueKey) desiredKey = key;
    });
    box.delete(desiredKey);
    addedDcrGSPList.removeAt(index);

    setState(() {});
  }

  _onItemTapped(int index) async {
    if (index == 0) {
      await putAddedDcrGSPData();
      Navigator.pop(context);
      setState(() {
        _currentSelected = index;
      });
    } else {}

    if (index == 2) {
      setState(() {
        _isLoading = false;
      });
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        // orderGSPSubmit();
      } else {
        _submitToastforOrder3();
        setState(() {
          _isLoading = true;
        });
        // print(InternetConnectionChecker().lastTryResults);
      }

      setState(() {
        _currentSelected = index;
      });
    }
  }

  void _submitToastforOrder3() {
    Fluttertoast.showToast(
        msg: 'No Internet Connection\nPlease check your internet connection.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            key: _drawerKey,
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              title: const Text(
                'Visit Doctor',
                style: TextStyle(
                    color: Color.fromARGB(255, 27, 56, 34),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            endDrawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.all(8),
                    // padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 138, 201, 149),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/mRep7_logo.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    widget.docName,
                                    // 'Chemist: ADEE MEDICINE CORNER(6777724244)',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 11, 22, 13),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    widget.docId,
                                    // 'Chemist: ADEE MEDICINE CORNER(6777724244)',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 11, 22, 13),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            docEditFlag
                                ? IconButton(
                                    onPressed: () async {
                                      var url =
                                          '$doctor_url/doctor_update?cid=$cid&rep_id=$userId&rep_pass=$userPassword&doc_id=${widget.docId}';
                                      print(url);
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                      // if (await canLaunchUrl(Uri.parse(url))) {
                                      //   await launchUrl(Uri.parse(url));
                                      // } else {
                                      //   throw 'Could not launch $url';
                                      // }
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      // size: 15,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight / 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff56CCF2).withOpacity(.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "  " + widget.docName,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 2, 3, 2),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "  " +
                                            widget.areaName +
                                            '(${widget.areaId})' +
                                            ',' +
                                            ' ' +
                                            widget.address,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 5, 10, 6),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              // const SizedBox(
                              //   width: 30,
                              // ),
                              // dcr_visitedWithList.isNotEmpty
                              //     ? Expanded(
                              //         flex: 3,
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             const SizedBox(
                              //               height: 10,
                              //             ),
                              //             const Text(
                              //               "Visited With :",
                              //               style: TextStyle(
                              //                 color:
                              //                     Color.fromARGB(255, 3, 7, 4),
                              //                 fontSize: 16,
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               height: 10,
                              //             ),
                              //             Expanded(
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   showDialog(
                              //                       context: context,
                              //                       builder:
                              //                           (BuildContext context) {
                              //                         return AlertDialog(
                              //                           content: Container(
                              //                             height: 300,
                              //                             child: GFMultiSelect(
                              //                               items:
                              //                                   dcr_visitedWithList,
                              //                               onSelect: (value) {
                              //                                 dcrString = '';
                              //                                 if (value
                              //                                     .isNotEmpty) {
                              //                                   for (var e
                              //                                       in value) {
                              //                                     if (dcrString ==
                              //                                         '') {
                              //                                       dcrString =
                              //                                           dcr_visitedWithList[
                              //                                               e];
                              //                                     } else {
                              //                                       dcrString += '|' +
                              //                                           dcr_visitedWithList[
                              //                                               e];
                              //                                     }
                              //                                   }
                              //                                 }

                              //                                 print(
                              //                                     'selected $value ');
                              //                                 print(dcrString);
                              //                               },
                              //                               // submitButton:
                              //                               //     submButton(),
                              //                               cancelButton:
                              //                                   cancalButton(),
                              //                               dropdownTitleTileText:
                              //                                   '',
                              //                               // dropdownTitleTileColor: Colors.grey[200],
                              //                               dropdownTitleTileMargin:
                              //                                   EdgeInsets.zero,
                              //                               dropdownTitleTilePadding:
                              //                                   EdgeInsets
                              //                                       .fromLTRB(
                              //                                           10,
                              //                                           0,
                              //                                           10,
                              //                                           0),
                              //                               dropdownUnderlineBorder:
                              //                                   const BorderSide(
                              //                                       color: Colors
                              //                                           .transparent,
                              //                                       width: 2),
                              //                               // dropdownTitleTileBorder:
                              //                               //     Border.all(color: Colors.grey, width: 1),
                              //                               // dropdownTitleTileBorderRadius: BorderRadius.circular(5),
                              //                               expandedIcon:
                              //                                   const Icon(
                              //                                 Icons
                              //                                     .keyboard_arrow_down,
                              //                                 color: Colors
                              //                                     .black54,
                              //                               ),
                              //                               collapsedIcon:
                              //                                   const Icon(
                              //                                 Icons
                              //                                     .keyboard_arrow_up,
                              //                                 color: Colors
                              //                                     .black54,
                              //                               ),

                              //                               // dropdownTitleTileTextStyle: const TextStyle(
                              //                               //     fontSize: 14, color: Colors.black54),
                              //                               padding:
                              //                                   const EdgeInsets
                              //                                       .all(0),
                              //                               margin:
                              //                                   const EdgeInsets
                              //                                       .all(0),
                              //                               type: GFCheckboxType
                              //                                   .basic,
                              //                               activeBgColor: Colors
                              //                                   .green
                              //                                   .withOpacity(
                              //                                       0.5),
                              //                               inactiveBorderColor:
                              //                                   Colors.grey,
                              //                             ),
                              //                           ),
                              //                         );
                              //                       });
                              //                   print("ok");
                              //                 },
                              //                 child: dcrString == null
                              //                     ? Text("Select")
                              //                     : Text(dcrString),
                              //               ),
                              //             ),

                              //             //=================================================Experiment
                              //             // Expanded(
                              //             //   // flex: 2,
                              //             //   child: DropdownButton(
                              //             //     isExpanded: true,
                              //             //     dropdownColor:
                              //             //         const Color.fromARGB(
                              //             //             255, 187, 234, 250),
                              //             //     // Initial Value
                              //             //     value: dropdownVisitWithValue,

                              //             //     // Down Arrow Icon
                              //             //     icon: const Icon(
                              //             //       Icons.keyboard_arrow_down,
                              //             //       color: Color.fromARGB(
                              //             //           255, 27, 56, 34),
                              //             //     ),

                              //             //     // Array list of items

                              //             //     items: dcr_visitedWithList
                              //             //         .map((item) {
                              //             //       return DropdownMenuItem(
                              //             //         value: item,
                              //             //         child: Row(
                              //             //           children: [
                              //             //             StatefulBuilder(builder:
                              //             //                 (BuildContext context,
                              //             //                     StateSetter
                              //             //                         stateSetter) {
                              //             //               return Checkbox(
                              //             //                 onChanged: (value) {
                              //             //                   stateSetter(() {
                              //             //                     _firstValue =
                              //             //                         value!;
                              //             //                     print(value);
                              //             //                   });
                              //             //                 },
                              //             //                 value: _firstValue,
                              //             //               );
                              //             //             }),
                              //             //             Text(
                              //             //               item,
                              //             //               style: const TextStyle(
                              //             //                 color: Color.fromARGB(
                              //             //                     255, 9, 19, 11),
                              //             //                 fontSize: 16,
                              //             //               ),
                              //             //             ),
                              //             //           ],
                              //             //         ),
                              //             //       );
                              //             //     }).toList(),

                              //             //     onChanged: (String? newValue) {
                              //             //       setState(() {
                              //             //         dropdownVisitWithValue =
                              //             //             newValue!;
                              //             //         print(dropdownVisitWithValue);
                              //             //       });
                              //             //     },
                              //             //   ),
                              //             // ),
                              //       ],
                              //     ),
                              //   )
                              // : const Text("")
                            ],
                          ),
                        ),
                      ),
                    ),
                    dcr_visitedWithList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Visited With",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )),
                                Expanded(
                                  child: Container(
                                    // width: 200,
                                    child: GFMultiSelect(
                                      items: dcr_visitedWithList,
                                      onSelect: (value) {
                                        dcrString = '';
                                        if (value.isNotEmpty) {
                                          for (var e in value) {
                                            if (dcrString == '') {
                                              dcrString =
                                                  dcr_visitedWithList[e];
                                            } else {
                                              dcrString +=
                                                  '|' + dcr_visitedWithList[e];
                                            }
                                          }
                                        }

                                        print('selected $value ');
                                        print(dcrString);
                                      },
                                      cancelButton: cancalButton(),
                                      dropdownTitleTileText: '',
                                      // dropdownTitleTileColor: Colors.grey[200],
                                      dropdownTitleTileMargin: EdgeInsets.zero,
                                      dropdownTitleTilePadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      dropdownUnderlineBorder: const BorderSide(
                                          color: Colors.transparent, width: 2),
                                      // dropdownTitleTileBorder:
                                      //     Border.all(color: Colors.grey, width: 1),
                                      // dropdownTitleTileBorderRadius: BorderRadius.circular(5),
                                      expandedIcon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black54,
                                      ),
                                      collapsedIcon: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black54,
                                      ),
                                      // submitButton: Text('OK'),
                                      // dropdownTitleTileTextStyle: const TextStyle(
                                      //     fontSize: 14, color: Colors.black54),
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      type: GFCheckboxType.basic,
                                      activeBgColor:
                                          Colors.green.withOpacity(0.5),
                                      inactiveBorderColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(""),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: SizedBox(
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 138, 201, 149)
                                .withOpacity(.5),
                          ),
                          // elevation: 6,

                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'[@#%^!~\\/:;]'))
                            ],
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            controller: noteController,
                            focusNode: FocusNode(),
                            autofocus: false,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                labelText: '  Notes...',
                                labelStyle: TextStyle(color: Colors.blueGrey)),
                            onChanged: (value) {
                              noteText = (noteController.text)
                                  .replaceAll(RegExp('[^A-Za-z0-9]'), " ");
                            },
                          ),
                        ),
                      ),
                    ),
                    // Doctor Gift section..................................
                    SizedBox(
                      height: screenHeight / 2.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: addedDcrGSPList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext itemBuilder, index) {
                          return Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    addedDcrGSPList[index]
                                                        .giftName,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 9, 38, 61),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                // Text(
                                                //   '(${addedDcrGSPList[index].giftType})',
                                                //   style: const TextStyle(
                                                //       fontSize: 16),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _showMyDialog(index);
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          addedDcrGSPList[index].giftType !=
                                                  "Discussion"
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                      'Qt:  ',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 9, 38, 61)),
                                                    ),
                                                    Text(
                                                      addedDcrGSPList[index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 9, 38, 61),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              : const Text(""),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                '(${addedDcrGSPList[index].giftType})',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 9, 38, 61),
                                                  fontSize: 16,
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
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getDcrGitData();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  width: screenWidth / 5.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 138, 201, 149),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          // Icon(Icons.add, color: Colors.white),
                                          // SizedBox(width: 5),
                                          Text(
                                            'Gift',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 15, 9),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            //     ElevatedButton(
                            //   onPressed: () {
                            // getDcrSampleData();
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     fixedSize: Size(screenWidth / 4,
                            //         MediaQuery.of(context).size.height / 16),
                            //     primary:
                            //         const Color.fromARGB(255, 55, 129, 167),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius:
                            //           BorderRadius.circular(10), // <-- Radius
                            //     ),
                            //   ),
                            //   child: FittedBox(
                            //     child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.center,
                            //         children: const [
                            //           Icon(Icons.add, color: Colors.white),
                            //           SizedBox(width: 5),
                            //           Text(
                            //              'Sample',
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18,
                            //             ),
                            //           ),
                            //         ]),
                            //   ),
                            // ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getDcrSampleData();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  width: screenWidth / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 138, 201, 149),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            // Icon(Icons.add,
                                            //     color: Colors.white),
                                            // SizedBox(width: 5),
                                            Text(
                                              'Sample',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 14, 8),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                getDcrPpmData();
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenWidth / 4.8,
                                    MediaQuery.of(context).size.height / 16),
                                primary:
                                    const Color.fromARGB(255, 138, 201, 149),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    // Icon(Icons.add, color: Colors.white),
                                    // SizedBox(width: 5),
                                    Text(
                                      'PPM',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 9, 19, 11),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        dcr_discussion == true
                            ? Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      getDcrDiscussionData();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                          screenWidth / 4,
                                          MediaQuery.of(context).size.height /
                                              16),
                                      primary: const Color.fromARGB(
                                          255, 138, 201, 149),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // <-- Radius
                                      ),
                                    ),
                                    child: FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          // Icon(Icons.add, color: Colors.white),
                                          // SizedBox(width: 5),
                                          Text(
                                            'Discus.',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 14, 8),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
              currentIndex: _currentSelected,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey[800],
              selectedItemColor: const Color.fromRGBO(10, 135, 255, 1),
              backgroundColor: Colors.white,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Save Drafts',
                  icon: Icon(Icons.drafts),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.clear,
                    color: Color.fromRGBO(255, 254, 254, 1),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Submit',
                  icon: Icon(Icons.save),
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(100),
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
  }

// doctor gift section............................
  Future giftOpenBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('dcrGiftListData');
  }

  // dcr gift section...........................
  getDcrGitData() async {
    await giftOpenBox();

    var mymap = box!.toMap().values.toList();

    if (mymap.isEmpty) {
      Fluttertoast.showToast(msg: "No Gift Found", backgroundColor: Colors.red);
      doctorGiftlist.add('empty');
    } else {
      doctorGiftlist = mymap;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DcrGiftDataPage(
            uniqueId: widget.uniqueId,
            doctorGiftlist: doctorGiftlist,
            tempList: addedDcrGSPList,
            tempListFunc: (value) {
              addedDcrGSPList = value;
              calculatingTotalitemString();

              setState(() {});
            },
          ),
        ),
      );
    }
  }

  // doctor Sample section.......................................................

  Future sampleOpenBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('dcrSampleListData');
  }

  getDcrSampleData() async {
    await sampleOpenBox();

    var mymap = box!.toMap().values.toList();

    if (mymap.isEmpty) {
      print('empty Sample');
      Fluttertoast.showToast(
          msg: "No Sample Found", backgroundColor: Colors.red);
      doctorSamplelist.add('empty');
    } else {
      doctorSamplelist = mymap;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DcrSampleDataPage(
            uniqueId: widget.uniqueId,
            doctorSamplelist: doctorSamplelist,
            tempList: addedDcrGSPList,
            tempListFunc: (value) {
              addedDcrGSPList = value;
              calculatingTotalitemString();

              setState(() {});
            },
          ),
        ),
      );
    }
  }

  // Doctor PPM section..........................................

  Future ppmOpenBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('dcrPpmListData');
  }

  getDcrPpmData() async {
    await ppmOpenBox();

    var mymap = box!.toMap().values.toList();

    if (mymap.isEmpty) {
      Fluttertoast.showToast(msg: "No PPM Found", backgroundColor: Colors.red);
      doctorPpmlist.add('empty');
    } else {
      doctorPpmlist = mymap;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DcrPpmDataPage(
            uniqueId: widget.uniqueId,
            doctorPpmlist: doctorPpmlist,
            tempList: addedDcrGSPList,
            tempListFunc: (value) {
              addedDcrGSPList = value;
              calculatingTotalitemString();

              setState(() {});
            },
          ),
        ),
      );
    }
  }
//=====================Discussion ====================================================
//=========================================================================================

  Future discussionOpenBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('syncItemData');
  }

  getDcrDiscussionData() async {
    await discussionOpenBox();

    var mymap = box!.toMap().values.toList();

    if (mymap.isEmpty) {
      Fluttertoast.showToast(
          msg: "No Discussion Found", backgroundColor: Colors.red);
      doctorDiscussionlist.add('empty');
    } else {
      doctorDiscussionlist = mymap;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DcrDiscussionPage(
            uniqueId: widget.uniqueId,
            doctorDiscussionlist: doctorDiscussionlist,
            tempList: addedDcrGSPList,
            tempListFunc: (value) {
              addedDcrGSPList = value;
              calculatingTotalitemString();

              setState(() {});
            },
          ),
        ),
      );
    }
  }

  calculatingTotalitemString() {
    itemString = '';

    if (addedDcrGSPList.isNotEmpty) {
      addedDcrGSPList.forEach((element) {
        if (itemString == '') {
          itemString = element.giftId.toString() +
              '|' +
              element.quantity.toString() +
              '|' +
              element.giftType;
        } else {
          itemString += '||' +
              element.giftId.toString() +
              '|' +
              element.quantity.toString() +
              '|' +
              element.giftType;
        }

        setState(() {});
      });
    } else {}
  }

  cancalButton() {
    dcrString = "";
  }

  submButton() {
    if (dcrString.contains("|")) {
      newString = dcrString.replaceAll(",", "|");
      print(newString);
    }
    Navigator.pop(context);
  }

  // Saved Added Gift, Sample, PPM to Hive

  // Save Gift data to hive
  Future addedSampleOpenBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('addedDcrSampletData');
  }

  Future putAddedDcrGSPData() async {
    List<DcrDataModel> doctorList = [];
    if (widget.ck != '') {
      for (int i = 0; i <= addedDcrGSPList.length; i++) {
        deleteDcrGSPItem(widget.dcrKey);

        setState(() {});
      }

      setState(() {});

      Navigator.pop(context);

      for (var d in addedDcrGSPList) {
        final box = Boxes.selectedDcrGSP();

        box.add(d);
      }
    } else {
      var doctor = DcrDataModel(
          uiqueKey: widget.uniqueId,
          docName: widget.docName,
          docId: widget.docId,
          areaId: widget.areaId,
          areaName: widget.areaName,
          address: 'address');
      doctorList.add(doctor);

      for (var dcr in doctorList) {
        final box = Boxes.dcrUsers();
        box.add(dcr);
      }

      for (var d in addedDcrGSPList) {
        final box = Boxes.selectedDcrGSP();

        box.add(d);
      }
    }
  }

  deleteDcrGSPItem(int id) {
    final box = Hive.box<DcrGSPDataModel>("selectedDcrGSP");

    final Map<dynamic, DcrGSPDataModel> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.uiqueKey == widget.dcrKey) desiredKey = key;
    });
    box.delete(desiredKey);
  }

  deleteDoctor(int id) {
    final box = Hive.box<DcrDataModel>("selectedDcr");

    final Map<dynamic, DcrDataModel> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.uiqueKey == widget.dcrKey) desiredKey = key;
    });
    box.delete(desiredKey);
  }

//   Future<dynamic> orderGSPSubmit() async {
//     String address='';
    

//  try {
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




// //todo add addresss
//     if (itemString != '') {
//       String a = submit_url + 'api_dcr_submit/submit_data';
//       print(a);
//       print(
//           "$submit_url api_dcr_submit/submit_data?cid=$cid&user_id=$userId&user_pass=$userPassword&device_id=$deviceId&doc_id=${widget.docId}&doc_area_id=${widget.areaId}&visit_with=$dcrString&latitude=$latitude&longitude=$longitude&item_list_gsp=$itemString&remarks=$noteText&location_detail=$address");
//       try {
//         final http.Response response = await http.post(
//           Uri.parse(submit_url + 'api_dcr_submit/submit_data'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8'
//           },
//           body: jsonEncode(
//             <String, dynamic>{
//               'cid': cid,
//               'user_id': userId,
//               'user_pass': userPassword,
//               'device_id': deviceId,
//               'doc_id': widget.docId,
//               'doc_area_id': widget.areaId,
//               'visit_with': dcrString,
//               "latitude": latitude,
//               'longitude': longitude,
//               'location_detail':address,
//               "item_list_gsp": itemString,
//               "remarks": noteText,
//             },
//           ),
//         );
//         // print(itemString);
//         // print(userId);
//         // print(userPassword);
//         // print(widget.docId);
//         var orderInfo = json.decode(response.body);
//         String status = orderInfo['status'];
//         String ret_str = orderInfo['ret_str'];

//         if (status == "Success") {
//           for (int i = 0; i <= addedDcrGSPList.length; i++) {
//             deleteDcrGSPItem(widget.dcrKey);

//             setState(() {});
//           }

//           deleteDoctor(widget.dcrKey);

//           setState(() {});

//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                   builder: (context) => MyHomePage(
//                         userName: userName,
//                         user_id: user_id,
//                         userPassword: userPassword ?? '',
//                       )),
//               (Route<dynamic> route) => false);

//           _submitToastforOrder(ret_str);
//         } else {
//           setState(() {
//             _isLoading = true;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('Submit Failed'), backgroundColor: Colors.red));
//         }
//       } on Exception catch (e) {
//         print(e);
//         setState(() {
//           _isLoading = true;
//         });
//         // throw Exception("Error on server");
//       }
//     } else {
//       setState(() {
//         _isLoading = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Please Add something',
//           ),
//           backgroundColor: Colors.red));
//     }
//   }

  void _submitToastforOrder(String ret_str) {
    Fluttertoast.showToast(
        msg: "DCR Submitted\n$ret_str",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green.shade900,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
