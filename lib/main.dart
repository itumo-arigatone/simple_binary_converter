import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Binary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _number = "";

  Text buttonStyle(String num) {
    return Text(
      num,
      style: TextStyle(
        fontSize: 35,
      ),
    );
  }

  ElevatedButton numButton(String num) {
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: num=="0"?_inputZero:_inputOne,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(80, 80), 
        primary: Colors.white,
        onPrimary: Colors.black,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 4,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  void _inputZero() {
    setState(() {
      _number += "0";
    });
  }
  void _inputOne() {
    setState(() {
      _number += "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Dismissible(
        key: Key('key'),
        direction: DismissDirection.up,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 150)),
            TextField(
              textAlign: TextAlign.center,
              enabled: true,
              controller: TextEditingController(
                text: '$_number',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0)),
                Padding(padding: EdgeInsets.only(top: 250)),
                numButton("0"),
                Padding(padding: EdgeInsets.only(left: 90)),
                numButton("1"),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
