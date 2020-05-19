import 'package:flutter/material.dart';
import 'package:subcription_manager/models/myPlan.dart';

class SinglePlan extends StatefulWidget {
  final Plan plan;
  SinglePlan(this.plan);
  @override
  _SinglePlanState createState() => _SinglePlanState(this.plan);
}

class _SinglePlanState extends State<SinglePlan> {
  Plan plan;
  _SinglePlanState(this.plan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar:
      //   //  AppBar(
      //   //   iconTheme: IconThemeData(
      //   //     color:  hexToColor(plan.color) !=
      //   //                                       Color(0xff000000)
      //   //                                   ? Colors.black
      //   //                                   : Colors.white, //change your color here
      //   //   ),
      //   //   title: Text(
      //   //     " Plan ",
      //   //     style: TextStyle(color: Colors.black),
      //   //   ),
      //   //   backgroundColor: hexToColor(plan.color),
      //   // ), //appBar,
      // AppBar(
      //       child: Container(
      //      height: 135,
      //           padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      //           child: Card(
      //              shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //               color: hexToColor(plan.color),
      //             elevation: 2,
      //             child: ListTile(

      //             ),
      //           ),
      //   ),
      // ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 300,
              padding: EdgeInsets.only(top: 1.0, left: 3.0, right: 3.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: hexToColor(plan.color),
                elevation: 2,
                child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: hexToColor(plan.color) != Color(0xff000000)
                                  ? Colors.black
                                  : Colors.white,
                              size: 50,
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          )),
                          Flexible(
                              child: Icon(
                            Icons.more_vert,
                            size: 40,
                            color: hexToColor(plan.color) != Color(0xff000000)
                                ? Colors.black
                                : Colors.white,
                          ))
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            plan.name,
                            style: TextStyle(
                              fontSize: 40,
                              color: hexToColor(plan.color) != Color(0xff000000)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            plan.description,
                            style: TextStyle(
                              fontSize: 20,
                              color: hexToColor(plan.color) != Color(0xff000000)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  plan.currency,
                                  style: TextStyle(
                                    fontSize: 30,
                                    // fontWeight: FontWeight.bold,
                                    color: hexToColor(plan.color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  plan.amount,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: hexToColor(plan.color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Price in standard currency",
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        plan.currency,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plan.amount,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Divider(
                        color: Colors.black,
                        height: 13,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Billing period after",
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        plan.every,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Text(
                        plan.timePeriod,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Divider(
                        color: Colors.black,
                        height: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "First payment",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    plan.firstPayment,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Divider(
                  color: Colors.black,
                  height: 11,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Payment method",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    plan.paymentMethod,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Divider(
                  color: Colors.black,
                  height: 11,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Note",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    plan.note,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(6, 16)));
  }
}
