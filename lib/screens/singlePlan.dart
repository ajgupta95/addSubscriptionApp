import 'package:flutter/material.dart';
import 'package:subcription_manager/models/myPlan.dart';
import 'package:subcription_manager/utils/databaseHelper.dart';
import 'package:subcription_manager/screens/planDetail.dart';



class Constants {
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[
    Edit,
    Delete,
  ];
}

class SinglePlan extends StatefulWidget {
  final Plan plan;


  SinglePlan(this.plan);
  @override
  _SinglePlanState createState() => _SinglePlanState(this.plan);
}

class _SinglePlanState extends State<SinglePlan> {
  Plan plan;
      DatabaseHelper databaseHelper = DatabaseHelper();

  // final List<MenuItem> menuItems = [
  //   MenuItem("Edit", Icons.edit),
  //   MenuItem("Delete", Icons.delete),
  // ];
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
        child: ListView(
                  children:<Widget>[Column(
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
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            )),
                            PopupMenuButton(
                            
                              icon: Icon(
                                Icons.more_vert,
                                color: hexToColor(plan.color) != Color(0xff000000)
                                    ? Colors.black
                                    : Colors.white,
                                size: 40,
                              ),
                              onSelected: choiceAction,
                              itemBuilder: (BuildContext context) {
                                return Constants.choices.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                              // onSelected: chooseAction,
                            ),
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
                        SizedBox(width: 10),
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
                      dateConverter(),
                     // plan.firstPayment.substring(0,10),
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
               
                
               
              SizedBox(
                height:40
              ),
            ],
          ),], 
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(6, 16)));
  }

  void choiceAction(String choice){
    if(choice == Constants.Edit){
      print('Edit');
      navigateToDetail(plan ,"Edit Subscription");
    }else if(choice == Constants.Delete){
      print('Delete');
       _showAlertDialog('Status', 'Please confirm');




    }
  }
  
  void _delete(BuildContext context, Plan plan) async {
    int result = await databaseHelper.deletePlan(plan.id);
    if (result != 0) {
      print('deleteted');
            Navigator.pop(context, true);

      // _showSnackBar(context, 'Subscription is Deleted Successfully');
      // updateListView();
    }
              //  Navigator.pop(context, true);

  }
    void navigateToDetail(Plan plan,String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlanDetail(plan,title);
    }));

    if (result == true) {
      print('updated');
     // updateListView();
      print('here');
    }
  }
  String dateConverter(){
    print(plan.firstPayment);
    print('herehere');
    if(plan.firstPayment=="null"||plan.firstPayment==''){
          print('herehere');

      return "null";
    }else{

      return plan.firstPayment.substring(0,10);
    }
  }
    void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Message'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Delete'),
            onPressed: () {
         _delete(context, plan);
                Navigator.pop(context, true);
            },
          )
        ],
      ),
    );
  }
}
