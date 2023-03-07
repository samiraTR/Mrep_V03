// ignore_for_file: public_member_api_docs, sort_constructors_first, must_call_super
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:mrap7/service/apiCall.dart';

// ignore: must_be_immutable
class ExpenseDetailsScreen extends StatefulWidget {
  String exp_fromDate;
  String exp_toDate;
  String cid;
  String user_id;
  String user_pass;
  String device_id;
  String ff_type;
  String emp_id;
  String exp_url;
  String representativeID;
  String representativeName;
  List expEmpListDetails;
  Function? mycallback;

  ExpenseDetailsScreen({
    Key? key,
    required this.exp_fromDate,
    required this.exp_toDate,
    required this.cid,
    required this.user_id,
    required this.user_pass,
    required this.device_id,
    required this.ff_type,
    required this.emp_id,
    required this.exp_url,
    required this.representativeID,
    required this.representativeName,
    required this.expEmpListDetails,
    this.mycallback,
  }) : super(key: key);

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController rejectController = TextEditingController();
  var selected = false;
  // bool isclic = false;
  List<bool> isSelect = [];
  List<bool> isclic = [];
  List selectedDetails = [];
  var refNum;

  String emp_id_exp_sl_list = '';
  List<String> exp_reject_reason = [];
  String reason = "";
  final boxdata=Boxes.allData();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.expEmpListDetails.length; i++) {
      isSelect.add(false);
      isclic.add(false);
    }

    
      setState(() {
        exp_reject_reason = boxdata.get('exp_reject_reason')!;

        print("Result is : $exp_reject_reason");
      });
    
  }

  @override
  void dispose() {
    reasonController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // apicall() async {
  //   // expEmpListDetails = await ExpEmpDetailsList(
  //   //   cid: widget.cid,
  //   //   ff_type: widget.ff_type,
  //   //   user_id: widget.user_id,
  //   //   user_pass: widget.user_pass,
  //   //   device_id: widget.device_id,
  //   //   exp_date_from: widget.exp_fromDate,
  //   //   exp_date_to: widget.exp_toDate,
  //   //   exp_url: widget.exp_url,
  //   //   emp_id: widget.emp_id,
  //   // );

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Representative Name: ${widget.representativeName}",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Representative ID: ${widget.representativeID}",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                )),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.expEmpListDetails.length,
                itemBuilder: (context, index) {
                  List ExpenseDetail =
                      widget.expEmpListDetails[index]["expDetList"];

                  print(ExpenseDetail);
                  return
                      // Text(expenseLog["expList"][index]["exp_date"])
                      Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
                      // height: 180,
                      child: Card(
                        elevation: 2,
                        color: Colors.lightBlue[100],
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.platform,
                          // onExpansionChanged: (value) {
                          //   print("expansion Chnaged $value");
                          //   setState(() {
                          //     selected = value;
                          //   });
                          //   // if (value == true) {

                          //   // }else{
                          //   //   selected = c
                          //   // }
                          // },
                          leading: Checkbox(
                            value: isSelect[index],
                            onChanged: (value) {
                              setState(() {
                                isSelect[index] = value!;
                                if (isSelect[index] == true) {
                                  selectedDetails
                                      .add(widget.expEmpListDetails[index]);
                                } else {
                                  selectedDetails
                                      .remove(widget.expEmpListDetails[index]);
                                }
                                print("Slelcted List:::$selectedDetails");
                              });
                            },
                          ),
                          title: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.green),
                                    color: Colors.greenAccent[100]),
                                child: Center(
                                  child: Text(
                                    "Date: ${widget.expEmpListDetails[index]["exp_date"]}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green),
                                  color: Colors.greenAccent[100]),
                              child: Center(
                                child: Text(
                                  "Total: ${widget.expEmpListDetails[index]["exp_amt_total"]}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),

                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DESCRIPTION",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 150, 55, 42),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "AMOUNT",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 150, 55, 42),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: ExpenseDetail.length,
                                itemBuilder: (context, index) {
                                  // print(ExpenseDetail.length);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(ExpenseDetail[index]["exp_type"]),
                                        Text(
                                            "${ExpenseDetail[index]["exp_amt"]}"),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          widget.expEmpListDetails.isEmpty
              ? SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          if (selectedDetails.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            hintText: "Select Reason",
                                            fillColor: Color.fromARGB(
                                                    255, 138, 201, 149)
                                                .withOpacity(.3),
                                            items: exp_reject_reason,

                                            controller: reasonController,
                                            onChanged: (p0) {
                                              reason = p0;
                                              print(
                                                  "select Reson print: $reason");
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
                                                  String status = 'REJECT';
                                                  var y;
                                                  if (selectedDetails
                                                      .isNotEmpty) {
                                                    selectedDetails
                                                        .forEach((element) {
                                                      y = element['ref'];
                                                      if (emp_id_exp_sl_list ==
                                                          '') {
                                                        emp_id_exp_sl_list = y;
                                                      } else {
                                                        emp_id_exp_sl_list =
                                                            emp_id_exp_sl_list +
                                                                '|' +
                                                                y;
                                                      }
                                                    });
                                                    print(
                                                        "seleted details $selectedDetails");
                                                  } else {
                                                    print(
                                                        "Selected Details is Empty:|$selectedDetails");
                                                  }

                                                  if (emp_id_exp_sl_list !=
                                                      '') {
                                                    print(
                                                        'SElected emp RefList:;; $emp_id_exp_sl_list');
                                                    if (reasonController.text !=
                                                        '') {
                                                      var respons = await expenseEmpApproveAndRejectDetels(
                                                          cid: widget.cid,
                                                          device_id:
                                                              widget.device_id,
                                                          emp_id: widget.emp_id,
                                                          exp_date_from: widget
                                                              .exp_fromDate,
                                                          exp_date_to:
                                                              widget.exp_toDate,
                                                          exp_url:
                                                              widget.exp_url,
                                                          ff_type:
                                                              widget.ff_type,
                                                          status: status,
                                                          user_id:
                                                              widget.user_id,
                                                          user_pass:
                                                              widget.user_pass,
                                                          emp_id_exp_sl_list:
                                                              emp_id_exp_sl_list,
                                                          reasonController:
                                                              reason
                                                                  .toString());

                                                      print(respons['ret_str']);

                                                      if (respons['status'] ==
                                                          'Success') {
                                                        widget.expEmpListDetails
                                                            .removeWhere((element) =>
                                                                selectedDetails
                                                                    .contains(
                                                                        element));
                                                        reasonController
                                                            .clear();
                                                        for (var i = 0;
                                                            i <=
                                                                widget
                                                                    .expEmpListDetails
                                                                    .length;
                                                            i++) {
                                                          isSelect.add(false);
                                                          isclic.add(false);
                                                        }
                                                        selectedDetails = [];
                                                        Fluttertoast.showToast(
                                                            msg: respons[
                                                                'ret_str'],
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    192,
                                                                    153));
                                                      }

                                                      // for (var e in selectedDetails) {
                                                      //   refNum = e["ref"];
                                                      //   // print(e["ref"]);
                                                      // }
                                                      // if (widget.expenseDetails
                                                      //     .contains(refNum)) {
                                                      //   isclic = true;
                                                      // }
                                                      y = '';

                                                      print(
                                                          "rejected Data is $y");

                                                      Navigator.pop(context);
                                                      widget.mycallback!(widget
                                                          .expEmpListDetails);

                                                      setState(() {});
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Please Give Your Reject Reason',
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  236,
                                                                  81,
                                                                  60));
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Please Select Item',
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                236, 81, 60));
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
                                });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please Select Item',
                                backgroundColor:
                                    Color.fromARGB(255, 236, 81, 60));
                          }
                        },
                        child: Text("Reject")),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        String status = 'APPROVED';

                        print("SeletedDetails is $selectedDetails");
                        if (selectedDetails.isNotEmpty) {
                          var y;

                          selectedDetails.forEach((element) {
                            y = element['ref'];
                            if (emp_id_exp_sl_list == '') {
                              emp_id_exp_sl_list = y;
                            } else {
                              emp_id_exp_sl_list = emp_id_exp_sl_list + '|' + y;
                            }
                          });
                          if (emp_id_exp_sl_list != '') {
                            var respons =
                                await expenseEmpApproveAndRejectDetels(
                                    cid: widget.cid,
                                    device_id: widget.device_id,
                                    emp_id: widget.emp_id,
                                    exp_date_from: widget.exp_fromDate,
                                    exp_date_to: widget.exp_toDate,
                                    exp_url: widget.exp_url,
                                    ff_type: widget.ff_type,
                                    status: status,
                                    user_id: widget.user_id,
                                    user_pass: widget.user_pass,
                                    emp_id_exp_sl_list: emp_id_exp_sl_list,
                                    reasonController: '');

                            print(respons['ret_str']);

                            if (respons['status'] == 'Success') {
                              widget.expEmpListDetails.removeWhere((element) =>
                                  selectedDetails.contains(element));
                              Fluttertoast.showToast(
                                  msg: respons['ret_str'],
                                  backgroundColor:
                                      Color.fromARGB(255, 121, 192, 153));
                              selectedDetails = [];
                              for (var i = 0;
                                  i <= widget.expEmpListDetails.length;
                                  i++) {
                                setState(() {
                                  isSelect.add(false);
                                  isclic.add(false);
                                });
                              }
                            }

                            // for (var e in selectedDetails) {
                            //   refNum = e["ref"];
                            //   // print(e["ref"]);
                            // }
                            // if (widget.expenseDetails
                            //     .contains(refNum)) {
                            //   isclic = true;
                            // }

                            widget.mycallback!(widget.expEmpListDetails);

                            setState(() {});
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please Select Item',
                              backgroundColor:
                                  Color.fromARGB(255, 236, 81, 60));
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
}
