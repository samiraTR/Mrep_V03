import 'package:flutter/material.dart';
import 'package:mrap7/service/apiCall.dart';

class NoticeScreen extends StatefulWidget {
  NoticeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List noticelist = [];
  @override
  void initState() {

    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_){
    getApi();
  });
  }

  getApi() async {
    noticelist = await noticeEvent();
    setState(() {
      
    });
    print("list ${noticelist}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice"),
        centerTitle: true,
      ),
      body:noticelist.isEmpty?Center(child: CircularProgressIndicator(),): Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: noticelist.length,
                itemBuilder: (context, index) {
                  // noticeDate =noticelist[index]["notice_date"]
                  //     .replaceAll(" ", "\n\n");
                  var str = noticelist[index]["notice_date"];
                  var parts = str.split(' ');
                  var prefix = parts[0].trim();
                  var prefixTime = parts[1].trim();
                  var prefixSplit = prefix.split("-");
                  var lastPart = prefixSplit[2];
                  var secPart = prefixSplit[1];
                  var firstPart = prefixSplit[0];
                  print(prefixSplit[2]);

                  // prefix: "date"
                  // var date =
                  //     parts.sublist(1).join(':').trim(); // date: "'2019:04:01'"
                  return Card(
                    elevation: 6,
                    child: Container(
                      color: Color.fromARGB(255, 189, 247, 237),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 0, 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromARGB(255, 241, 52, 38),
                                    Color.fromARGB(255, 209, 143, 44),
                                  ],
                                  // colors: [
                                  //   Color.fromARGB(255, 189, 247, 237),
                                  //   Color.fromARGB(255, 212, 245, 190)
                                  // ],
                                ),
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 8, 0, 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lastPart,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          secPart,
                                          // + "," + firstPart
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          firstPart,
                                          // + "," + firstPart
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prefixTime,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    noticelist[index]["notice"],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
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
