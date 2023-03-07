import 'package:flutter/material.dart';
import 'package:mrap7/Pages/Expense/approval.dart';
import 'package:mrap7/Pages/Expense/attendanceMtrHistory.dart';
import 'package:mrap7/Pages/Expense/expense_draft.dart';
import 'package:mrap7/Pages/Expense/expense_entry.dart';
import 'package:mrap7/Pages/Expense/expense_log.dart';
import 'package:mrap7/Pages/Expense/expense_summary.dart';
import 'package:mrap7/Pages/attendance_page.dart';
import 'package:mrap7/Pages/homePage.dart';
import 'package:mrap7/Widgets/custombutton.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/apiCall.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  String userId = "";
  String userName = "";
  String user_pass = "";
  String expApproval = "";
  String startTime = "";
  bool exp_approval_flag = false;
  var prefix;
  var prefix2;
  bool isClick=true;
  final databox=Boxes.allData();
  @override
  void initState() {
    super.initState();

      setState(() {
        userId = databox.get("CID") ?? "";
        userName = databox.get("USER_ID") ?? "";
        user_pass = databox.get("PASSWORD") ?? "";
        expApproval = databox.get("exp_approval_url") ?? "";
        startTime = databox.get("startTime") ?? '';
        exp_approval_flag = databox.get("exp_approval_flag")!;

        print("Expense Flage:$exp_approval_flag");
        // print("start time ashbe $startTime");
        var parts = startTime.split(' ');
        prefix = parts[0].trim();
        // print(prefix);
        String dt = DateTime.now().toString();
        var parts2 = dt.split(' ');
        prefix2 = parts2[0].trim();
        // print("dateTime ashbe$prefix2");
   
    });
  }

  List newList = [];
  // List<ExpenseModel> expenseDraft = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Expense"),
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                          userPassword: user_pass,
                          userName: userName,
                          user_id: userId)),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                prefix2 != prefix
                    ?
                    // startTime == ""
                    //     ?
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Please Give Meter Reading First",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    // : Text("ok")
                    : Text(""),

                //******************************************************************************************************/
                //*******************************************************************************************************/
                //**************************Attendance & Meter Reading***************************************************/
                //*******************************************************************************************************/
                Container(
                  height: MediaQuery.of(context).size.height / 6.7,
                  color: Color(0xFFDDEBF7),
                  child: Row(
                    children: [
                      Expanded(
                        child: customBuildButton(
                          onClick: () async {
                            // newList = await expenseEntry();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendanceScreen(
                                    // expenseTypelist: newList,
                                    // callback: () {}, tempExpList: [],
                                    // expDraftDate: '',
                                    // tempExpenseList: [],
                                    ),
                              ),
                            );
                          },
                          title: "Attendance & \nMeter Reading",
                          sizeWidth: MediaQuery.of(context).size.width,
                          inputColor: Color(0xff56CCF2).withOpacity(.3),
                          icon: Icons.chrome_reader_mode_sharp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                //******************************************************************************************************/
                //*******************************************************************************************************/
                //**************************NEW EXPENSE ENTRY***************************************************/
                //*******************************************************************************************************/
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  color: Color(0xFFE2EFDA),
                  child: Column(
                    children: [
                      Expanded(
                        child: customBuildButton(
                          onClick: () async {
                           
                            if(isClick){
                           

                          isClick = false;
                         
                               newList = await expenseEntry();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpenseEntry(
                                  expenseTypelist: newList,
                                  callback: () {},
                                  tempExpList: [],
                                  expDraftDate: '',
                                ),
                              ),
                            );
                            isClick = true;
                            print("clicked is:$isClick");
                            }
                           
                          },
                          // color: Colors.green,
                          title: "Expense Entry",
                          sizeWidth: MediaQuery.of(context).size.width,

                          icon: Icons.draw_rounded,
                          inputColor: Color(0xff56CCF2).withOpacity(.3),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      // //******************************************************************************************************/
                      //*******************************************************************************************************/
                      //**************************DRAFT***************************************************/
                      //*******************************************************************************************************/
                      Row(
                        children: [
                          Expanded(
                            child: customBuildButton(
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExpenseDraft(temp: {})));
                              },
                              title: "Draft",
                              sizeWidth: 300,
                              icon: Icons.pending_actions_sharp,
                              inputColor: Colors.white,
                            ),
                          ),
                          // //******************************************************************************************************/
                          // //*******************************************************************************************************/
                          // //**************************MY EXPENSE LOG***************************************************/
                          // //*******************************************************************************************************/
                          Expanded(
                            child: customBuildButton(
                              onClick: () async {
                                
                                
                               
                                // print(ExpenseLog);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseLogScreen(
                                     
                                    ),
                                  ),
                                );
                              
                               
                              },
                              title: "Expense Log",
                              sizeWidth: 300,
                              inputColor: Colors.white,
                              icon: Icons.receipt_long_sharp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // //******************************************************************************************************/
                // //*******************************************************************************************************/
                // //**************************APPROVAL***************************************************/
                // //*******************************************************************************************************/

                Container(
                  height: MediaQuery.of(context).size.height / 2.3,
                  color: Color(0xFFDDEBF7),
                  child: Column(
                    children: [
                      exp_approval_flag == true
                          ? Expanded(
                              child: customBuildButton(
                                onClick: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ApprovalPage(),
                                    ),
                                  );
                                },
                                title: "Approval",
                                sizeWidth: MediaQuery.of(context).size.width,
                                icon: Icons.approval,
                                inputColor: Color(0xff70BA85).withOpacity(.3),
                              ),
                            )
                          :
                          // SizedBox.shrink(),
                          SizedBox(
                              height: 2,
                            ),
                      Row(
                        children: [
                          Expanded(
                            child: customBuildButton(
                              icon: Icons.summarize,
                              inputColor: Color(0xff70BA85).withOpacity(.3),
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExpenseSummaryScreen()));
                              },
                              sizeWidth: 300,
                              title: 'Expense Summary',
                            ),
                          ),
                          Expanded(
                            child: customBuildButton(
                              icon: Icons.summarize,
                              inputColor: Color(0xff70BA85).withOpacity(.3),
                              onClick: () async {
                               
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AttendanceMeterHistory(
                                           
                                            )));
                              },
                              sizeWidth: 300,
                              title: 'Attendance-MTR Reading Log',
                            ),
                          ),

                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: Text("Approval"),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        child: customBuildButton(
                          onClick: () async {
                            var url =
                                '$expApproval/expense_history_list?cid=$cid&user_id=$user_id&user_pass=$user_pass';
                            print(url);
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          title: "Report",
                          sizeWidth: MediaQuery.of(context).size.width,
                          icon: Icons.document_scanner,
                          inputColor: Color(0xff70BA85).withOpacity(.3),
                        ),
                      ),
                      SizedBox(
                          // height:110
                          height: exp_approval_flag == true ? 5 : 110),
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
}
