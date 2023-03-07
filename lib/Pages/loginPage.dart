// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrap7/Pages/homePage.dart';
import 'package:mrap7/Pages/syncDataTabPaga.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/all_service.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:mrap7/service/sharedPrefernce.dart';
import 'package:device_info_plus/device_info_plus.dart';

List<String> dcr_visitedWithList = [];
List<String> rxTypeList = [];
List<String> exp_reject_reasonList = [];

bool offer_flag = false;
bool? note_flag;
bool? client_edit_flag;
bool? os_show_flag;
bool? os_details_flag;
bool? ord_history_flag;
bool? inv_histroy_flag;
// bool? timer_flag;
bool? rx_doc_must;
bool? rx_type_must;
bool? rx_gallery_allow;

String version = "test";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _companyIdController = TextEditingController();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double screenHeight = 0;
  double screenWidth = 0;
  Color initialColor = Colors.white;
  bool _obscureText = true;
  List<String> visitedWith = [];
  List<String> rxType = [];
  String deviceId = '';
  String? deviceBrand = '';
  String? deviceModel = '';
  String? savedUserId = '';
  bool isLoading = false;
  bool timer_flag = false;
  final box = Boxes.allData();

  @override
  initState() {
    _getDeviceInfo();

    if (box.get("CID") != null) {
      var a = box.get("CID");
      savedUserId = box.get('user_id');
      setState(() {
        _companyIdController.text = a.toString();
      });
    }

    print("offer flag result $offer_flag");
    super.initState();
  }

  Future _getDeviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();

    var androidDeviceInfo = await deviceInfo.androidInfo;
    // deviceId = androidDeviceInfo.id!;

    deviceBrand = androidDeviceInfo.brand!;
    deviceModel = androidDeviceInfo.model!;

    try {
      deviceId = (await PlatformDeviceId.getDeviceId)!;
      // print(deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    // All_SharePreference().setDeviceInfo(deviceId, deviceBrand, deviceModel);
    //!Share preference
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('deviceId', deviceId);
    // await prefs.setString('deviceBrand', deviceBrand!);
    // await prefs.setString('deviceModel', deviceModel!);

    //todo!   add Hive
    box.put('deviceId', deviceId);
    box.put('deviceBrand', deviceBrand!);
    box.put('deviceModel', deviceModel!);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? Container(
            padding: const EdgeInsets.all(50),
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFFE2EFDA),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: screenHeight / 3.5,
                      width: screenWidth,
                      child: Center(
                        child: SizedBox(
                          width: 220,
                          height: 180,
                          child: Image.asset(
                            'assets/images/mRep7_wLogo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight - screenHeight / 2.8,
                      width: screenWidth,
                      color: const Color(0xFFE2EFDA),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 60),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight / 52,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth / 10,
                                    horizontal: screenWidth / 28),
                                child: Column(
                                  children: [
                                    // Company ID Field
                                    TextFormField(
                                      autofocus: false,
                                      controller: _companyIdController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        labelText: 'Company Id',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Provide Your valid CompanyId';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),

                                    SizedBox(
                                      height: screenHeight / 40,
                                    ),

                                    // User Id field
                                    TextFormField(
                                      autofocus: false,
                                      controller: _userIdController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        labelText: 'User Id',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Provide Your User Id';
                                        }
                                        if (value.contains("@")) {
                                          return 'Please Provide Your Valid User Id';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: screenHeight / 50,
                                    ),

                                    // Password Field
                                    TextFormField(
                                      obscureText: _obscureText,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.vpn_key,
                                          color:
                                              Color.fromARGB(255, 98, 126, 112),
                                        ),
                                        suffixIcon: _obscureText == true
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      _obscureText = false;
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.visibility_off,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ))
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureText = true;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.remove_red_eye,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        // RegExp regexp = RegExp(r'^.{6,}$');
                                        if (value!.isEmpty) {
                                          return 'Please enter your password.';
                                        }
                                        // if (value.length >= 6) {
                                        //   return 'Password is too short ,please expand';
                                        // }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: screenHeight / 60),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 4,
                              height: screenHeight / 12,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        bool result =
                                            await InternetConnectionChecker()
                                                .hasConnection;

                                        if (result == true) {
                                          dmPath(
                                              deviceId,
                                              deviceBrand,
                                              deviceModel,
                                              _companyIdController.text
                                                  .toUpperCase(),
                                              _userIdController.text,
                                              _passwordController.text,
                                              context);
                                          // SharedPreferncesMethod()
                                          //     .sharedPreferenceSetDataForLogin(
                                          //         _companyIdController.text
                                          //             .toUpperCase(),
                                          //         _userIdController.text,
                                          //         _passwordController.text);
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          AllServices().messageForUser(
                                              'No Internet Connection\nPlease check your internet connection.');

                                          // print(InternetConnectionChecker()
                                          //     .lastTryResults);
                                        }
                                      } else {}
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: Text(
                                  //     "v-${version}-20220924",
                                  //     style: TextStyle(fontSize: 14),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: screenWidth / 2.5,
                          // height: screenHeight / 10,
                          child: Text(
                            "v-${version}-20230130",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 129, 188, 236)),
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

  // buildShowDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: const [
  //             CircularProgressIndicator(
  //               color: Colors.white,
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //           ],
  //         );
  //       });
  // }

  ///********************************** Dm Path and Login function***********************************************************

  Future dmPath(String? deviceId, String? deviceBrand, String? deviceModel,
      String cid, String userId, String password, BuildContext context) async {
    try {
      print("http://dmpath.yeapps.com/dmpath/dmpath_test/get_dmpath?cid=$cid");
      final http.Response response = await http.get(
        Uri.parse(
            'http://dmpath.yeapps.com/dmpath/dmpath_test/get_dmpath?cid=$cid'),
      );

      var userInfo = json.decode(response.body);

      var status = userInfo['res_data'];
      if (status['ret_res'] == 'Welcome to mReporting.') {
        AllServices().messageForUser("Wrong CID");

        setState(() {
          isLoading = false;
        });
      } else {
        var login_url = status['login_url'];
        String sync_url = status['sync_url'] ?? '';
        // String submit_url = status['submit_url'];
        String report_sales_url = status['report_sales_url'];
        String report_dcr_url = status['report_dcr_url'];
        String report_rx_url = status['report_rx_url'];
        String photo_submit_url = status['photo_submit_url'];
        String photo_url = status['photo_url'];
        String leave_request_url = status['leave_request_url'];
        String leave_report_url = status['leave_report_url'];
        String plugin_url = status['plugin_url'];
        String tour_plan_url = status['tour_plan_url'];
        String tour_compliance_url = status['tour_compliance_url'];
        String client_url = status['client_url'];
        String doctor_url = status['doctor_url'];
        String activity_log_url = status['activity_log_url'];
        String user_sales_coll_ach_url = status['user_sales_coll_ach_url'];
        String client_outst_url = status['client_outst_url'];
        String user_area_url = status['user_area_url'];
        String os_details_url = status['os_details_url'];
        String ord_history_url = status['ord_history_url'];
        String inv_history_url = status['inv_history_url'];
        String client_edit_url = status['client_edit_url'];
        String timer_track_url = status['timer_track_url'];
        String exp_type_url = status['exp_type_url'];
        String exp_submit_url = status['exp_submit_url'];
        String report_exp_url = status['report_exp_url'];
        String report_outst_url = status['report_outst_url'];
        String report_last_ord_url = status['report_last_ord_url'];
        String report_last_inv_url = status['report_last_inv_url'];
        String exp_approval_url = status['exp_approval_url'];
        String sync_notice_url = status['sync_notice_url'];
        String report_atten_url = status['report_atten_url'];
        // All_SharePreference().setDMPathData(
        //     sync_url,
        //     report_sales_url,
        //     report_dcr_url,
        //     report_rx_url,
        //     photo_submit_url,
        //     activity_log_url,
        //     client_outst_url,
        //     user_area_url,
        //     photo_url,
        //     leave_request_url,
        //     leave_report_url,
        //     plugin_url,
        //     tour_plan_url,
        //     tour_compliance_url,
        //     client_url,
        //     doctor_url,
        //     user_sales_coll_ach_url,
        //     os_details_url,
        //     ord_history_url,
        //     inv_history_url,
        //     client_edit_url,
        //     timer_track_url,
        //     exp_type_url,
        //     exp_submit_url,
        //     report_exp_url,
        //     report_outst_url,
        //     report_last_ord_url,
        //     report_last_inv_url,
        //     exp_approval_url,
        //     sync_notice_url,
        //     report_atten_url);

        //todo Start Shareprefarence

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('sync_url', sync_url);
        // // await prefs.setString('submit_url', submit_url);
        // await prefs.setString('report_sales_url', report_sales_url);
        // await prefs.setString('report_dcr_url', report_dcr_url);
        // await prefs.setString('report_rx_url', report_rx_url);
        // await prefs.setString('photo_submit_url', photo_submit_url);
        // await prefs.setString('activity_log_url', activity_log_url);
        // await prefs.setString('client_outst_url', client_outst_url);
        // await prefs.setString('user_area_url', user_area_url);
        // await prefs.setString('photo_url', photo_url);
        // await prefs.setString('leave_request_url', leave_request_url);
        // await prefs.setString('leave_report_url', leave_report_url);
        // await prefs.setString('plugin_url', plugin_url);
        // await prefs.setString('tour_plan_url', tour_plan_url);
        // await prefs.setString('tour_compliance_url', tour_compliance_url);
        // await prefs.setString('client_url', client_url);
        // await prefs.setString('doctor_url', doctor_url);
        // await prefs.setString(
        //     'user_sales_coll_ach_url', user_sales_coll_ach_url);
        // await prefs.setString('os_details_url', os_details_url);
        // await prefs.setString('ord_history_url', ord_history_url);
        // await prefs.setString('inv_history_url', inv_history_url);
        // await prefs.setString('client_edit_url', client_edit_url);
        // await prefs.setString('timer_track_url', timer_track_url);
        // await prefs.setString('exp_type_url', exp_type_url);
        // await prefs.setString('exp_submit_url', exp_submit_url);
        // await prefs.setString('report_exp_url', report_exp_url);
        // // await prefs.setString('report_exp_url', report_exp_url);
        // await prefs.setString('report_outst_url', report_outst_url);
        // await prefs.setString('report_last_ord_url', report_last_ord_url);
        // await prefs.setString('report_last_inv_url', report_last_inv_url);
        // await prefs.setString('exp_approval_url', exp_approval_url);
        // await prefs.setString('sync_notice_url', sync_notice_url);
        // await prefs.setString('report_atten_url', report_atten_url);
        // //todo Add HIVe,

        //todo! Start Hive

        box.put(
          "sync_url",
          sync_url,
        );
        box.put('report_sales_url', report_sales_url);
        box.put('report_dcr_url', report_dcr_url);
        box.put('report_rx_url', report_rx_url);
        box.put('photo_submit_url', photo_submit_url);
        box.put('activity_log_url', activity_log_url);
        box.put('client_outst_url', client_outst_url);
        box.put('user_area_url', user_area_url);
        box.put('photo_url', photo_url);
        box.put('leave_request_url', leave_request_url);
        box.put('leave_report_url', leave_report_url);
        box.put('plugin_url', plugin_url);
        box.put('tour_plan_url', tour_plan_url);
        box.put('tour_compliance_url', tour_compliance_url);
        box.put('client_url', client_url);
        box.put('doctor_url', doctor_url);
        box.put('user_sales_coll_ach_url', user_sales_coll_ach_url);
        box.put('os_details_url', os_details_url);
        box.put('ord_history_url', ord_history_url);
        box.put('inv_history_url', inv_history_url);
        box.put('client_edit_url', client_edit_url);
        box.put('timer_track_url', timer_track_url);
        box.put('exp_type_url', exp_type_url);
        box.put('exp_submit_url', exp_submit_url);
        box.put('report_exp_url', report_exp_url);
        box.put('report_outst_url', report_outst_url);
        box.put('report_last_ord_url', report_last_ord_url);
        box.put('report_last_inv_url', report_last_inv_url);
        box.put('exp_approval_url', exp_approval_url);
        box.put('sync_notice_url', sync_notice_url);
        box.put('report_atten_url', report_atten_url);

        login(deviceId, deviceBrand, deviceModel, cid, userId, password,
            login_url, context);
      }

      // return isLoading;
    } on Exception catch (e) {
      // throw Exception(e);
      print(e);
    }
  }

  Future login(
      String? deviceId,
      String? deviceBrand,
      String? deviceModel,
      String cid,
      String userId,
      String password,
      String loginUrl,
      BuildContext context) async {
    version = 'v03';
    print(
        '$loginUrl?cid=$cid&user_id=$userId&user_pass=$password&device_id=$deviceId&device_brand=$deviceBrand&device_model=$deviceModel' +
            '_$version');
    try {
      final http.Response response = await http.get(
        Uri.parse(
            '$loginUrl?cid=$cid&user_id=$userId&user_pass=$password&device_id=$deviceId&device_brand=$deviceBrand&device_model=$deviceModel' +
                '_$version'),
      );

      // final Map<String, dynamic> jsonresponse = json.decode(response.body);

      var userInfo = json.decode(response.body);
      var status = userInfo['status'];

      if (status == 'Success') {
        setState(() {
          isLoading = true;
        });

        String userName = userInfo['user_name'];
        String user_id = userInfo['user_id'];
        String mobile_no = userInfo['mobile_no'];
        offer_flag = userInfo['offer_flag'];
        note_flag = userInfo['note_flag'];
        client_edit_flag = userInfo['client_edit_flag'];
        os_show_flag = userInfo['os_show_flag'];
        os_details_flag = userInfo['os_details_flag'];
        ord_history_flag = userInfo['ord_history_flag'];
        inv_histroy_flag = userInfo['inv_histroy_flag'];

        timer_flag = userInfo['timer_flag'];
        rx_doc_must = userInfo['rx_doc_must'];
        rx_type_must = userInfo['rx_type_must'];
        rx_gallery_allow = userInfo['rx_gallery_allow'];

        List dcr_visit_with_list = userInfo['dcr_visit_with_list'];

        List rx_type_list = userInfo['rx_type_list'];
        bool order_flag = userInfo['order_flag'];
        bool dcr_flag = userInfo['dcr_flag'];
        bool rx_flag = userInfo['rx_flag'];
        bool others_flag = userInfo['others_flag'];
        bool client_flag = userInfo['client_flag'];
        bool visit_plan_flag = userInfo['visit_plan_flag'];
        bool plagin_flag = userInfo['plagin_flag'];
        bool dcr_discussion = userInfo['dcr_discussion'];
        bool promo_flag = userInfo['promo_flag'];
        bool leave_flag = userInfo['leave_flag'];
        bool notice_flag = userInfo['notice_flag'];
        bool doc_flag = userInfo['doc_flag'];
        bool doc_edit_flag = userInfo['doc_edit_flag'];
        String meter_reading_last = userInfo['meter_reading_last'] ?? '';
        // List  exp_reject_reason = userInfo['exp_reject_reason'];
        // bool exp_approval_flag = userInfo['exp_approval_flag'];

        // print("Rejected Reson is::::::$exp_reject_reason");

        print('Last Metter Reading$meter_reading_last');
        dcr_visitedWithList.clear();
        for (int i = 0; i < dcr_visit_with_list.length; i++) {
          dcr_visitedWithList.add(dcr_visit_with_list[i]);
        }
        rxTypeList.clear();
        rx_type_list.forEach((element) {
          rxTypeList.add(element);
        });
        exp_reject_reasonList.clear();
        // exp_reject_reason.forEach((element) {
        //   exp_reject_reasonList.add(element);
        // });

        print("NNNEWWW LISt is :::::::$exp_reject_reasonList");

        // All_SharePreference().setLogInData(
        //     userInfo['area_page'],
        //     userName,
        //     user_id,
        //     password,
        //     mobile_no,
        //     offer_flag,
        //     note_flag,
        //     client_edit_flag,
        //     os_show_flag,
        //     os_details_flag,
        //     ord_history_flag,
        //     inv_histroy_flag,
        //     client_flag,
        //     rx_doc_must,
        //     rx_type_must,
        //     rx_gallery_allow,
        //     order_flag,
        //     dcr_flag,
        //     timer_flag,
        //     rx_flag,
        //     others_flag,
        //     visit_plan_flag,
        //     plagin_flag,
        //     dcr_discussion,
        //     promo_flag,
        //     leave_flag,
        //     notice_flag,
        //     doc_flag,
        //     doc_edit_flag,
        //     dcr_visitedWithList,
        //     meter_reading_last,
        //     rxTypeList);
        //todo! start shareprefarence
        // final prefs = await SharedPreferences.getInstance();
        // // await prefs.clear();
        // await prefs.setBool('areaPage', userInfo['area_page']);
        // await prefs.setString('userName', userName);
        // await prefs.setString('user_id', user_id);
        // await prefs.setString('PASSWORD', password);
        // await prefs.setString('mobile_no', mobile_no);
        // await prefs.setBool('offer_flag', offer_flag);
        // await prefs.setBool('note_flag', note_flag!);
        // await prefs.setBool('client_edit_flag', client_edit_flag!);
        // await prefs.setBool('os_show_flag', os_show_flag!);
        // await prefs.setBool('os_details_flag', os_details_flag!);
        // await prefs.setBool('ord_history_flag', ord_history_flag!);
        // await prefs.setBool('inv_histroy_flag', inv_histroy_flag!);
        // await prefs.setBool('client_flag', client_flag);
        // await prefs.setBool('rx_doc_must', rx_doc_must!);
        // await prefs.setBool('rx_type_must', rx_type_must!);
        // await prefs.setBool('rx_gallery_allow', rx_gallery_allow!);
        // await prefs.setBool('order_flag', order_flag);
        // await prefs.setBool('dcr_flag', dcr_flag);
        // await prefs.setBool('timer_flag', timer_flag);
        // await prefs.setBool('rx_flag', rx_flag);
        // await prefs.setBool('others_flag', others_flag);
        // await prefs.setBool('visit_plan_flag', visit_plan_flag);
        // await prefs.setBool('plagin_flag', plagin_flag);
        // await prefs.setBool('dcr_discussion', dcr_discussion);
        // await prefs.setBool('promo_flag', promo_flag);
        // await prefs.setBool('leave_flag', leave_flag);
        // await prefs.setBool('notice_flag', notice_flag);
        // await prefs.setBool('doc_flag', doc_flag);
        // await prefs.setBool('doc_edit_flag', doc_edit_flag);

        // await prefs.setStringList('dcr_visit_with_list', dcr_visitedWithList);
        // await prefs.setString('meter_reading_last', meter_reading_last);
        // await prefs.setBool('exp_approval_flag', exp_approval_flag);

        // await prefs.setStringList('rx_type_list', rxTypeList);
        // await prefs.setStringList('exp_reject_reason',exp_reject_reasonList);

        //todo Add data HIVe......

        box.put('areaPage', userInfo['area_page']);
        box.put('userName', userName);
        box.put('user_id', user_id);
        box.put('PASSWORD', password);
        box.put('mobile_no', mobile_no);
        box.put('offer_flag', offer_flag);
        box.put('note_flag', note_flag!);
        box.put('client_edit_flag', client_edit_flag!);
        box.put('os_show_flag', os_show_flag!);
        box.put('os_details_flag', os_details_flag!);
        box.put('ord_history_flag', ord_history_flag!);
        box.put('inv_histroy_flag', inv_histroy_flag!);
        box.put('client_flag', client_flag);
        box.put('rx_doc_must', rx_doc_must!);
        box.put('rx_type_must', rx_type_must!);
        box.put('rx_gallery_allow', rx_gallery_allow!);
        box.put('order_flag', order_flag);
        box.put('dcr_flag', dcr_flag);
        box.put('timer_flag', timer_flag);
        box.put('rx_flag', rx_flag);
        box.put('others_flag', others_flag);
        box.put('visit_plan_flag', visit_plan_flag);
        box.put('plagin_flag', plagin_flag);
        box.put('dcr_discussion', dcr_discussion);
        box.put('promo_flag', promo_flag);
        box.put('leave_flag', leave_flag);
        box.put('notice_flag', notice_flag);
        box.put('doc_flag', doc_flag);
        box.put('doc_edit_flag', doc_edit_flag);
        box.put('dcr_visit_with_list', dcr_visitedWithList);
        box.put('meter_reading_last', meter_reading_last);
        // box.put('exp_approval_flag', exp_approval_flag);
        box.put('rx_type_list', rxTypeList);
        box.put('exp_reject_reason', exp_reject_reasonList);

        All_SharePreference().setLoginDataHiave(cid, userId, password);

        Hive.openBox('data').then(
          (value) {
            // var mymap = value.toMap().values.toList();
            List clientToken = value.toMap().values.toList();

            if (clientToken.isNotEmpty && savedUserId == userId) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    userName: userName,
                    user_id: user_id,
                    userPassword: password,
                  ),
                ),
              );
            } else {
              Hive.openBox('data').then((value) => value.clear());
              Hive.openBox('syncItemData').then((value) => value.clear());
              Hive.openBox('dcrListData').then((value) => value.clear());
              Hive.openBox('dcrGiftListData').then((value) => value.clear());
              Hive.openBox('dcrSampleListData').then((value) => value.clear());
              Hive.openBox('dcrPpmListData').then((value) => value.clear());
              Hive.openBox('medicineList').then((value) => value.clear());

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SyncDataTabScreen(
                    cid: cid,
                    userId: user_id,
                    userPassword: password,
                  ),
                ),
              );
            }
          },
        );
      } else {
        setState(() {
          Fluttertoast.showToast(
            msg: status, // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.CENTER, // location
            // duration
          );
          isLoading = false;
        });
        AllServices().messageForUser("Wrong user Id and Password");
      }
    } on Exception catch (_) {
      throw Exception("Error on server");
    }
  }
}
