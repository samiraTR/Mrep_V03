import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mrap7/Pages/Expense/expense_details.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/apiCall.dart';

class ApprovalPage extends StatefulWidget {
  ApprovalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  TextEditingController initialController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController rejectController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final jobRoleCtrl = TextEditingController();
  List<String> ff_type = ["MPO", "FM", "ZM", "RM"];
  List<String> exp_reject_reason=[];

  List newApprovalList = [];
  String role = "";
  String reason = "";
  // initialController = 22 / 12 / 2022;
  var lastDate = 22 / 12 / 2022;
  List<bool> approved = [];

  String exp_approval_url = '';
  String cid = '';
  String user_id = '';
  // String user_id1 = '';
  String user_pass = '';
  String device_id = '';
  var approvalData = [];
  var expString = '';
  var emp_id = '';
  bool isClik=true;
  final databox=Boxes.allData();

  @override
  void initState() {
   
      setState(() {
        exp_approval_url = databox.get('exp_approval_url')!;
        cid = databox.get('CID')!;
        user_id = databox.get('USER_ID')!;
        user_pass = databox.get('PASSWORD')!;
        device_id = databox.get('deviceId')!;
        exp_reject_reason = databox.get('exp_reject_reason')!;

        print("Result is : $exp_reject_reason");
      });
 

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    initialController.dispose();
    lastController.dispose();
    reasonController.dispose();
    rejectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approval"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Date Range:",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                // Text(
                //   "From",
                //   style: TextStyle(fontSize: 16),
                // ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.zero,
                    // width: 120,
                    // height: 50,
                    color: Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                    child: TextField(
                      controller: initialController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final date = await pickDate();

                        if (date == null) {
                          return;
                        } else {
                          setState(
                            () {
                              initialController.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                              // print(dateController.text);

                              // dateTime = date;
                              // DateFormat.yMEd().format(dateTime);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "To",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.zero,
                    // width: 120,
                    // height: 45,
                    color: Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                    child: TextField(
                      controller: lastController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final date = await pickDate();

                        if (date == null) {
                          return;
                        } else {
                          setState(
                            () {
                              lastController.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                              // print(dateController.text);

                              // dateTime = date;
                              // DateFormat.yMEd().format(dateTime);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                // ElevatedButton(onPressed: () {}, child: Text("Show")),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                // DropdownButtonFormField(items: items, onChanged: (onChanged){
                Flexible(
                  // flex: 2,
                  child: Text("FF Type:"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  // flex: 3,
                  child: CustomDropdown(
                    // hintText: ff_type[0],
                    hintText: "Select Job Role",
                    fillColor:
                        Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                    items: ff_type,

                    controller: jobRoleCtrl,
                    onChanged: (p0) {
                      role = p0;
                      print("developer select list $role");
                    },
                  ),
                )
                // })
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    print(exp_approval_url);
                    print(lastController.text);
                    print(initialController.text);
                    print(cid);
                    print(user_id);
                    print(user_pass);
                    print(device_id);

                    if (role != '') {
                       approvalData = await expensapprovel(
                          cid: cid,
                          device_id: device_id,
                          exp_date_from: initialController.text,
                          exp_date_to: lastController.text,
                          exp_url: exp_approval_url,
                          user_id: user_id,
                          user_pass: user_pass,
                          ff_type: role);

                      for (var element in approvalData) {
                        approved.add(false);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please set your FF Type',
                          backgroundColor: Color.fromARGB(255, 236, 81, 60));
                    }

                    setState(() {});

                    print("In My pagfe data :$approvalData");
                  },
                  child: Text(
                    "Show",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Territory",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "FF       ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "      Amount",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          approvalData.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: approvalData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "territory",
                            ),
                            Row(
                              children: [
                                Text(
                                  approvalData[index]["emp_name"],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      if(isClik){
                                        isClik=false;
                                      List expEmpListDetails =
                                          await ExpEmpDetailsList(
                                        cid: cid,
                                        ff_type: role,
                                        user_id: user_id,
                                        user_pass: user_pass,
                                        device_id: device_id,
                                        exp_date_from: initialController.text,
                                        exp_date_to: lastController.text,
                                        exp_url: exp_approval_url,
                                        emp_id: approvalData[index]["emp_id"],
                                      );

                                      Navigator.push(
                                        context,
                                        (MaterialPageRoute(
                                          builder: (context) =>
                                              ExpenseDetailsScreen(
                                            cid: cid,
                                            device_id: device_id,

                                            exp_fromDate:
                                                initialController.text,
                                            exp_toDate: lastController.text,
                                            exp_url: exp_approval_url,
                                            ff_type: role,
                                            user_id: user_id,
                                            user_pass: user_pass,
                                            emp_id: approvalData[index]["emp_id"],

                                            representativeID:
                                                approvalData[index]["emp_id"],
                                            representativeName:
                                                approvalData[index]["emp_name"],

                                            expEmpListDetails:
                                                expEmpListDetails,
                                            mycallback: (value) async {
                                              setState(() {});

                                              if (approvalData
                                                  .contains(value)) {
                                                approvalData = value;
                                              } else if (value == null) {
                                                approvalData = value;
                                              } else {
                                                approvalData =
                                                    await expensapprovel(
                                                        cid: cid,
                                                        device_id: device_id,
                                                        exp_date_from:
                                                            initialController
                                                                .text,
                                                        exp_date_to:
                                                            lastController.text,
                                                        exp_url:
                                                            exp_approval_url,
                                                        user_id: user_id,
                                                        user_pass: user_pass,
                                                        ff_type: role);
                                              }
                                            },

                                            // expenseLog: widget.expenseLog,
                                            // expenseDetails: widget.expenseLog,
                                            // repId: '2580',
                                          ),
                                        )),
                                      );
                                      isClik=true;
                                      }
                                    },
                                    icon: Icon(Icons.double_arrow_sharp))
                              ],
                            ),
                            Text(
                              approvalData[index]["exp_amt_total"].toString(),
                            ),
                            Checkbox(
                              value: approved[index],
                              onChanged: (value) {
                                var y;
                                setState(() {
                                  // e["status"]== true?
                                  approved[index] = value!;
                                  // print("approval ashbe $approved");

                                  if (approved[index] == true) {
                                    newApprovalList.add(approvalData[index]);
                                  } else {
                                    newApprovalList.remove(approvalData[index]);
                                  }
                                  print("approval ashbe $newApprovalList");

                                  // if (approved[index] == true) {
                                  //   newApprovalList.forEach((element) {\\
                                  //     y=element['emp_id'];

                                  //   });

                                  //    if (expString == '') {
                                  //       expString = y;
                                  //     } else  {
                                  //       expString =
                                  //           expString + "|" + y;

                                  //     }
                                  //      print(expString);
                                  // }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "No Data Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
         approvalData.isEmpty?SizedBox.shrink(): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {

                    newApprovalList.isNotEmpty?
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Container(
                              height: MediaQuery.of(context).size.height / 4
                              ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Expanded(child: Text("Rejected By")),
                                  //     Expanded(
                                  //         child: TextField(
                                  //             controller: rejectController)),
                                  //   ],
                                  // ),
                                  Text(
                                    "Reason",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomDropdown(
                    // hintText: ff_type[0],
                    hintText: "Select Job Role",
                    fillColor:
                        Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                    items:exp_reject_reason,

                    controller: reasonController,
                    onChanged: (p0) {
                      reason = p0;
                      print("select Reson print: $reason");
                    },
                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () async {
                                          var y;

                                          var stutus = "REJECT";
                                          if(newApprovalList.isNotEmpty){
                                              newApprovalList.forEach((element) {
                                            y = element['emp_id'];
                                            if (expString == '') {
                                              expString = y;
                                            } else {
                                              expString = expString + "|" + y;
                                            }
                                          });

                                          print(expString);

                                          }

                                        

                                          if (expString != '') {
                                            if (reasonController.text != '') {
                                              var res =
                                                  await expenseApproveAndReject(
                                                      cid: cid,
                                                      device_id: device_id,
                                                      exp_date_from:
                                                          initialController
                                                              .text,
                                                      exp_date_to:
                                                          lastController.text,
                                                      exp_string: expString,
                                                      exp_url: exp_approval_url,
                                                      ff_type: role,
                                                      status: stutus,
                                                      user_id: user_id,
                                                      user_pass: user_pass,
                                                      reasonController:
                                                          reason.toString()
                                                              );

                                              print(res['ret_str']);

                                              if (res['status'] == 'Success') {
                                                print(approvalData);
                                                approvalData.removeWhere((e) =>
                                                    newApprovalList
                                                        .contains(e));
                                                           newApprovalList=[];
                                                           rejectController.clear();

                                                Fluttertoast.showToast(
                                                    msg: res['ret_str'],
                                                    backgroundColor:
                                                        Color.fromARGB(255, 121,
                                                            192, 153));
                                                             for (var element in approvalData) {
                        approved.add(false);
                      }
                                              }

                                              Navigator.pop(context);
                                              setState(() {});
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Please Give Your Reject Reason',
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 236, 81, 60));
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Please Select Item',
                                                backgroundColor: Color.fromARGB(
                                                    255, 236, 81, 60));
                                          }
                                        },
                                        child: Text("Reject")),
                                  )
                                ],
                              ),

                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(50)),
                            ),
                          );
                        }): Fluttertoast.showToast(
                                                msg: 'Please Select Item',
                                                backgroundColor: Color.fromARGB(
                                                    255, 236, 81, 60));
                
                
                  },
                  child: Text("Reject")),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () async {
                  var stutus = "APPROVED";
                  var y;
                  if(newApprovalList.isNotEmpty){
                      newApprovalList.forEach((element) {
                    y = element['emp_id'];
                    if (expString == '') {
                      expString = y;
                    } else {
                      expString = expString + "|" + y;
                    }
                  });
                  if (expString != '') {
                    var res = await expenseApproveAndReject(
                        cid: cid,
                        device_id: device_id,
                        exp_date_from: initialController.text,
                        exp_date_to: lastController.text,
                        exp_string: expString,
                        exp_url: exp_approval_url,
                        ff_type: ff_type,
                        status: stutus,
                        user_id: user_id,
                        user_pass: user_pass,
                        reasonController: '');
                    print(res['ret_str']);

                    setState(() {
                      if (res['status'] == 'Success') {
                        approvalData
                            .removeWhere((e) => newApprovalList.contains(e));
                        Fluttertoast.showToast(
                            msg: res['ret_str'],
                            fontSize: 16,
                            backgroundColor:
                                Color.fromARGB(255, 121, 192, 153));
                                newApprovalList=[];
                                 for (var element in approvalData) {
                        approved.add(false);
                      }
                      }
                    });
                  }

                  }
                

                   else {
                    Fluttertoast.showToast(
                        fontSize: 16,
                        msg: 'Please Select Item',
                        backgroundColor: Color.fromARGB(255, 236, 81, 60));
                  }
                },
                child: Text("Approve"),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015),
        // firstDate: DateTime(dateTime.year, dateTime.month - 2, dateTime.day),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFFE2EFDA),
                surface: Color.fromARGB(255, 37, 199, 78),
              ),
              dialogBackgroundColor: Color.fromARGB(255, 38, 187, 233),
            ),
            child: child!,
          );
        },
      );
}
