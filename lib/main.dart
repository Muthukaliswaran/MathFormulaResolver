import 'package:flutter/material.dart';

import 'math_formula_convertor.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget{
  const HomeApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeAppState();
  }
}

class HomeAppState extends State<HomeApp>{

  @override
  void initState() {
    MathFormulaConvertor.mathFunc("add(1,2)").then((value){
      debugPrint("Math func-->> ${value ?? ""}");
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
        ),
      ),
    );
  }
}
