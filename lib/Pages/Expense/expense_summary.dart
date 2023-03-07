import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrap7/service/apiCall.dart';

class ExpenseSummaryScreen extends StatefulWidget {
  const ExpenseSummaryScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseSummaryScreen> createState() => _ExpenseSummaryScreenState();
}

class _ExpenseSummaryScreenState extends State<ExpenseSummaryScreen> {
  List expSummaryList = [];
  List ExpenseSummary2 = [
    {"exp_type": "FARE OTHERS", "exp_amt": 80.0},
    {"exp_type": "FARE TRAIN", "exp_amt": 120.0},
    {"exp_type": "FARE LUNCH", "exp_amt": 500.0},
    {"exp_type": "FARE RICKSHAW", "exp_amt": 50.0},
    {"exp_type": "FARE AUTO", "exp_amt": 250.0},
    {"exp_type": "FARE BUS", "exp_amt": 70.0},
    {"exp_type": "DOCTOR LIFT", "exp_amt": 500.0},
    {"exp_type": "STATIONARY", "exp_amt": 900.0},
    {"exp_type": "COURIER BILL", "exp_amt": 50.0},
    {"exp_type": "ANSAR BILL", "exp_amt": 50.0},
    {"exp_type": "NET BILL", "exp_amt": 100.0},
    {"exp_type": "MOTORCYCLE PARKING", "exp_amt": 100.0},
    {"exp_type": "SAMPLE CARRYING", "exp_amt": 100.0},
    {"exp_type": "COMPOSE PHOTOCOPY", "exp_amt": 500.0}
  ];

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  var total;
  @override
  void initState() {
    // TODO: implement initState
    print(toDate.text);
    super.initState();
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Summary"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date Range:",
                  style: TextStyle(fontSize: 16),
                ),
                // Text(
                //   "From",
                //   style: TextStyle(fontSize: 16),
                // ),
                Container(
                  padding: EdgeInsets.zero,
                  width: 120,
                  height: 45,
                  color: Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                  child: TextField(
                    controller: fromDate,
                    decoration: InputDecoration(
                        hintText:
                            toDate.text == "" ? "Select Date" : toDate.text,
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        border: OutlineInputBorder()),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await pickDate();

                      if (date == null) {
                        return;
                      } else {
                        setState(
                          () {
                            fromDate.text = DateFormat.yMd().format(date);
                            // print(dateController.text);

                            // dateTime = date;
                            // DateFormat.yMEd().format(dateTime);
                          },
                        );
                      }
                    },
                  ),
                ),
                Text(
                  "To",
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  width: 120,
                  height: 45,
                  color: Color.fromARGB(255, 138, 201, 149).withOpacity(.3),
                  child: TextField(
                    controller: toDate,
                    decoration: InputDecoration(
                        hintText:
                            toDate.text == "" ? "Select Date" : toDate.text,
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        border: OutlineInputBorder()),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await pickDate();

                      if (date == null) {
                        return;
                      } else {
                        setState(
                          () {
                            toDate.text = DateFormat.yMd().format(date);
                            // print(dateController.text);

                            // dateTime = date;
                            // DateFormat.yMEd().format(dateTime);
                          },
                        );
                      }
                    },
                  ),
                ),
                // ElevatedButton(onPressed: () {}, child: Text("Show")),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      primary: Color.fromARGB(255, 16, 121, 207),
                      onPrimary: Colors.white),
                  onPressed: () async {
                    total=null;
                    expSummaryList =
                        await ExpenseSummary(fromDate.text, toDate.text);

                    expSummaryList.forEach((element) {
                      if (total == null) {
                        total = element["exp_amt"];
                      } else {
                        total += element["exp_amt"];
                      }
                    });
                    print(total);

                    print("lis ashbe $expSummaryList");
                    setState(() {});
                  },
                  child: Text(
                    "Show",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 169, 219, 202),
            contentPadding: EdgeInsets.fromLTRB(5, -3, 5, -3),
            leading: Container(
              height: 30,
              width: 140,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 225, 143),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Expense Head",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            trailing: Container(
              height: 30,
              width: 110,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 225, 143),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Amount",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          expSummaryList.isNotEmpty
              ? Expanded(
                  child: Container(
                    color: Color(0xff56CCF2).withOpacity(.3),
                    child: ListView.builder(
                        itemCount: expSummaryList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            leading: Text(
                              expSummaryList[index]["exp_type"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              expSummaryList[index]["exp_amt"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                  ),
                )
              : toDate.text == ""
                  ? Text(
                      "Select Date and Click show button",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "No Data Found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
          expSummaryList.isEmpty
              ? Spacer()
              : ListTile(
                  tileColor: Color.fromARGB(255, 169, 219, 202),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    total == null ? "0" : total.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
