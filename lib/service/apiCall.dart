import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mrap7/Pages/homePage.dart';
import 'package:mrap7/Pages/loginPage.dart';
import 'package:mrap7/Pages/order_sections/customerListPage.dart';
import 'package:mrap7/Pages/target_achievemet.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/all_service.dart';


String timer_track_url = "";
String sync_notice_url = "";
String expenseSubmit = "";
String expenseType = "";
String sync_url = "";
String reportAttMtr = "";
String expenseReport = "";
String cid = "";
String user_id = "";
String user_pass = "";
String device_id = "";
final databox=Boxes.allData();
getboxData(){
 
  timer_track_url = databox.get("timer_track_url") ?? "";
  expenseSubmit = databox.get("exp_submit_url") ?? "";
  expenseType = databox.get("exp_type_url") ?? "";
  sync_url = databox.get("sync_url") ?? "";
  reportAttMtr = databox.get("report_atten_url") ?? "";
  sync_notice_url = databox.get("sync_notice_url") ?? "";
  expenseReport = databox.get("report_exp_url") ?? "";
  cid = databox.get("CID") ?? '';
  user_id = databox.get("USER_ID") ?? '';
  user_pass = databox.get("PASSWORD") ?? '';
  device_id = databox.get("deviceId") ?? '';
}

///*************************************************** *************************************///
///******************************** Reset Password **********************************************///
///******************************** ********************************************************///

Future ResetPass(sync_url, oldPass, newPass, conPass, cont) async {
    getboxData();
  print(device_id);
  print('$sync_url' + "api_utility/change_password");
  final response = await http.post(
    Uri.parse('$sync_url' + "api_utility/change_password"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "cid": cid,
      "user_id": user_id,
      "user_pass": user_pass,
      "device_id": device_id,
      "old_pass": oldPass,
      "new_pass": newPass,
      "con_pass": conPass,
    }),
  );

  var statusCode = response.statusCode;
  if (statusCode == 200) {
    var data = json.decode(response.body);
    ScaffoldMessenger.of(cont).showSnackBar(
        const SnackBar(content: Text('Completed Reset Password')));
    Navigator.push(
        cont, MaterialPageRoute(builder: (_) => const LoginScreen()));
    // print('reset');
  } else {
    ScaffoldMessenger.of(cont).showSnackBar(
        const SnackBar(content: Text('InCompleted Reset Password')));
  }
  return "Null";
}

///*************************************************** *************************************///
///******************************** Area page **********************************************///
///******************************** ********************************************************///

Future<List> getAreaPage(
    areaPageUrl, String cid, String userId, String userPassword) async {
  List arePageList = [];

  try {
    final http.Response res = await http.get(
        Uri.parse(
            '$areaPageUrl?cid=$cid&user_id=$userId&user_pass=$userPassword'),
        headers: <String, String>{
          'Content-Type': 'appliscation/json; charset=UTF-8'
        });

    var areaPageInfo = json.decode(res.body);
    String status = areaPageInfo['status'];
    if (status == 'Success') {
      // arePageList = areaPageDataModelFromJson(res.body);
      arePageList = areaPageInfo['area_list'];
      return arePageList;
    } else {
      return arePageList;
    }
  } catch (e) {
    print('Error message: $e');
  }
  return arePageList;
}

///*************************************************** *************************************///
///******************************** Area Base Client ***************************************///
///******************************** ********************************************************///

Future<bool> getAreaBaseClient(BuildContext context, String syncUrl, cid,
    userId, userPassword, areaId) async {
  List clientList = [];
  try {
    final http.Response res = await http.get(
        Uri.parse(
            '$syncUrl/api_client/client_list?cid=$cid&user_id=$userId&user_pass=$userPassword&area_id=$areaId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    var clientJsonData = json.decode(res.body);
    String clientStatus = clientJsonData['status'];

    if (clientStatus == 'Success') {
      clientList = clientJsonData['clientList'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CustomerListScreen(
                    data: clientList,
                  )));
      return false;
    } else {
      return false;
    }
  } catch (e) {
    print('Error message: $e');
  }
  return false;
}

///*************************************************** *************************************///
///******************************** Target Achievement *************************************///
///******************************** ********************************************************///

Future getTarAch(BuildContext context, String userSalesCollAchUrl, cid, userId,
    userPassword, deviceId) async {
  print(
      '$userSalesCollAchUrl?cid=$cid&user_id=$userId&user_pass=$userPassword&device_id=$deviceId');
  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$userSalesCollAchUrl?cid=$cid&user_id=$userId&user_pass=$userPassword&device_id=$deviceId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    var userInfo = json.decode(response.body);
    var status = userInfo['status'];
    print(status);
    if (status == 'Success') {
      List tarAchievementList = userInfo['userSalesCollAchList'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => TargetAchievement(
                    tarAchievementList: tarAchievementList,
                  )));
    } else {
      // _submitToastforOrder2();
    }
  } on Exception catch (_) {
    // throw Exception("Error on server");
    Fluttertoast.showToast(msg: "No Target Achievement ");
  }
}

