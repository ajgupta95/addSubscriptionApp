import 'package:flutter/material.dart';
import 'dart:async';
import 'package:subcription_manager/models/myPlan.dart';
import 'package:subcription_manager/utils/databaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PlanDetail extends StatefulWidget {
  final Plan plan;
    final String appBarTitle;

  PlanDetail(this.plan,this.appBarTitle);

  @override
  _PlanDetailState createState() => _PlanDetailState(this.plan,this.appBarTitle);
}

class _PlanDetailState extends State<PlanDetail>
    with SingleTickerProviderStateMixin {
  DatabaseHelper helper = DatabaseHelper();
  Plan plan;
    String appBarTitle;


  final formkey = GlobalKey<FormState>();

  static var time = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];

  var timePeriod = time[2];
  var planCurrency = "USD";
  var _selected;
  final format = DateFormat("yyyy-MM-dd");

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  Color colorForButton = Colors.white;

  void changeColor(Color color) {
    print('your color $color');

    colorForButton = color;
          plan.color = color.toString();

    plan.date = DateFormat.yMMMd().format(DateTime.now());
    setState(() {
      pickerColor = color;
      plan.color = color.toString();
      print(plan.color);
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController everyController = TextEditingController();
  TextEditingController firstPaymentController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  _PlanDetailState(this.plan,this.appBarTitle);

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
  
    inputValue();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          appBarTitle,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ), //appBar
      
      body: Container(
        padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
        child: Form(
          key: formkey,
          child:SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                SizedBox(height:5),
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: CountryPicker(
                       // showCurrency: true,
                        showFlag: false,
                        showName: false,
                        showCurrencyISO: true,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                            print(country.toString());
                            planCurrency = _selected.currencyISO;

                            print(_selected.currencyISO);
                            //  var currencyy ='INR';
                            //  updateCurrency(currencyy);
                            plan.currency = planCurrency;
                            print('herereerer');
                            print(plan.currency);
                          });
                          // plan.currency=_selected.currencyISO.toString();
                          // print(plan.currency);

                          //setCurrency();
                        },
                        selectedCountry: _selected,
                      ),
                    ),
                  //   SizedBox(
                  //  width: 30,
                  //   ),

                    //  SizedBox(width: 10.0,),
                    Flexible(
                        child: TextFormField(
                      controller: amountController,
                      //  autofocus: true,
                      decoration: InputDecoration(
                          contentPadding: new EdgeInsets.only(
                              bottom: 1.0, right: 20, left: 20),
                          labelText: "Enter amount",
                          hintText: "0.00",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          )),

                      validator: (value) =>
                          value.isEmpty ? 'Amount can\'t be empty' : null,
                      onSaved: (value) {
                        print('amount$value');
                        plan.amount = value.trim();
                      },
                    )
                    ),
                  ],
                ), //row
                SizedBox(
                  height: 30.0,
                ),

                TextFormField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          new EdgeInsets.only(bottom: 1.0, right: 20, left: 20),
                      labelText: "Name",
                      hintText: "e.g Netflix",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      )),
                  validator: (value) =>
                      value.isEmpty ? 'Name can\'t be empty' : null,
                  onSaved: (value) {
                  print('name$value');
                   plan.name = value.trim();
                  }
                ),

                SizedBox(
                  height: 30.0,
                ),

                TextFormField(
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      // contentPadding: new EdgeInsets.only(bottom: 1.0,right: 20,left: 20),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      labelText: "Description(Optional)",
                      hintText: "e.g Premium plan",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      )),
                  onSaved: (value) => plan.description = value.trim(),

                  // maxLines: 2,
                ),
                SizedBox(
                  height: 20.0,
                ),
                new Container(
                  // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _controller,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(text: "Recurring"),
                      Tab(text: "One Time"),
                    ],
                  ),
                ),
                Container(
                  height: 160,
                  child: TabBarView(controller: _controller, children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                  child: TextFormField(
                                controller: everyController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.only(
                                        bottom: 1.0, right: 20, left: 20),
                                    labelText: "Every",
                                    hintText: "1",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    )),
                                // validator: (value) =>
                                //     value.isEmpty ? 'This can\'t be empty' : null,
                                onSaved: (value) => plan.every = value.trim(),
                              )),
                              Flexible(
                                  child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    items: time.map((String dropDownItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownItem,
                                        child: Text(dropDownItem),
                                      );
                                    }).toList(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                    value: timePeriod,
                                    onChanged: (valueByUser) {
                                      setState(() {
                                        timePeriod = valueByUser;
                                        plan.timePeriod = timePeriod;
                                        print(timePeriod);
                                      });
                                    }),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //  Text('Select first payment date: '),
                          DateTimeField(
                            format: format,
                            controller: firstPaymentController,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                            decoration: InputDecoration(
                                contentPadding: new EdgeInsets.only(
                                    bottom: 1.0, right: 20, left: 20),
                                labelText: "First payment date",
                                //hintText: "1",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                )),
                            onSaved: (value) {
                                if(value==null){
                                  if(plan.firstPayment=="null"){
                                   return  plan.firstPayment="null";
                                  }
                                 
                                }else{
                                  plan.firstPayment=value.toString();
                                }
                                }
                               
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding:
                          EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                      child: TextFormField(
                        controller: expiryDateController,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.only(
                                bottom: 1.0, right: 20, left: 20),
                            labelText: "Expiry Date(Optional)",
                            hintText: "e.g. In a year",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            )),
                        onSaved: (value) {
                          plan.expiryDate = value.trim();
                          plan.timePeriod = '';
                        },
                      ),
                    ),
                    // Container(
                    //   child: Text("User Body"),
                    // ),
                  ]),
                ),
                RaisedButton(
                    padding: EdgeInsets.all(25),
                    color: hexToColor(plan.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      //   side: BorderSide(color: Colors.black),
                    ),
                    child: new Text(
                      "Choose a nice color",
                      // if (color==) {

                      // }
                      style: TextStyle(
                          color: colorForButton != Color(0xff000000)
                              ? Colors.black
                              : Colors.white),
                    ),
                    onPressed: () {
                      print('you clicked me');
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: const Text(
                            'Pick a color!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          content: SingleChildScrollView(
                            // child: ColorPicker(
                            //   pickerColor: pickerColor,
                            //   onColorChanged: changeColor,
                            //   showLabel: true,
                            //   pickerAreaHeightPercent: 0.8,
                            // ),
                            // Use Material color picker:

                            child: MaterialPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                              // showLabel: true, // only on portrait mode
                            ),

                            // Use Block color picker:
                            //
                            // child: BlockPicker(
                            //   pickerColor: currentColor,
                            //   onColorChanged: changeColor,
                            // ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                setState(() => currentColor = pickerColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: paymentMethodController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          new EdgeInsets.only(bottom: 1.0, right: 20, left: 20),
                      labelText: "Payment Method(Optional)",
                      hintText: "e.g. Credit Card",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      )),
                  onSaved: (value) => plan.paymentMethod = value.trim(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: noteController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      focusColor: Colors.grey,
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      labelText: "Note(Optional)",
                      hintText: "e.g. Bought through free coupan",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      )),
                  onSaved: (value) => plan.note = value.trim(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(12),
                  color: hexToColor(plan.color),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.save,
                          color: colorForButton != Color(0xff000000)
                              ? Colors.black
                              : Colors.white),
                      Text(
                        "Click to add",
                        // if (color==) {

                        // }
                        style: TextStyle(
                            color: colorForButton != Color(0xff000000)
                                ? Colors.black
                                : Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('you clicked for save');
                    _save();
                  },
                ),
                  SizedBox(
                  height: 400.0,
                ),
              ],
            ),
          ),
        ), //listview//form
      ),
    );
  }

