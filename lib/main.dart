import 'package:flutter/material.dart';
import 'package:subcription_manager/screens/planList.dart';
import './screens/planList.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Country Picker Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PlanList(),
         routes: {
        '/home':(context)=>PlanList(),
        
        
      },
    );
  }
}



