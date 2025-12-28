import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

class DecimalKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;

  const DecimalKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);

  @override
  State<DecimalKeyPad> createState() => _DecimalKeyPadState();
}

class _DecimalKeyPadState extends State<DecimalKeyPad> {
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
      page: "decimal",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildNumButton("1"),
          layout.buildNumButton("2"),
          layout.buildNumButton("3"),
        ]),
        layout.buildRow([
          layout.buildNumButton("4"),
          layout.buildNumButton("5"),
          layout.buildNumButton("6"),
        ]),
        layout.buildRow([
          layout.buildNumButton("7"),
          layout.buildNumButton("8"),
          layout.buildNumButton("9"),
        ]),
        layout.buildRow([
          layout.buildModeSwitch(
            label: "to binary",
            isActive: _isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("2");
            },
          ),
          layout.buildNumButton("0"),
          layout.buildModeSwitch(
            label: "to hex",
            isActive: !_isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("3");
            },
          ),
        ]),
      ],
    );
  }
}
