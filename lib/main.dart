import "package:flutter/material.dart";
import "dart:math";
import 'package:flutter/services.dart';
import 'package:simple_binary_converter/keypad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:simple_binary_converter/copy_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ステータスバーの上部の変な半透明を消す
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
  );
  MobileAds.instance.initialize();
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
    int num = number==""?0:int.parse(number);
    return num.toRadixString(2);
  }

  //10->16
  String convertDecimalToHex(number) {
    int num = number==""?0:int.parse(number);
    return num.toRadixString(16);
  }

  // 16 -> 2
  String convertHexToBinary(hex) {
    int num = hex==""?0:int.parse("0x" + hex);
    return num.toRadixString(2);
  }

  // 16 -> 10
  String convertHexToDecimal(hex) {
    int num = hex==""?0:int.parse("0x" + hex);
    return num.toRadixString(10);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _number = "";
  String _convertResult = "";
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  static final AdRequest request = AdRequest();

  /*
  convertMode
  0: 2  -> 10
  1: 2  -> 16
  2: 10 -> 2
  3: 10 -> 16
  4: 16 -> 2
  5: 16 -> 10
  */
  String _convertMode = "1";

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

  void deleteInputData(String inputData) {
    setState(() {
      int length = inputData.length - 1;
      _number = length >= 0  ? inputData.substring(0, length) : _number;
    });
  }

  void _setConvertMode(String mode) {
    setState(() {
      _convertMode = mode;
    });
  }

  void _onPageChanged(int page) {
    if (page == 0) {
      _setConvertMode("1");
    } else if (page == 1) {
      _setConvertMode("3");
    } else {
      _setConvertMode("5");
    }
    _clearNum();
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BinaryKeyPad binaryKeypad = BinaryKeyPad(setInputData, _setConvertMode);
    DecimalKeyPad decimalKeypad = DecimalKeyPad(setInputData, _setConvertMode);
    HexKeyPad hexKeypad = HexKeyPad(setInputData, _setConvertMode);
    Calculation calculation = Calculation();
    final PageController controller = PageController(initialPage: 0);
    CopyButton copyButton = CopyButton();

    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
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
                    if (_anchoredBanner != null)
                      Container(
                        color: Colors.green,
                        width: _anchoredBanner!.size.width.toDouble(),
                        height: _anchoredBanner!.size.height.toDouble(),
                        child: AdWidget(ad: _anchoredBanner!),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: 100,
                        color: Colors.yellow,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  _convertResult,
                                  style: const TextStyle(fontSize: 30,),
                                ),
                              )
                            ),
                            Expanded(
                              flex: 1,
                              child: copyButton.copyButton(_convertResult),
                            ),
                          ]
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      width: 350,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              onChanged: _handleText,
                              controller: TextEditingController(
                                text: _number,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.backspace_outlined),
                            onPressed: () => deleteInputData(_number),
                          ),
                        ]
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        heightFactor: 0.8,
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
                    const Padding(padding: EdgeInsets.only(top: 40)),
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
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
      }),
    );
  }
}
