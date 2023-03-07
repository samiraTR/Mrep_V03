// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrap7/Pages/DCR_section/dcr_gift_sample_PPM_page.dart';

import 'package:mrap7/Widgets/customerListWidget.dart';
import 'package:mrap7/local_storage/boxes.dart';
import 'package:url_launcher/link.dart';

// ignore: must_be_immutable
class DcrListPage extends StatefulWidget {
  List dcrDataList;

  DcrListPage({Key? key, required this.dcrDataList}) : super(key: key);

  @override
  State<DcrListPage> createState() => _DcrListPageState();
}

class _DcrListPageState extends State<DcrListPage> {
  Box? box;
  String doctor_url = '';
  String cid = '';
  String userId = '';
  String userPassword = '';
  bool docFlag = false;

  final TextEditingController searchController = TextEditingController();
  List foundUsers = [];
  int _counter = 0;
  final mydata=Boxes.allData();

  @override
  void initState() {
    // SharedPreferences.getInstance().then((prefs) {
      setState(() {
        cid = mydata.get("CID")!;
      userId = mydata.get("USER_ID")!;
      userPassword = mydata.get("PASSWORD")!;
      doctor_url = mydata.get("doctor_url")!;
      docFlag = mydata.get("doc_flag") ?? false;
      });
      // print('$doctor_url?cid=$cid&rep_id=$userId&rep_pass=$userPassword');
      if (mydata.get("_dcrcounter") != null) {
        int? a = mydata.get("_dcrcounter");

        setState(() {
          _counter = a!;
        });
      }
    // });
    foundUsers = widget.dcrDataList;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    
      mydata.put('_dcrcounter', _counter);
   

    setState(() {});
  }

  void runFilter(String enteredKeyword) {
    foundUsers = widget.dcrDataList;
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = foundUsers;
      // print(results);
    } else {
      var starts = foundUsers
          .where((s) => s['doc_name']
              .toLowerCase()
              .startsWith(enteredKeyword.toLowerCase()))
          .toList();

      var contains = foundUsers
          .where((s) =>
              s['doc_name']
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) &&
              !s['doc_name']
                  .toLowerCase()
                  .startsWith(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) =>
            a['doc_name'].toLowerCase().compareTo(b['doc_name'].toLowerCase()));

      results = [...starts, ...contains];
    }

    // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: const Text('Doctor list'),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 27, 56, 34),
            fontWeight: FontWeight.w500,
            fontSize: 20),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 138, 201, 149)),
              child: Column(
                children: [
                  Image.asset('assets/images/mRep7_logo.png'),
                  // Expanded(
                  //   child: Text(
                  //     '${widget.clientName}',
                  //     // 'Chemist: ADEE MEDICINE CORNER(6777724244)',
                  //     style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // Expanded(
                  //     child: Text(
                  //   widget.clientId,
                  //   style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold),
                  // ))
                ],
              ),
            ),
            docFlag
                ? Link(
                    uri: Uri.parse(
                        '$doctor_url/doctor_add?cid=$cid&rep_id=$userId&rep_pass=$userPassword'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return ListTile(
                        onTap: openLink,
                        leading: const Icon(Icons.person_add,
                            color: Colors.blueAccent),
                        title: const Text(
                          'Doctor',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 15, 53, 85)),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) => runFilter(value),
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ' Search',
                  suffixIcon: searchController.text.isEmpty &&
                          searchController.text == ''
                      ? const Icon(Icons.search)
                      : IconButton(
                          onPressed: () {
                            searchController.clear();
                            runFilter('');
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                            // size: 28,
                          ),
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: foundUsers.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchController.text.isNotEmpty
                        ? foundUsers.length
                        : widget.dcrDataList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext itemBuilder, index) {
                      return GestureDetector(
                        onTap: () {
                          _incrementCounter();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DcrGiftSamplePpmPage(
                                        ck: '',
                                        dcrKey: 0,
                                        uniqueId: _counter,
                                        draftOrderItem: [],
                                        docName: foundUsers[index]['doc_name'],
                                        docId: foundUsers[index]['doc_id'],
                                        areaName: foundUsers[index]
                                            ['area_name'],
                                        areaId: foundUsers[index]['area_id'],
                                        address: foundUsers[index]['address'],
                                      )));
                        },
                        child: CustomerListCardWidget(
                            clientName: foundUsers[index]['doc_name'] +
                                '(${foundUsers[index]['doc_id']})',
                            base: foundUsers[index]['area_name'] +
                                '(${foundUsers[index]['area_id']})',
                            marketName: foundUsers[index]['address'],
                            outstanding: ''),
                      );
                    })
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }
}
