import 'package:flutter/material.dart';
import 'package:mrap7/local_storage/boxes.dart';
// import 'package:mrap7/models/area_page_model.dart';
import 'package:mrap7/service/apiCall.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({Key? key}) : super(key: key);

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  String cid = '';
  String userId = '';
  String userPassword = '';
  String areaPageUrl = '';
  String syncUrl = '';
  bool _isLoading = false;
  final databox= Boxes.allData();

  @override
  void initState() {
    super.initState();
    

      setState(() {
        cid =databox.get("CID")!;
        userId =databox.get("USER_ID")!;
        areaPageUrl =databox.get('user_area_url')!;
        userPassword =databox.get("PASSWORD")!;
        syncUrl =databox.get("sync_url")!;
      });
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getAreaPage(areaPageUrl, cid, userId, userPassword),
          builder: ((context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('${snapshot.error} occured');
              } else if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return StatefulBuilder(
                          builder: (BuildContext context, setState1) {
                        return InkWell(
                          onTap: () async {
                            setState1(() {
                              _isLoading = true;
                            });
                            bool response = await getAreaBaseClient(
                                context,
                                syncUrl,
                                cid,
                                userId,
                                userPassword,
                                snapshot.data![index]['area_id']);

                            setState1(() {
                              _isLoading = response;
                            });
                          },
                          child: Card(
                            // color: Colors.blue.withOpacity(.03),
                            elevation: 2,
                            child: SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![index]['area_name'],
                                      ),
                                    ),
                                    _isLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              setState1(() {
                                                _isLoading = true;
                                              });
                                              bool response =
                                                  await getAreaBaseClient(
                                                      context,
                                                      syncUrl,
                                                      cid,
                                                      userId,
                                                      userPassword,
                                                      snapshot.data![index]
                                                          ['area_id']);

                                              setState1(() {
                                                _isLoading = response;
                                              });
                                            },
                                            icon: const Icon(
                                                Icons.arrow_forward_ios_sharp),
                                          ),
                                  ],
                                )),
                          ),
                        );
                      });
                    });
              }
            } else {}
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
