import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