inputValue(){
if(appBarTitle=="Edit Subscription"){
  amountController.text=plan.amount;
  nameController.text=plan.name;
    descriptionController.text=plan.description;
    everyController.text=plan.every;
    firstPaymentController.text=plan.firstPayment;
    paymentMethodController.text=plan.paymentMethod;
    expiryDateController.text=plan.expiryDate;
    paymentMethodController.text=plan.paymentMethod;
    noteController.text=plan.note;
}else{
  print('here');
}
}
 
 Color hexToColor(String code) {
    return new Color(int.parse(code.substring(6, 16)));
  }
  
  void moveToLastScreen() {
 Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);  }

  void _save() async {
    final form = formkey.currentState;
    if (form.validate()) {
      print('saving');
      print(nameController.text);
            print(amountController.text);

       form.save();
            print(plan.toMap());

      moveToLastScreen();

      plan.date = DateFormat.yMMMd().format(DateTime.now());
      int result;
      if (plan.id != null) {
        // Case 1: Update operation
        print('you hitted here');
        result = await helper.updatePlan(plan);
      } else {
        // Case 2: Insert Operation
        print('inserting');
        result = await helper.insertPlan(plan);
        
        var planMap = plan.toMap();
        print("Plan is$planMap");
        print("result is$result");
       
      }

      if (result != 0) {
        // Success
        _showAlertDialog('Status', 'Subscription Saved Successfully');
      } else {
        // Failure
        _showAlertDialog('Status', 'Problem Saving Subscription');
      }
    } else {
      print('form is not valid');
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
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              // moveToLastScreen();
            },
          )
        ],
      ),
    );
  }
}
