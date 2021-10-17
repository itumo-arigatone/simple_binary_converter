import "package:flutter/material.dart";
import "dart:math";
import 'package:simple_binary_convertor/keypad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
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
  String convertBinaryToHex(binary) {
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
  String convertBinaryToDecimal(binary) {
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
  String convertDecimalToBinary(number) {
    int num = int.parse(number);
    return num.toRadixString(2);
  }

  //10->16
  String convertDecimalToHex(number) {
    int num = int.parse(number);
    return num.toRadixString(16);
  }

  // 16 -> 2
  String convertHexToBinary(hex) {
    int num = int.parse("0x" + hex);
    return num.toRadixString(2);
  }

  // 16 -> 10
  String convertHexToDecimal(hex) {
    int num = int.parse("0x" + hex);
    return num.toRadixString(10);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _number = "";
  String _convertResult = "";

  /*
  convertMode
  0: 2  -> 10
  1: 2  -> 16
  2: 10 -> 2
  3: 10 -> 16
  4: 16 -> 2
  5: 16 -> 10
  */
  String _convertMode = "0";

  late BannerAd banner;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  Text buttonStyle(String num) {
    return Text(
      num,
      style: TextStyle(
        fontSize: 35,
      ),
    );
  }

  void _handleText(String e) {
    setState(() {
      _number = e;
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

  void setInputData(String inputData) {
    setState(() {
      _number += inputData;
    });
  }

  void _setConvertMode(String mode) {
    setState(() {
      _convertMode = mode;
    });
  }
  
  void _onPageChanged(int page) {
    _clearNum();
  }

  @override
  Widget build(BuildContext context) {
    BinaryKeyPad binaryKeypad = BinaryKeyPad(setInputData, _setConvertMode);
    DecimalKeyPad decimalKeypad = DecimalKeyPad(setInputData, _setConvertMode);
    HexKeyPad hexKeypad = HexKeyPad(setInputData, _setConvertMode);
    Calculation calculation = Calculation();
    final PageController controller = PageController(initialPage: 0);

    return PageView(
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Scaffold(
          body: Dismissible(
            key: const Key('key'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                if (_convertMode == "0") {
                  _setResult(calculation.convertBinaryToDecimal(_number));
                } else if (_convertMode == "1") {
                  _setResult(calculation.convertBinaryToHex(_number));
                }
              }
              return;
            },
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: AdWidget(ad: banner),
                ),
                Container(
                  height: 50,
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
                  enabled: false,
                  onChanged: _handleText,
                  controller: TextEditingController(
                    text: _number,
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    heightFactor: 0.4,
                    alignment: const FractionalOffset(0.5, 0.4),
                    child: binaryKeypad,
                  ),
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          body: Dismissible(
            key: const Key('key2'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                if (_convertMode == "2") {
                  _setResult(calculation.convertDecimalToBinary(_number));
                } else if (_convertMode == "3") {
                  _setResult(calculation.convertDecimalToHex(_number));
                }
              }
              return;
            },
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 70)),
                Container(
                  height: 70,
                  child: Text(
                    _convertResult,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
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
                    child: decimalKeypad,
                  ),
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          body: Dismissible(
            key: const Key('key3'),
            direction: DismissDirection.vertical,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.up) {
                _clearNum();
              } else {
                if (_convertMode == "4") {
                  _setResult(calculation.convertHexToBinary(_number));
                } else if (_convertMode == "5") {
                  _setResult(calculation.convertHexToDecimal(_number));
                }
              }
              return;
            },
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 70)),
                Container(
                  height: 70,
                  child: Text(
                    _convertResult,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    onChanged: _handleText,
                    controller: TextEditingController(
                      text: _number,
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    // alignment: const FractionalOffset(0.5, 0.7),
                    child: hexKeypad,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
