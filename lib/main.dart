import 'package:flutter/material.dart';
//3.5 ->11:00
void main() {
  runApp(
      MaterialApp(
        title: 'Simple Interest Calculator App',
        home: STForm(),

      )
  );
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
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: Column(
            children: [
            getImageAsset(),

        Padding(
          padding: EdgeInsets.only(
              top: _minimumPadding, bottom: _minimumPadding),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter Principal e.g. 12000',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: _minimumPadding, bottom: _minimumPadding),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Rate of Interest',
                hintText: 'In percent',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
          ),
        ),

        Row(
          children: [
           Expanded(child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'Terms',
              hintText: 'Time in years',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        )) ,
        Expanded(child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
              color: Colors.deepPurple
          ),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
        )),
        ],
      ),


      ],
    ),)
    ,
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
}
