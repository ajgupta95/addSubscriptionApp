import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subcription_manager/models/myPlan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:subcription_manager/screens/singlePlan.dart';
import 'package:subcription_manager/screens/planDetail.dart';
import 'package:subcription_manager/utils/databaseHelper.dart';

class PlanList extends StatefulWidget {
  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Plan> planList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (planList == null) {
      planList = List<Plan>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subcriptions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: getContactListView(),
      backgroundColor: Colors.white,
      //   floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.black,

      //     onPressed: (){
      //       print('want to add');
      //      Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return PlanDetail( plan);
      // }));

      //     },
      //      tooltip: 'Add Contact',
      //     child: Icon(Icons.add),

      //     ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        height: 60,
        items: <Widget>[
          Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.filter_list, size: 30, color: Colors.white),
          Icon(Icons.sort, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.bounceInOut,
        index: 1,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          print('Current index is $index');
          // setState(() {
          //   _page=index;
          // });
          if (index == 1) {
            navigateToDetail(
                Plan('USD', '', '', '', '', 'MONTH', '', '', '', '', '', ''));
            //        Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return PlanDetail( plan);
            //  }));

          }
        },
      ),
    );
  }

  ListView getContactListView() {
    //	TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Container(
            height: 135,
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: hexToColor(this.planList[position].color),
              elevation: 2,
              child: ListTile(
                // leading :CircleAvatar(
                //  backgroundColor: getPriorityColor(this.planList[position].priority),
                //  child: getPriorityIcon(this.contactList[position].priority),
                // ),
                // title: Text(this.planList[position].name,style: TextStyle(
                //   fontSize: 25, fontWeight: FontWeight.bold,
                // )),
                // subtitle: Text(this.planList[position].description,
                // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                title: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            child: Text(this.planList[position].name,
                                style: TextStyle(
                                  color: hexToColor(
                                              this.planList[position].color) !=
                                          Color(0xff000000)
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              this.planList[position].currency,
                              style: TextStyle(
                                color:
                                    hexToColor(this.planList[position].color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              this.planList[position].amount,
                              style: TextStyle(
                                color:
                                    hexToColor(this.planList[position].color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )),
                      ]),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(this.planList[position].description,
                            style: TextStyle(
                              color:
                                  hexToColor(this.planList[position].color) !=
                                          Color(0xff000000)
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(this.planList[position].amount,
                                  style: TextStyle(
                                    color: hexToColor(this
                                                .planList[position]
                                                .color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(width: 2),
                              Text('/',
                                  style: TextStyle(
                                    color: hexToColor(this
                                                .planList[position]
                                                .color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(width: 2),
                              Text(this.planList[position].every,
                                  style: TextStyle(
                                    color: hexToColor(this
                                                .planList[position]
                                                .color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(width: 2),
                              Text(this.planList[position].timePeriod,
                                  style: TextStyle(
                                    color: hexToColor(this
                                                .planList[position]
                                                .color) !=
                                            Color(0xff000000)
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ]),
                ),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, planList[position]);
                  },
                ),
                // trailing: Column(

                //  // Text(this.planList)
                //  children: <Widget>[
                //    Text(this.planList[position].currency,style: TextStyle(
                //      fontSize:20,
                //    ),),
                //    Text(this.planList[position].amount,style: TextStyle(
                //      fontSize:20,
                //    ),),
                //  ],
                // ),
                onTap: () {
                  print("ListTile Tapped");
                  navigateToSinglePlan(this.planList[position]);
                },
              ),
            ),
          );
        });
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(6, 16)));
  }

  void navigateToDetail(Plan plan) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlanDetail(plan);
    }));

    if (result == true) {
      updateListView();
      print('here');
    }
  }

  void navigateToSinglePlan(Plan plan) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SinglePlan(plan);
    }));

    if (result == true) {
      updateListView();
      print('here');
    }
  }

  void _delete(BuildContext context, Plan plan) async {
    int result = await databaseHelper.deletePlan(plan.id);
    if (result != 0) {
      _showSnackBar(context, 'Subscription is Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Plan>> planListFuture = databaseHelper.getPlanList();
      print(planListFuture.then((value) => print(value)));

      planListFuture.then((planList) {
        setState(() {
          // List yourPlan=planList;

          this.planList = planList;
          this.count = planList.length;
        });
        print(planList.first.toMap());
      });
    });
  }
}
