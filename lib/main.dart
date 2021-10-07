import 'dart:html';

import "package:flutter/material.dart";
import "dart:math";
import 'package:simple_binary_convertor/numbutton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple binary converter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Simple binary converter"),
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
    List<String> numArray = removeZero.split("");
    num deci = 0;
    for (int i = 0; i < numArray.length; i++) {
      deci += int.parse(numArray[i]) * pow(2, (numArray.length - i - 1));
    }
    deci as int;
    return deci.toRadixString(16);
  }

  // 2 -> 10
  String ConvertBinaryToDecimal(binary) {
    String removeZero = binary.replaceAll(RegExp(r"^0*"), "");
    List<String> numArray = removeZero.split("");
    num deci = 0;
    for (int i = 0; i < numArray.length; i++) {
      deci += int.parse(numArray[i]) * pow(2, (numArray.length - i - 1));
    }
    deci as int;
    return deci.toRadixString(10);
  }

  //10 -> 2
  String ConvertDecimalToBinary(number) {
    int num = int.parse(number);
    return num.toRadixString(2);
  }

  //10->16
  String ConvertDecimalToHex(number) {
    int num = int.parse(number);
    return num.toRadixString(16);
  }

  // 16 -> 2
  String ConvertHexToBinary(hex) {
    int num = int.parse("0x" + hex);
    return num.toRadixString(2);
  }

  // 16 -> 10
  String ConvertHexToDecimal(hex) {
    int num = int.parse("0x" + hex);
    return num.toRadixString(10);
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
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSize = smaller * 0.1;
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: () => _setNumber(num),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonSize, buttonSize),
        primary: Colors.white,
        onPrimary: Colors.black,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  void _handleText(String e) {
    setState(() {
      _number = e;
    });
  }

  void _setNumber(String recieveNum) {
    setState(() {
      _number += recieveNum;
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
    NumButton button = NumButton(context);
    Calculation calculation = Calculation();
    final PageController controller = PageController(initialPage: 0);

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Scaffold(
          body: Dismissible(
            key: Key('key'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                _setResult(calculation.ConvertBinaryToHex(_number));
              }
              return;
            },
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 70)),
                Container(
                  height: 50,
                  color: Colors.orange,
                  child: Text(
                    _convertResult,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: true,
                  onChanged: _handleText,
                  controller: TextEditingController(
                    text: _number,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 250)),
                      button.numButton("0"),
                      const Padding(padding: EdgeInsets.only(left: 90)),
                      numButton("1"),
                    ]),
              ],
            ),
          ),
        ),
        Scaffold(
          body: Dismissible(
            key: Key('key1'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                _setResult(calculation.ConvertDecimalToBinary(_number));
              }
              return;
            },
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 70)),
                Container(
                  height: 50,
                  color: Colors.orange,
                  child: Text(
                    _convertResult,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: true,
                    onChanged: _handleText,
                    controller: TextEditingController(
                      text: _number,
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    heightFactor: 0.72,
                    alignment: const FractionalOffset(0.5, 0.7),
                    child: Container(
                      color: Colors.orange,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("1"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("2"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("3"),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("4"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("5"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("6"),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: numButton("7"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: numButton("8"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: numButton("9"),
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: numButton("0"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          body: Dismissible(
            key: Key('key1'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                _setResult(calculation.ConvertHexToDecimal(_number));
              }
              return;
            },
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 70)),
                Container(
                  height: 50,
                  color: Colors.orange,
                  child: Text(
                    _convertResult,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: true,
                  onChanged: _handleText,
                  controller: TextEditingController(
                    text: _number,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("1"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("2"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("3"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("4"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("5"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("6"),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: numButton("7"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: numButton("8"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: numButton("9"),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: numButton("0"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
