import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:simple_binary_converter/keypad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple binary converter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF0F0F3),
      ),
      home: const ConverterPage(),
    );
  }
}

// 変換ロジック
class Calculation {
  String convertBinaryToHex(String binary) {
    if (binary.isEmpty) return "0";
    String removeZero = binary.replaceAll(RegExp(r"^0*"), "");
    if (removeZero.isEmpty) return "0";
    BigInt deci = BigInt.parse(removeZero, radix: 2);
    return deci.toRadixString(16).toUpperCase();
  }

  String convertBinaryToDecimal(String binary) {
    if (binary.isEmpty) return "0";
    String removeZero = binary.replaceAll(RegExp(r"^0*"), "");
    if (removeZero.isEmpty) return "0";
    BigInt deci = BigInt.parse(removeZero, radix: 2);
    return deci.toRadixString(10);
  }

  String convertDecimalToBinary(String number) {
    if (number.isEmpty) return "0";
    BigInt num = BigInt.parse(number);
    return num.toRadixString(2);
  }

  String convertDecimalToHex(String number) {
    if (number.isEmpty) return "0";
    BigInt num = BigInt.parse(number);
    return num.toRadixString(16).toUpperCase();
  }

  String convertHexToBinary(String hex) {
    if (hex.isEmpty) return "0";
    BigInt num = BigInt.parse(hex, radix: 16);
    return num.toRadixString(2);
  }

  String convertHexToDecimal(String hex) {
    if (hex.isEmpty) return "0";
    BigInt num = BigInt.parse(hex, radix: 16);
    return num.toRadixString(10);
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _number = "";
  String _convertResult = "";
  String _convertMode = "1"; // デフォルト: 2進数 -> 16進数
  
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  final Calculation _calculation = Calculation();
  final PageController _pageController = PageController(initialPage: 0);

  // 入力桁数制限
  static const Map<String, int> _maxDigits = {
    "binary": 64,
    "decimal": 32,
    "hex": 32,
  };

  void _addInput(String input, String page) {
    final maxLength = _maxDigits[page] ?? 32;
    if (_number.length < maxLength) {
      setState(() {
        _number += input;
      });
    }
  }

  void _deleteLastInput() {
    if (_number.isNotEmpty) {
      setState(() {
        _number = _number.substring(0, _number.length - 1);
      });
    }
  }

  void _clearInput() {
    setState(() {
      _number = "";
      _convertResult = "";
    });
  }

  void _setConvertMode(String mode) {
    setState(() {
      _convertMode = mode;
    });
  }

  void _convert() {
    String result;
    switch (_convertMode) {
      case "0":
        result = _calculation.convertBinaryToDecimal(_number);
        break;
      case "1":
        result = _calculation.convertBinaryToHex(_number);
        break;
      case "2":
        result = _calculation.convertDecimalToBinary(_number);
        break;
      case "3":
        result = _calculation.convertDecimalToHex(_number);
        break;
      case "4":
        result = _calculation.convertHexToBinary(_number);
        break;
      case "5":
        result = _calculation.convertHexToDecimal(_number);
        break;
      default:
        result = "0";
    }
    setState(() {
      _convertResult = result;
    });
  }

  void _onPageChanged(int page) {
    final defaultModes = ["1", "3", "5"];
    _setConvertMode(defaultModes[page]);
    _clearInput();
  }

  void _copyToClipboard() {
    if (_convertResult.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _convertResult));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Copied!"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) return;

    final banner = BannerAd(
      size: size,
      request: const AdRequest(),
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    banner.load();
  }

  @override
  void dispose() {
    _anchoredBanner?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 広告バナー
            if (_anchoredBanner != null)
              SizedBox(
                width: _anchoredBanner!.size.width.toDouble(),
                height: _anchoredBanner!.size.height.toDouble(),
                child: AdWidget(ad: _anchoredBanner!),
              ),
            
            // メインコンテンツ
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  _buildConverterPanel(
                    panelKey: 'binary',
                    keypad: BinaryKeyPad(_addInput, _setConvertMode, currentMode: _convertMode),
                  ),
                  _buildConverterPanel(
                    panelKey: 'decimal',
                    keypad: DecimalKeyPad(_addInput, _setConvertMode, currentMode: _convertMode),
                  ),
                  _buildConverterPanel(
                    panelKey: 'hex',
                    keypad: HexKeyPad(_addInput, _setConvertMode, currentMode: _convertMode),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConverterPanel({required Widget keypad, required String panelKey}) {
    return Dismissible(
      key: ValueKey(panelKey),
      direction: DismissDirection.vertical,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.up) {
          // 上スワイプ: クリア
          _clearInput();
        } else {
          // 下スワイプ: 変換
          _convert();
        }
        return false; // 実際には削除しない
      },
      child: Container(
        color: const Color(0xFFF0F0F3),
        child: Column(
          children: [
            // 結果表示エリア
            _buildResultArea(),
            
            // 入力表示エリア
            _buildInputArea(),
            
            // キーパッド
            Expanded(
              child: Center(child: keypad),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultArea() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _convertResult,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: _copyToClipboard,
            tooltip: "Copy",
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text(
                _number.isEmpty ? " " : _number,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.backspace_outlined),
            onPressed: _deleteLastInput,
            tooltip: "Delete",
          ),
        ],
      ),
    );
  }
}
