// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mrap7/service/apiCall.dart';

// ignore: must_be_immutable
class ExpenseLogScreen extends StatefulWidget {
 
  ExpenseLogScreen({
    Key? key,

  }) : super(key: key);

  @override
  State<ExpenseLogScreen> createState() => _ExpenseLogScreenState();
}

class _ExpenseLogScreenState extends State<ExpenseLogScreen> {
  TextEditingController dateExp = TextEditingController();
  List ExpenseLog=[];

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_){

    getdata();

  });
  }
  getdata()async{
     var expReport = await ExpenseReport();
       setState(() {
       ExpenseLog = expReport["expList"];
         
       });

  }

  IconAprrovalColor(x) {
    if (x == "Submitted") {
      return Color.fromARGB(255, 168, 155, 33);
    } else if (x == "APPROVED") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
  @override
  void dispose() {
     dateExp.dispose();
    // TODO: implement dispose
    super.dispose();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Log"),
        centerTitle: true,
      ),
      body:ExpenseLog.isEmpty?Center(child: CircularProgressIndicator()): Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount:ExpenseLog.length,
                itemBuilder: (context, index) {
                  List ExpenseDetail =ExpenseLog[index]["expDetList"];

                  // print(ExpenseDetail);
                  return
                      // Text(ExpenseLog["expList"][index]["exp_date"])
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
                                    "Date: ${ExpenseLog[index]["exp_date"]}",
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
                                  "Total: ${ExpenseLog[index]["exp_amt_total"]}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: IconAprrovalColor(
                                     ExpenseLog[index]["status"]),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                 ExpenseLog[index]["status"] + "   ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: IconAprrovalColor(
                                         ExpenseLog[index]["status"])),
                                )
                              ],
                            ),
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
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
// Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                               child: ListTile(
//                                 leading: Container(
//                                   height: 50,
//                                   width: 85,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.greenAccent[100]),
//                                   child: Center(
//                                     child: Text(
//                                       "Date: ${widget.ExpenseLog[index]["exp_date"]}",
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   ),
//                                 ),
//                                 trailing: Container(
//                                   height: 50,
//                                   width: 85,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.greenAccent[100]),
//                                   child: Center(
//                                     child: Text(
//                                       "Total: ${widget.ExpenseLog[index]["exp_amt_total"]}",
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // Row(
//                             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //   children: [
//                             //     Container(
//                             //       child: Text(ExpenseLog[index]["exp_date"]),
//                             //     ),
//                             //     Container(
//                             //       child:
//                             //           Text(expenseLog[index]["exp_amt_total"]),
//                             //     ),
//                             //   ],
//                             // ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "DESCRIPTION",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Color.fromARGB(255, 150, 55, 42),
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Text(
//                                     "AMOUNT",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color:
//                                             Color.fromARGB(255, 151, 67, 230),
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: ListView.builder(
//                                   // shrinkWrap: true,
//                                   // physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: ExpenseDetail.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           12, 6, 12, 0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                               ExpenseDetail[index]["exp_type"]),
//                                           Text(
//                                               "${ExpenseDetail[index]["exp_amt"]}"),
//                                           // Text(expenseLog[index]["expDetList"]
//                                           // [index]["exp_type"])
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                             )
//                           ],
//                         ),
