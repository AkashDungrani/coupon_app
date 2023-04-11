import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/db_helper.dart';
import '../../models/coupon_model.dart';
import '../../models/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late  Future<dynamic> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    // await CouponDBHelper.couponDBHelper.initDB();
    data = CouponDBHelper.couponDBHelper.fetchAllRecords();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Coupon"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'coupon_page');
            },
            icon: Icon(Icons.details),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/pinaple.png"))),
              ),
            ),
            ElevatedButton(
              child: Text("Apply Coupon"),
              onPressed: () {},
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                future: data,
                builder: (BuildContext context, AsyncSnapshot snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Error : ${snapShot.error}"),
                      ),
                    );
                  } else if (snapShot.hasData) {
                    List<CouponDB> data = snapShot.data;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) => Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[i].name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "Quantity : ${data[i].quantity} ",
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                          trailing: OutlinedButton(
                              onPressed: () async {
                                if (data[i].quantity > 0) {
                                  // CouponDBHelper.couponDBHelper.updateRecord(
                                  //     id: i, quantity: data[i].quantity);
                                  // Globals.snackBar(
                                  //     context: context,
                                  //     message: "Coupon Apply Successfully",
                                  //     color: Colors.green,
                                  //     icon: Icons.confirmation_num_outlined);

                                  setState(() async {
                                    CouponDBHelper.couponDBHelper.updateRecord(
                                        id: i, quantity: data[i].quantity);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Coupon Claimed"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    data = await CouponDBHelper.couponDBHelper
                                        .fetchAllRecords();
                                  });
                                } else {
                                  setState(() {
                                    Globals.snackBar(
                                        context: context,
                                        message: "Coupon is Not available",
                                        color: Colors.red,
                                        icon: Icons.access_alarm);
                                  });
                                }
                              },
                              child: const Text("Apply")),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