///*************************************************** *************************************///
///******************************** Order History ******************************************///
///******************************** ********************************************************///

Future getOrderHistory() async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            'http://w305.yeapps.com/acme_api/api_ord_history/ord_history'),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var orderHistoryInfo = json.decode(response.body);
    String status = orderHistoryInfo['status'];
    if (status == 'Success') {
      return null;
    }
  } catch (e) {
    print('Order History error message: $e');
  }
  return null;
}

///*************************************************** *************************************///
///******************************** Invoice History ******************************************///
///******************************** ********************************************************///

Future getInvoiceHistory() async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            'http://w305.yeapps.com/acme_api/api_inv_history/inv_history'),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var invoiceHistoryInfo = json.decode(response.body);
    String status = invoiceHistoryInfo['status'];
    if (status == 'Success') {
      return null;
    }
  } catch (e) {
    print('Invoice history error message: $e');
  }
  return null;
}

///*************************************************** *************************************///
///******************************** OutStanding Details ***********************************///
///******************************** ********************************************************///

Future getOutStandingDetails() async {
  try {
    final http.Response response = await http.get(
        Uri.parse('http://w305.yeapps.com/acme_api/api_os_details/os_details'),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var outDetailsInfo = json.decode(response.body);
    String status = outDetailsInfo['status'];
    if (status == 'Success') {
      return null;
    }
  } catch (e) {
    print('OutStanding Details error message: $e');
  }
  return null;
}

///*************************************************** *************************************///
///******************************** Edit URL *************************************///
///******************************** ********************************************************///
///
///
///

Future timeTracker(String location) async {
   getboxData();
  print("ok ok-----------${timer_track_url}");
  print(cid);
  print(user_id);
  print(user_pass);
  print(device_id);
  if (location != "") {
    final response = await http.post(
      Uri.parse(
          // 'w05.yeapps.com/acme_api/api_expense_submit/submit_data'
          "${timer_track_url}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "cid": cid,
        "user_id": user_id,
        "user_pass": user_pass,
        "device_id": device_id,
        "locations": location,
      }),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;
    }
  }

  return "Null";
}

