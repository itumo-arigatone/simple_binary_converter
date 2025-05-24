import 'package:flutter/material.dart';
import 'package:simple_binary_converter/numbutton.dart';
import 'package:simple_binary_converter/mode_select_switch.dart';

class BinaryKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  const BinaryKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);
  @override
  _BinaryKeyPadState createState() => _BinaryKeyPadState();
}

class DecimalKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  const DecimalKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);
  @override
  _DecimalKeyPadState createState() => _DecimalKeyPadState();
}

class HexKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  const HexKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);
  @override
  _HexKeyPadState createState() => _HexKeyPadState();
}

class _BinaryKeyPadState extends State<BinaryKeyPad> {
  bool _switchStatus = true;
  void _setStatus() {
    setState(() {
      _switchStatus = !_switchStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String binary = "binary";
    NumButton button = NumButton(context, widget.onChangeInputData);
    ModeSwitch decimalMode =
        ModeSwitch(widget.setMode, "0", _switchStatus, _setStatus);
    ModeSwitch hexMode =
        ModeSwitch(widget.setMode, "1", !_switchStatus, _setStatus);
    return Container(
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 10),
              child: button.largeButton("0", binary),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 10),
              child: button.largeButton("1", binary),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 45),
                child: decimalMode,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 45),
                child: hexMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DecimalKeyPadState extends State<DecimalKeyPad> {
  bool _switchStatus = true;
  void _setStatus() {
    setState(() {
      _switchStatus = !_switchStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String decimal = "decimal";
    NumButton button = NumButton(context, widget.onChangeInputData);
    ModeSwitch binaryMode =
        ModeSwitch(widget.setMode, "2", _switchStatus, _setStatus);
    ModeSwitch hexMode =
        ModeSwitch(widget.setMode, "3", !_switchStatus, _setStatus);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("1", decimal),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("2", decimal),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("3", decimal),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("4", decimal),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("5", decimal),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("6", decimal),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("7", decimal),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("8", decimal),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("9", decimal),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: binaryMode,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("0", decimal),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: hexMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HexKeyPadState extends State<HexKeyPad> {
  bool _switchStatus = true;
  void _setStatus() {
    setState(() {
      _switchStatus = !_switchStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String hex = "hex";
    NumButton button = NumButton(context, widget.onChangeInputData);
    ModeSwitch binaryMode =
        ModeSwitch(widget.setMode, "4", _switchStatus, _setStatus);
    ModeSwitch decimalMode =
        ModeSwitch(widget.setMode, "5", !_switchStatus, _setStatus);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("a", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("b", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("c", hex),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("d", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("e", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("f", hex),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("1", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("2", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("3", hex),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("4", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("5", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("6", hex),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("7", hex),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("8", hex),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: button.numButton("9", hex),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: binaryMode,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("0", hex),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: decimalMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
