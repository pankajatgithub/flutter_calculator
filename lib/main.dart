import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

//3.5 ->11:00
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: STForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,

      // textTheme: const TextTheme(
      //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      // ),
    ),
  ));
}

class STForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<STForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentitemSelected = '';
  var displayResult = "";

  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentitemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            // margin: EdgeInsets.all(_minimumPadding * 2),
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: [
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: principalController,
                    validator: (value){
                      if(value==null || value.isEmpty) {
                        return "Please enter valid rate of interest";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        hintText: 'Enter Principal e.g. 12000',
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize:15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: roiController,
                    validator: (value){
                      if(value==null || value.isEmpty) {
                        return "Please enter valid rate of interest";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        hintText: 'In percent',
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize:15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: termController,
                        validator:(value){
                          if(value==null || value.isEmpty) {
                            return "Please enter valid terms";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Terms',
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            hintText: 'Time in years',
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize:15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        value: _currentitemSelected,
                        // icon: const Icon(Icons.arrow_downward),
                        // iconSize: 24,
                        // elevation: 16,
                        style: Theme.of(context).textTheme.bodyText1,
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String? newValue) {
                          setState(() {

                              _currentitemSelected = newValue!;

                          });
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor, // background
                          onPrimary:
                              Theme.of(context).primaryColorDark, // foreground
                        ),
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
    if(_formKey.currentState!.validate()){
    displayResult = _calculateTotalReturns();}
                          });
                        },
                      )),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Theme.of(context).primaryColorDark, // background
                          onPrimary:
                              Theme.of(context).primaryColorLight, // foreground
                        ),
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        "After $term years,your investment will be worth $totalAmountPayable $_currentitemSelected";

    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentitemSelected = _currencies[0];
  }
}
