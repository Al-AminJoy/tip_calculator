import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller=TextEditingController();
  final List<bool> _selection=[true,false,false];
  String tip='';
  void updateSelection(int selectedIndex){
    setState(() {
      for(int i=0;i<_selection.length;i++){
        _selection[i]=selectedIndex==i;
      }
    });
  }

  void calculateTip(){
    final totalAmount=double.parse(controller.text);
    final selectedIndex=_selection.indexWhere((element) => element);
    final tipPercentage=[.1,.15,.25][selectedIndex];
    final tipTotal=(totalAmount*tipPercentage).toStringAsFixed(2);
    setState(() {
      tip='\$$tipTotal';
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total Amount'),
              SizedBox(height: 20,),
              Container(
                width: 100,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '\$100',
                  ),
                ),
              ),
              ToggleButtons(children: [Text('10%'),Text('15%'),Text('25%')],
                  isSelected: _selection,
              onPressed: updateSelection,),
              TextButton(onPressed: calculateTip,
                  child: Text('Calculate',style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green
                ),
              ),
              Text('Total Tip : $tip')
            ],
          ),
        ),
      ),
    );
  }

}
