import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

class HexKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;

  const HexKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);

  @override
  State<HexKeyPad> createState() => _HexKeyPadState();
}

class _HexKeyPadState extends State<HexKeyPad> {
  bool _isBinaryMode = true;

  void _toggleMode() {
    setState(() {
      _isBinaryMode = !_isBinaryMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      onChangeInputData: widget.onChangeInputData,
      page: "hex",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildSmallNumButton("A"),
          layout.buildSmallNumButton("B"),
          layout.buildSmallNumButton("C"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("D"),
          layout.buildSmallNumButton("E"),
          layout.buildSmallNumButton("F"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("1"),
          layout.buildSmallNumButton("2"),
          layout.buildSmallNumButton("3"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("4"),
          layout.buildSmallNumButton("5"),
          layout.buildSmallNumButton("6"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("7"),
          layout.buildSmallNumButton("8"),
          layout.buildSmallNumButton("9"),
        ]),
        layout.buildRow([
          layout.buildSmallModeSwitch(
            label: "to binary",
            isActive: _isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("4");
            },
          ),
          layout.buildSmallNumButton("0"),
          layout.buildSmallModeSwitch(
            label: "to decimal",
            isActive: !_isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("5");
            },
          ),
        ]),
      ],
    );
  }
}
