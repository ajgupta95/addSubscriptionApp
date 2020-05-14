import 'package:flutter/material.dart';
import 'dart:async';
import '../models/myPlan.dart';
import '../utils/databaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PlanDetail extends StatefulWidget {
  final Plan plan;

  PlanDetail(this.plan);

  @override
  _PlanDetailState createState() => _PlanDetailState(this.plan);
} 

class _PlanDetailState extends State<PlanDetail> {
  final formkey = GlobalKey<FormState>();
  var _selected;
  static var time = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  var every;
  var timePeriod = time[2];
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  Color colorForButton = Colors.white;
  

// ValueChanged<Color> callback
  void changeColor(Color color) {
    print('your color $color');
    plan.color=color;
    colorForButton = color;
    setState(() => pickerColor = color);
  }

  DatabaseHelper helper = DatabaseHelper();
  //String appBarTitle;
  Plan plan;

  _PlanDetailState(this.plan);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Add Subcription ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        Container(
          // width: 2,
          // height: 4,
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: CountryPicker(
                        showCurrency: true,
                        showFlag: false,
                        showName: false,
                        showCurrencyISO: true,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                            plan.currency=_selected.currencyISO;
                            print(_selected.currencyISO);
                          });
                        },
                        selectedCountry: _selected,
                      ),
                    ),

                    //  SizedBox(width: 10.0,),
                    Flexible(
                        child: TextFormField(
                      autofocus: true,
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
                  onSaved: (value) => plan.amount = value.trim(),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                TextFormField(
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
                  onSaved: (value) => plan.name = value.trim(),
                ),

                SizedBox(
                  height: 20.0,
                ),

                TextFormField(
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
                //TabBar(tabs: [Text('Recurring'),Text('One time')],)
                // TabBarView(children: <Widget>[
                //   Text('Recurring'),Text('One time'),
                // ],),
              ],
            ),
            // bottom:TabBar(tabs: null)
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 217),
            child: Divider(
              color: Colors.black,
              height: 50,
            )),
        Container(
          padding: EdgeInsets.only(top: 250.0, left: 10.0, right: 10.0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(text: "Recurring"),
                        Tab(text: "One Time"),
                        // Tab(text: "User"),
                      ]),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(children: [
                      Container(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                        child: Form(
                            child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                    child: TextFormField(
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
                                       validator: (value) =>
                      value.isEmpty ? 'This can\'t be empty' : null,
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
                                              plan.timePeriod=valueByUser;
                                            });
                                          }),
                                    )),
                              ],
                            ), //Row
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.only(
                                      bottom: 1.0, right: 20, left: 20),
                                  labelText: "First Payment(Optional)",
                                  hintText: "e.g. Today",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  )),
                                   
                          onSaved: (value) => plan.firstPayment = value.trim(),
                            )
                          ],
                        )),
                      ),

                      Container(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                        child: TextFormField(
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
                            
                  onSaved: (value) => plan.expiryDate = value.trim(),
                        ),
                      ),
                      // Container(
                      //   child: Text("User Body"),
                      // ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 425),
            child: Divider(
              color: Colors.black,
              height: 50,
            )),
        Container(
          padding: EdgeInsets.only(top: 458.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              RaisedButton(
                  padding: EdgeInsets.all(25),
                  color: colorForButton,
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
                height: 20.0,
              ),
              TextFormField(
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
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(12),
                  color: colorForButton,
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
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}