///*************************************************** *************************************///
///******************************** Attendance  ******************************************///
///******************************** ********************************************************///
Future attendanceAPI(BuildContext context, String submitType, reportAttendance,
    userName, mtrReading, lat, long, address) async {
    getboxData();
  print(
      "${sync_url}api_attendance_submit/submit_data?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&latitude=$lat&longitude=$long&address=$address&submit_type=$submitType&meter_reading=$mtrReading");
  if (reportAttendance == true) {
    final response = await http.get(
      Uri.parse(
          "${sync_url}api_attendance_submit/submit_data?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&latitude=${lat.toString()}&longitude=${long.toString()}&address=${address.toString()}&submit_type=$submitType&meter_reading=$mtrReading"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var data = json.decode(response.body);
    print("data ${data["status"]}");

    if (data["status"] == "Success") {
      var returnString = data["ret_str"];
      var startTime = data["start_time"];
      var endTime = data["end_time"];
      String meter_reading_last = data["meter_reading_last"];
      reportAttendance = false;
    
      await databox.put('startTime', startTime);
      await databox.put('endTime', endTime);
      await databox.put('meter_reading_last', meter_reading_last);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    userName: userName,
                    user_id: user_id,
                    userPassword: user_pass,
                  )));
    } else {
      AllServices().messageForUser(
        data["ret_str"],
      );
      // Fluttertoast.showToast(
      //   msg: data["ret_str"],
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0);
    }
  } else {
    Fluttertoast.showToast(
        msg: 'End Time has been Submitted for Today',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

///*************************************************** *************************************///
///******************************** Expense Entry ******************************************///
///******************************** ********************************************************///

expenseEntry() async {
    getboxData();
  print("$expenseType?cid=$cid&user_id=$user_id&user_pass=$user_pass");

  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$expenseType?cid=$cid&user_id=$user_id&user_pass=$user_pass'),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var orderHistoryInfo = json.decode(response.body);

    String status = orderHistoryInfo['status'];
    List expTypeList = orderHistoryInfo['expTypeList'];

    if (status == 'Success') {
      return expTypeList;
    }
  } catch (e) {
    print('Order History error message: $e');
  }
  return "error";
}

///*************************************************** *************************************///
///******************************** Expense Submit ******************************************///
///******************************** ********************************************************///

SubmitToExpense(expDAteforSubmit, itemString) async {
    getboxData();
  print(
      "$expenseSubmit?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date=$expDAteforSubmit&exp_data=$itemString");

  try {
    final http.Response response = await http.get(
        Uri.parse(
            "$expenseSubmit?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date=$expDAteforSubmit&exp_data=$itemString"),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var ExpenseSubmitInfo = json.decode(response.body);
    // print(ExpenseSubmitInfo);
    // String status = orderHistoryInfo['status'];
    // List expTypeList = orderHistoryInfo['expTypeList'];
    return ExpenseSubmitInfo;

    // if (status == 'Success') {
    //   return "200";
    //   // return expTypeList;

    // }
  } catch (e) {
    print('Expense Submit error message: $e');
  }
  return "error";
}

///*************************************************** *************************************///
///******************************** Expense LOG/EXPENSE REPORT ******************************************///
///******************************** ********************************************************///

ExpenseReport() async {
    getboxData();
  print(expenseReport +
      "expense_history_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id");

  try {
    final http.Response response = await http.get(
      Uri.parse(expenseReport +
          "expense_history_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id"),
      // headers: <String, String>{
      //   'Content-Type': 'Application/json; charset=UTF-8'
      // }
    );

    var ExpenseHistoryInfo = json.decode(response.body);

    // print(ExpenseHistoryInfo);

    return ExpenseHistoryInfo;
  } catch (e) {
    print('Expense History error message: $e');
  }
  return "error";
}

///*************************************************** *************************************///
///******************************** Notice [[Homepage]] ******************************************///
///******************************** ********************************************************///

noticeEvent() async {
    getboxData();
  print("$sync_notice_url?cid=$cid&user_id=$user_id&user_pass=$user_pass");

  try {
    final http.Response response = await http.get(
        Uri.parse(
            "$sync_notice_url?cid=$cid&user_id=$user_id&user_pass=$user_pass"),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var noticeDetails = json.decode(response.body);
    // print(noticeDetails);
    String status = noticeDetails['status'];
    List noticeList = noticeDetails['noticeList'];
    if (status == "Success") {
      return noticeList;
    } else {
      return "error";
    }
  } catch (e) {
    print('notice error message: $e');
  }
  return "error";
}

///*************************************************** *************************************///
///******************************** ExpApprovarl Lists [[expense]] ******************************************///
///******************************** ********************************************************///

expensapprovel(
    {String? cid,
    ff_type,
    user_id,
    user_pass,
    device_id,
    exp_date_from,
    exp_date_to,
    exp_url}) async {
  print(
      "${exp_url}expense_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type");

  try {
    final response = await http.get(
      Uri.parse(
          "${exp_url}expense_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List approvalDatalist = data['expList'];

      // print(approvalDatalist);

      return approvalDatalist;
    } else {
      return 'error';
    }
  } catch (e) {
    print(e);
  }

  return "error";
}

///*************************************************** *************************************///
///******************************** ExpApprovarl 0f Reject [[expense]] ******************************************///
///******************************** ********************************************************///

expenseApproveAndReject(
    {String? cid,
    ff_type,
    user_id,
    user_pass,
    device_id,
    exp_date_from,
    exp_date_to,
    exp_url,
    status,
    exp_string,
    reasonController}) async {
  print(
      "${exp_url}update_status_emp_exp_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id_list=$exp_string&status=$status&reject_reason=$reasonController");
  Response? data;
  var dat;
  try {
    final Response data = await http.get(
      Uri.parse(
          "${exp_url}update_status_emp_exp_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id_list=$exp_string&status=$status&reject_reason=$reasonController"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (data.statusCode == 200) {
      var dat = jsonDecode(data.body);
      return dat;
    } else {
      return 'error';
    }
  } catch (e) {
    print(e);
  }

  return dat;
}

///*************************************************** *************************************///
///******************************** Exp Emp Details List[[expense]] ******************************************///
///******************************** ********************************************************///

ExpEmpDetailsList(
    {String? cid,
    ff_type,
    user_id,
    user_pass,
    device_id,
    exp_date_from,
    exp_date_to,
    exp_url,
    emp_id}) async {
  print(
      "${exp_url}emp_expense_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id=$emp_id");

  try {
    final response = await http.get(
      Uri.parse(
          "${exp_url}emp_expense_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id=$emp_id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // print('api data $data');

      List approvalDatalistData = data['expList'];

      // print('in list api $approvalDatalistData');

      return approvalDatalistData;
    } else {
      return 'error';
    }
  } catch (e) {
    print(e);
  }

  return "error";
}

///*************************************************** *************************************///
///********************************Emp ExpApprovarl 0f Reject Details [[expense]] ******************************************///
///******************************** ********************************************************///

Future expenseEmpApproveAndRejectDetels(
    {String? cid,
    ff_type,
    user_id,
    user_pass,
    device_id,
    exp_date_from,
    exp_date_to,
    exp_url,
    emp_id,
    emp_id_exp_sl_list,
    status,
    reasonController}) async {
  print(
      "${exp_url}update_status_emp_exp_sl_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id=$emp_id&emp_id_exp_sl_list=$emp_id_exp_sl_list&status=$status&reject_reason=$reasonController");
  Response? data;
  var dat;
  try {
    final Response data = await http.get(
      Uri.parse(
          "${exp_url}update_status_emp_exp_sl_list?cid=$cid&user_id=$user_id&user_pass=$user_pass&device_id=$device_id&exp_date_from=$exp_date_from&exp_date_to=$exp_date_to&ff_type=$ff_type&emp_id=$emp_id&emp_id_exp_sl_list=$emp_id_exp_sl_list&status=$status&reject_reason=$reasonController"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (data.statusCode == 200) {
      var dat = jsonDecode(data.body);

      // print('In Api ...........$dat');

      return dat;
    } else {
      return 'error';
    }
  } catch (e) {
    print(e);
  }

  return dat;
}

///*************************************************** *********************************************************///
///********************************Expense Summary *******************************///
///******************************** ***************************************************************************///
ExpenseSummary(initialDate, lastDate) async {
    getboxData();
  print(expenseReport +
      "expense_summary_by_exp_head?cid=$cid&user_id=$user_id&user_pass=$user_pass&date_from=$initialDate&date_to=$lastDate");
  try {
    final http.Response response = await http.get(
        Uri.parse(expenseReport +
            "expense_summary_by_exp_head?cid=$cid&user_id=$user_id&user_pass=$user_pass&date_from=$initialDate&date_to=$lastDate"),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var expenseSummary = json.decode(response.body);
    // print(expenseSummary);
    String status = expenseSummary['status'];
    List expSumList = expenseSummary['expSumList'];
    if (status == "Success") {
      return expSumList;
    } else {
      return "error";
    }
  } catch (e) {
    print('notice error message: $e');
  }
  return "error";
}

///*************************************************** *********************************************************///
///********************************Attendance & Meter Reading History *****************************************///
///******************************** ***************************************************************************///
AttendanceMtrHistory() async {
    getboxData();
  print(reportAttMtr + "?cid=$cid&user_id=$user_id&user_pass=$user_pass");
  try {
    final http.Response response = await http.get(
        Uri.parse(
            reportAttMtr + "?cid=$cid&user_id=$user_id&user_pass=$user_pass"),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8'
        });

    var attenMtr = json.decode(response.body);
    // print(attenMtr);
    String status = attenMtr['status'];
    List attenMtrList = attenMtr['meterReadingList'];
    //  print(attenMtrList);
    if (status == "Success") {
      return attenMtrList;
    } else {
      return "error";
    }
  } catch (e) {
    print('notice error message: $e');
  }
  return "error";
}
