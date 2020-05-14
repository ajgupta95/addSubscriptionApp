import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selected;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Flutter Country Picker Demo'),
      ),
      body: new Center(
        child: CountryPicker(
          showCurrency: true,
         showFlag: false,
         showName: false,
          showCurrencyISO: true,
          
          onChanged: (Country country) {
            setState(() {
              _selected = country;
                        print(_selected.currencyISO);

            });
          },
          
          selectedCountry: _selected,
          
        ),
        
      ),
    );
  }
}

