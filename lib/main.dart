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

class Calculation {
  // 2 -> 16
  String ConvertBinaryToHex(binary) {
    String removeZero = binary.replaceAll(RegExp(r"^0*"), "");
    int num = int.parse(removeZero);
    for (int i=0;i<removeZero.length;i++) {
    }
    return binary;
  }
  // 2 -> 10
  String ConvertBinaryToDecimal(binary) {
    return binary;
  }

  //10 -> 2
  String ConvertDecimalToBinary(number) {
    int num = int.parse(number);
    return num.toRadixString(2);
  }

  //10->16
  String ConvertDecimalToHex(number) {
    int num = int.parse(number);
    return num.toRadixString(2);
  }

  // 16 -> 2
  String ConvertHexToBinary(hex) {
    int num = int.parse(hex);
    return num.toRadixString(2);
  }
  // 16 -> 10
  String ConvertHexToDecimal(hex) {
    int num = int.parse(hex);
    return num.toRadixString(2);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _number = "";
  String _convertResult = "";

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

  void _clearNum() {
    setState(() {
      _number = "";
    });
  }

  void _setResult(String result) {
    setState(() {
      _convertResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Calculation calculation = new Calculation();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Dismissible(
        key: Key('key'),
        direction: DismissDirection.vertical,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.up) {
            _clearNum();
          } else {
            _setResult(calculation.ConvertBinaryToHex("$_number"));
          }
          return; 
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.orange,
              child: Text(
                "$_convertResult",
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 70)),
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
